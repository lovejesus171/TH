//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "UO32H2O.h"

registerMooseObject("corrosionApp", UO32H2O);

InputParameters
UO32H2O::validParams()
{
  InputParameters params = Material::validParams();
  params.addCoupledVar("v",0,"Coupled Concentration");
  params.addCoupledVar("w",0,"Coupled Concentration");
  params.addRequiredParam<MaterialPropertyName>("Saturation1","Saturation");
  params.addRequiredParam<MaterialPropertyName>("Saturation2","Saturation");
  params.addRequiredParam<MaterialPropertyName>("k1","kinetic");
  params.addRequiredParam<MaterialPropertyName>("k2","kinetic");
  params.addRequiredParam<MaterialPropertyName>("k3","kinetic");
  params.addRequiredParam<MaterialPropertyName>("k4","kinetic");

  return params;
}

UO32H2O::UO32H2O(const InputParameters & parameters)
  : Material(parameters),
    _v(coupledValue("v")),
    _w(coupledValue("w")),
    _Sat1(getMaterialProperty<Real>("Saturation1")),
    _Sat2(getMaterialProperty<Real>("Saturation2")),
    _k1(getMaterialProperty<Real>("k1")),
    _k2(getMaterialProperty<Real>("k2")),
    _k3(getMaterialProperty<Real>("k3")),
    _k4(getMaterialProperty<Real>("k4")),


    // Declare that this material is going to have a Real
    // valued property named "diffusivity" that Kernels can use.
    _UO32H2O(declareProperty<Real>("UO32H2O")),

    // Retrieve/use an old value of diffusivity.
    // Note: this is _expensive_ - only do this if you REALLY need it!
    _UO32H2O_old(getMaterialPropertyOld<Real>("UO32H2O"))

    {
}

void
UO32H2O::initQpStatefulProperties()
{
		_UO32H2O[_qp] = _UO32H2O_old[_qp];
}

void
UO32H2O::computeQpProperties()
{
	if (_v[_qp] > _Sat1[_qp] && _w[_qp] > _Sat2[_qp])
		_UO32H2O[_qp] = _k1[_qp] * _v[_qp] +  _k2[_qp] * _w[_qp] - _k3[_qp] - _k4[_qp] + _UO32H2O_old[_qp];
	else if (_v[_qp] > _Sat1[_qp])
	 _UO32H2O[_qp] = _k1[_qp] * _v[_qp] -_k3[_qp] - _k4[_qp] + _UO32H2O_old[_qp];
	else if (_w[_qp] > _Sat2[_qp])
	 _UO32H2O[_qp] = _k2[_qp] * _w[_qp] - _k3[_qp] - _k4[_qp] + _UO32H2O_old[_qp];
	else
		_UO32H2O[_qp] = _UO32H2O_old[_qp];
}

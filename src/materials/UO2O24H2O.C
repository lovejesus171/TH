//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "UO2O24H2O.h"

registerMooseObject("corrosionApp", UO2O24H2O);

InputParameters
UO2O24H2O::validParams()
{
  InputParameters params = Material::validParams();
  params.addCoupledVar("v",0,"Coupled Concentration");
  params.addRequiredParam<MaterialPropertyName>("Saturation","Saturation");
  params.addRequiredParam<MaterialPropertyName>("k","kinetic");

  return params;
}

UO2O24H2O::UO2O24H2O(const InputParameters & parameters)
  : Material(parameters),
    _v(coupledValue("v")),
    _Sat(getMaterialProperty<Real>("Saturation")),
    _k(getMaterialProperty<Real>("k")),


    // Declare that this material is going to have a Real
    // valued property named "diffusivity" that Kernels can use.
    _UO2O24H2O(declareProperty<Real>("UO2O24H2O")),

    // Retrieve/use an old value of diffusivity.
    // Note: this is _expensive_ - only do this if you REALLY need it!
    _UO2O24H2O_old(getMaterialPropertyOld<Real>("UO2O24H2O"))

    {
}

void
UO2O24H2O::initQpStatefulProperties()
{
}

void
UO2O24H2O::computeQpProperties()
{
	if (_v[_qp] > _Sat[_qp])
	 _UO2O24H2O[_qp] = _k[_qp] * _v[_qp] + _UO2O24H2O_old[_qp];
	else
		_UO2O24H2O[_qp] = _UO2O24H2O_old[_qp];
}

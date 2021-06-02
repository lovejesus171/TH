//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "MT.h"

registerMooseObject("corrosionApp", MT);

InputParameters
MT::validParams()
{
  InputParameters params = Material::validParams();
  params.addCoupledVar("C1",0,"CO32-");
  params.addRequiredParam<Real>("Sat","dd");

  return params;
}

MT::MT(const InputParameters & parameters)
  : Material(parameters),
    _C1(coupledValue("C1")),
	_Sat(getParam<Real>("Sat")),


    // Declare that this material is going to have a Real
    // valued property named "diffusivity" that Kernels can use.
    _IAA(declareProperty<Real>("IAA")),

    // Retrieve/use an old value of diffusivity.
    // Note: this is _expensive_ - only do this if you REALLY need it!
    _IAA_old(getMaterialPropertyOld<Real>("IAA"))

    {
}

void
MT::initQpStatefulProperties()
{
}

void
MT::computeQpProperties()
{
	if (_C1[_qp] > _Sat)
	 _IAA[_qp] = 1E-3 * _C1[_qp] + _IAA_old[_qp];
	else
		_IAA[_qp] = _IAA_old[_qp];
}

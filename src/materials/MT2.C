//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "MT2.h"

registerMooseObject("corrosionApp", MT2);

InputParameters
MT2::validParams()
{
  InputParameters params = Material::validParams();
  params.addCoupledVar("C1",0,"CO32-");
  params.addRequiredParam<Real>("Sat","dd");

  return params;
}

MT2::MT2(const InputParameters & parameters)
  : Material(parameters),
    _C1(coupledValue("C1")),
	_Sat(getParam<Real>("Sat")),


    // Declare that this material is going to have a Real
    // valued property named "diffusivity" that Kernels can use.
    _FUCK(declareProperty<Real>("FUCK")),

    // Retrieve/use an old value of diffusivity.
    // Note: this is _expensive_ - only do this if you REALLY need it!
    _FUCK_old(getMaterialPropertyOld<Real>("FUCK"))

    {
}

void
MT2::initQpStatefulProperties()
{
}

void
MT2::computeQpProperties()
{
	_FUCK[_qp] = _Sat * _C1[_qp]  + _FUCK_old[_qp];
}

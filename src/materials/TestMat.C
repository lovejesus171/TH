//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "TestMat.h"

registerMooseObject("corrosionApp", TestMat);

InputParameters
TestMat::validParams()
{
  InputParameters params = Material::validParams();

  return params;
}

TestMat::TestMat(const InputParameters & parameters)
  : Material(parameters),
    _Ecorr(declareProperty<Real>("Ecorr")),
    _Ecorr_old(getMaterialPropertyOld<Real>("Ecorr"))

{
}

void
TestMat::initQpStatefulProperties()
{
   _Ecorr[_qp] = _Ecorr_old[_qp];
}

void
TestMat::computeQpProperties()
{
   _Ecorr[_qp] = _Ecorr[_qp] + 1;
}

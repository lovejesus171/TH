//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "SEF4.h"

registerMooseObject("corrosionApp", SEF4);

InputParameters
SEF4::validParams()
{
  InputParameters params = ADKernel::validParams();
  params.addClassDescription("This kernel solve nernst-planck terms and should be combined with poisson term (diffusion)");
  params.addCoupledVar("CS1", 0,"Add name of chemical species");
  params.addCoupledVar("CS2", 0,"Add name of chemical species");
  params.addCoupledVar("CS3", 0,"Add name of chemical species");
  params.addCoupledVar("CS4", 0,"Add name of chemical species");
  params.addCoupledVar("CS5", 0,"Add name of chemical species");
  params.addCoupledVar("CS6", 0,"Add name of chemical species");
  params.addParam<Real>("Charge1",0.0, "Charge valence of chemical species");
  params.addParam<Real>("Charge2",0.0, "Charge valence of chemical species");
  params.addParam<Real>("Charge3",0.0, "Charge valence of chemical species");
  params.addParam<Real>("Charge4",0.0, "Charge valence of chemical species");
  params.addParam<Real>("Charge5",0.0, "Charge valence of chemical species");
  params.addParam<Real>("Charge6",0.0, "Charge valence of chemical species");



  params.addParam<Real>("Permittivity",1.0,"Permittivity by fixed space charge, unit: F/m, 1F = 1C/V F is not a faraday constant, F is called farad");
  return params;
}

SEF4::SEF4(const InputParameters & parameters)
  : ADKernel(parameters),
    _C1(adCoupledValue("CS1")),
    _C2(adCoupledValue("CS2")),
    _C3(adCoupledValue("CS3")),
    _C4(adCoupledValue("CS4")),
    _C5(adCoupledValue("CS5")),
    _C6(adCoupledValue("CS6")),
    _z1(getParam<Real>("Charge1")),
    _z2(getParam<Real>("Charge2")),
    _z3(getParam<Real>("Charge3")),
    _z4(getParam<Real>("Charge4")),
    _z5(getParam<Real>("Charge5")),
    _z6(getParam<Real>("Charge6")),
    _Perm(getParam<Real>("Permittivity")),
    _F(96485)
{
}

ADReal
SEF4::computeQpResidual()
{
  return (_z1  *  _C1[_qp] + _z2 * _C2[_qp] + _z3 * _C3[_qp] + _z4 * _C4[_qp] + _z5 * _C5[_qp] + _z6 * _C6[_qp]) * _F * _test[_i][_qp] -  _Perm * _grad_test[_i][_qp] * _grad_u[_qp];
}

//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "UO2precip.h"

#include <algorithm>
#include <limits>

registerMooseObject("MooseApp", UO2precip);

defineLegacyParams(UO2precip);

InputParameters
UO2precip::validParams()
{
  InputParameters params = NodalVariablePostprocessor::validParams();
  params.addClassDescription("Computes the maximum (over all the nodal values) of a variable.");
  params.addRequiredCoupledVar("v","The name of the variable to judge degree of saturation.");
  params.addRequiredCoupledVar("x","The name of the variable to judge degree of saturation.");
  params.addRequiredCoupledVar("y","The name of the variable to judge degree of saturation.");
//  params.addRequiredParam<MaterialPropertyName>("Saturation","The name of saturation parameter");
//  params.addRequiredParam<MaterialPropertyName>("k1","Reaction constant");
  params.addParam<Real>("k3","Kinetic constant2");
  params.addParam<Real>("k4","Kinetic constant2");
  return params;
}

UO2precip::UO2precip(const InputParameters & parameters)
  : NodalVariablePostprocessor(parameters),
        _v(coupledValue("v")),
        _x(coupledValue("x")),
        _y(coupledValue("y")),
	_k3(getParam<Real>("k3")),
	_k4(getParam<Real>("k4"))
//    _Cs(getMaterialProperty<Real>("Saturation")),
//    _k1(getMaterialProperty<Real>("k1"))
{
}

void
UO2precip::initialize()
{
}

void
UO2precip::execute()
{
      	_value = _k3 * _x[_qp] * _v[_qp] + _k4 * _y[_qp] * _v[_qp];
}

Real
UO2precip::getValue()
{
  return _value;
}

void
UO2precip::threadJoin(const UserObject & y)
{
}

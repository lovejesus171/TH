//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "PT.h"

#include <algorithm>
#include <limits>

registerMooseObject("MooseApp", PT);

defineLegacyParams(PT);

InputParameters
PT::validParams()
{
  InputParameters params = NodalVariablePostprocessor::validParams();
  params.addClassDescription("Computes the maximum (over all the nodal values) of a variable.");
  params.addRequiredCoupledVar("v","The name of the variable to judge degree of saturation.");
//  params.addRequiredParam<MaterialPropertyName>("Saturation","The name of saturation parameter");
//  params.addRequiredParam<MaterialPropertyName>("k1","Reaction constant");
  params.addParam<Real>("Saturation1","Saturation concentration");
  params.addParam<Real>("Saturation2","Saturation concentration");
  params.addParam<Real>("k1","Kinetic constant1");
  params.addParam<Real>("k2","Kinetic constant2");
  params.addParam<Real>("k3","Kinetic constant2");
  params.addParam<Real>("k4","Kinetic constant2");
  return params;
}

PT::PT(const InputParameters & parameters)
  : NodalVariablePostprocessor(parameters),
        _v(coupledValue("v")),
	_Sat1(getParam<Real>("Saturation1")),
	_Sat2(getParam<Real>("Saturation2")),
	_k1(getParam<Real>("k1")),
	_k2(getParam<Real>("k2")),
	_k3(getParam<Real>("k3")),
	_k4(getParam<Real>("k4"))
//    _Cs(getMaterialProperty<Real>("Saturation")),
//    _k1(getMaterialProperty<Real>("k1"))
{
}

void
PT::initialize()
{
}

void
PT::execute()
{
	if (_u[_qp] > _Sat1 && _v[_qp] > _Sat2)
      	_value = _k1 * (_u[_qp] - _Sat1) + _k2 * (_v[_qp] - _Sat2) - _k3 - _k4;
	else if (_u[_qp] > _Sat1)
		_value = _k1 * (_u[_qp] - _Sat1) - _k3;
	else if (_v[_qp] > _Sat2)
		_value = _k2 * (_v[_qp] - _Sat2) - _k4;
	else
		_value = 0;
}

Real
PT::getValue()
{
  return _value;
}

void
PT::threadJoin(const UserObject & y)
{
}

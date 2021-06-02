//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "Fe2O3.h"

#include <algorithm>
#include <limits>

registerMooseObject("MooseApp", Fe2O3);

defineLegacyParams(Fe2O3);

InputParameters
Fe2O3::validParams()
{
  InputParameters params = NodalVariablePostprocessor::validParams();
  params.addClassDescription("Computes the maximum (over all the nodal values) of a variable.");
  params.addRequiredCoupledVar("v","The name of the variable to judge degree of saturation.");
  params.addRequiredCoupledVar("w","The name of the variable to judge degree of saturation.");
  params.addRequiredCoupledVar("x","The name of the variable to judge degree of saturation.");
  params.addRequiredCoupledVar("y","The name of the variable to judge degree of saturation.");
//  params.addRequiredParam<MaterialPropertyName>("Saturation","The name of saturation parameter");
//  params.addRequiredParam<MaterialPropertyName>("k1","Reaction constant");
  params.addParam<Real>("k1","Kinetic constant1");
  params.addParam<Real>("k2","Kinetic constant2");
  params.addParam<Real>("k3","Kinetic constant2");
  params.addParam<Real>("k4","Kinetic constant2");
  return params;
}

Fe2O3::Fe2O3(const InputParameters & parameters)
  : NodalVariablePostprocessor(parameters),
        _v(coupledValue("v")),
        _w(coupledValue("w")),
        _x(coupledValue("x")),
        _y(coupledValue("y")),
	_k1(getParam<Real>("k1")),
	_k2(getParam<Real>("k2")),
	_k3(getParam<Real>("k3")),
	_k4(getParam<Real>("k4"))
//    _Cs(getMaterialProperty<Real>("Saturation")),
//    _k1(getMaterialProperty<Real>("k1"))
{
}

void
Fe2O3::initialize()
{
}

void
Fe2O3::execute()
{
      	_value = _k1 * _u[_qp] * _v[_qp] + _k2 * _w[_qp] * _v[_qp] + _k3 * _x[_qp] * _v[_qp] + _k4 * _y[_qp] * _v[_qp];
}

Real
Fe2O3::getValue()
{
  return _value;
}

void
Fe2O3::threadJoin(const UserObject & y)
{
}

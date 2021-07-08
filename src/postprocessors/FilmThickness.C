//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "FilmThickness.h"

registerMooseObject("corrosionApp", FilmThickness);

defineLegacyParams(FilmThickness);

InputParameters
FilmThickness::validParams()
{
  InputParameters params = ElementIntegralPostprocessor::validParams();
  params.addRequiredCoupledVar("variable", "The name of the variable that this object operates on");
  params.addRequiredParam<Real>("Density","Put Cu2S density");
  params.addClassDescription("Computes a film thickness of Cu2S in m unit");
  return params;
}

FilmThickness::FilmThickness(
    const InputParameters & parameters)
  : ElementIntegralPostprocessor(parameters),
    MooseVariableInterface<Real>(this,
                                 false,
                                 "variable",
                                 Moose::VarKindType::VAR_ANY,
                                 Moose::VarFieldType::VAR_FIELD_STANDARD),
    _u(coupledValue("variable")),
    _Density(getParam<Real>("Density")),
    _grad_u(coupledGradient("variable"))
{
  addMooseVariableDependency(&mooseVariableField());
}

Real
FilmThickness::computeQpIntegral()
{
  return _u[_qp] / _Density;
}

//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "EcorrBC.h"

registerMooseObject("corrosionApp", EcorrBC);

defineLegacyParams(EcorrBC);

InputParameters
EcorrBC::validParams()
{
  InputParameters params = DirichletBCBase::validParams();
  params.addRequiredCoupledVar("value", "Value of the BC");
  params.addClassDescription("Imposes the essential boundary condition $u=g$, where $g$ "
                             "is a constant, controllable value.");
  return params;
}

EcorrBC::EcorrBC(const InputParameters & parameters)
  : DirichletBCBase(parameters),
    _value(coupledValue("value"))
{
}

Real
EcorrBC::computeQpValue()
{
  return _value[_qp];
}

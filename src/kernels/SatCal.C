//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "SatCal.h"

registerMooseObject("corrosionApp", SatCal);

InputParameters
SatCal::validParams()
{
  InputParameters params = ADKernel::validParams();
  params.addClassDescription("This kernel calculates the saturation");
  params.addRequiredCoupledVar("q", "Heat flux");
  return params;
}

SatCal::SatCal(const InputParameters & parameters)
  : ADKernel(parameters),
    _q(adCoupledValue("q")),
    _h_we(2300000)
{
}

ADReal
SatCal::computeQpResidual()
{
  return _q[_qp] / _h_we;
}

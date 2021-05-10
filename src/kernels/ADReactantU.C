//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "ADReactantU.h"

registerMooseObject("corrosionApp", ADReactantU);

template <>
InputParameters
validParams<ADReactantU>()
{
  InputParameters params = validParams<ADKernel>();


  return params;
}

ADReactantU::ADReactantU(const InputParameters & parameters)
  : ADKernel(parameters)
{
}



ADReal
ADReactantU::computeQpResidual()
{
   return 0.0;
}

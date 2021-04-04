//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "Mimic.h"

registerMooseObject("corrosionApp", Mimic);

template <>
InputParameters
validParams<Mimic>()
{
  InputParameters params = validParams<AuxKernel>();
  params.addCoupledVar("C1",0,"Mimicking concentration");
  return params;
}

Mimic::Mimic(const InputParameters & parameters)
  : AuxKernel(parameters),
    _C1(coupledValue("C1"))
{
}

/**
 * Auxiliary Kernels override computeValue() instead of computeQpResidual().  Aux Variables
 * are calculated either one per elemenet or one per node depending on whether we declare
 * them as "Elemental (Constant Monomial)" or "Nodal (First Lagrange)".  No changes to the
 * source are necessary to switch from one type or the other.
 */
Real
Mimic::computeValue()
{
  return _C1[_qp];
}

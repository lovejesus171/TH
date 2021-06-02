//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "AuxPre2.h"

registerMooseObject("corrosionApp", AuxPre2);

template <>
InputParameters
validParams<AuxPre2>()
{
  InputParameters params = validParams<AuxKernel>();
  params.addRequiredCoupledVar("v", "The variable whose value we are to match.");
  return params;
}

AuxPre2::AuxPre2(const InputParameters & parameters)
  : AuxKernel(parameters),
    _v(coupledValue("v")),
    _v_old(coupledValueOld("v"))
{
}

/**
 * Auxiliary Kernels override computeValue() instead of computeQpResidual().  Aux Variables
 * are calculated either one per elemenet or one per node depending on whether we declare
 * them as "Elemental (Constant Monomial)" or "Nodal (First Lagrange)".  No changes to the
 * source are necessary to switch from one type or the other.
 */
Real
AuxPre2::computeValue()
{
	  return _v[_qp] + _v_old[_qp];
}

//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "AuxPre.h"

registerMooseObject("corrosionApp", AuxPre);

template <>
InputParameters
validParams<AuxPre>()
{
  InputParameters params = validParams<AuxKernel>();
  params.addRequiredCoupledVar("v", "The variable whose value we are to match.");
  params.addParam<Real>("k","Kinetic constant");
  params.addParam<Real>("Sign","Kinetic constant");
  return params;
}

AuxPre::AuxPre(const InputParameters & parameters)
  : AuxKernel(parameters),
    _v(coupledValue("v")),
    _v_old(coupledValueOld("v")),
    _k(getParam<Real>("k")),
    _Sign(getParam<Real>("Sign"))
{
}

/**
 * Auxiliary Kernels override computeValue() instead of computeQpResidual().  Aux Variables
 * are calculated either one per elemenet or one per node depending on whether we declare
 * them as "Elemental (Constant Monomial)" or "Nodal (First Lagrange)".  No changes to the
 * source are necessary to switch from one type or the other.
 */
Real
AuxPre::computeValue()
{
	  return  _Sign * _k * _v[_qp];
}

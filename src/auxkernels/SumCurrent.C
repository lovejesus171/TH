//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "SumCurrent.h"

registerMooseObject("corrosionApp", SumCurrent);

template <>
InputParameters
validParams<SumCurrent>()
{
  InputParameters params = validParams<AuxKernel>();
  params.addCoupledVar("AnodicCurrent",0,"Anodic");
  params.addCoupledVar("CathodicCurrent",0,"Cathodic");
  return params;
}

SumCurrent::SumCurrent(const InputParameters & parameters)
  : AuxKernel(parameters),
    _ia(coupledValue("AnodicCurrent")),
    _ic(coupledValue("CathodicCurrent"))
{
}

/**
 * Auxiliary Kernels override computeValue() instead of computeQpResidual().  Aux Variables
 * are calculated either one per elemenet or one per node depending on whether we declare
 * them as "Elemental (Constant Monomial)" or "Nodal (First Lagrange)".  No changes to the
 * source are necessary to switch from one type or the other.
 */
Real
SumCurrent::computeValue()
{

  return  _ia[_qp] + _ic[_qp] ;

}

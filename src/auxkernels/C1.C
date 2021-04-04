//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "C1.h"

registerMooseObject("corrosionApp", C1);

template <>
InputParameters
validParams<C1>()
{
  InputParameters params = validParams<AuxKernel>();
  params.addRequiredCoupledVar("cs", "Concentration solid");
  params.addRequiredCoupledVar("cl","Concentration liquid");
  params.addParam<std::vector<MaterialPropertyName>>("h",std::vector<MaterialPropertyName>(),"Material property");
  return params;
}

C1::C1(const InputParameters & parameters)
  : AuxKernel(parameters),
    _cs(coupledValue("cs")),
    _cl(coupledValue("cl")),
    _h(getMaterialProperty<Real>("h"))
{
}

/**
 * Auxiliary Kernels override computeValue() instead of computeQpResidual().  Aux Variables
 * are calculated either one per elemenet or one per node depending on whether we declare
 * them as "Elemental (Constant Monomial)" or "Nodal (First Lagrange)".  No changes to the
 * source are necessary to switch from one type or the other.
 */
Real
C1::computeValue()
{
  return  _h[_qp] * _cs[_qp] + (1 - _h[_qp]) * _cl[_qp];
}

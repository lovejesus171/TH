//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "Test.h"

registerMooseObject("corrosionApp", Test);

template <>
InputParameters
validParams<Test>()
{
  InputParameters params = validParams<AuxKernel>();
  params.addRequiredCoupledVar("Reactant", "The variable whose value we are to match.");
  params.addParam<Real>("Reaction_order","Reaction order parameters");
  params.addParam<Real>("AlphaE","Transfer coefficient, unitless");
  params.addParam<Real>("AlphaS","Transfer coefficient, unitless");
  params.addParam<Real>("AlphaS12","Transfer coefficient, unitless");
  params.addParam<Real>("AlphaS3","Transfer coefficient, unitless");
  params.addParam<Real>("PotentialE","Standard potential of reaction, V");
  params.addParam<Real>("PotentialS12","Standard potential of reaction, V");
  params.addParam<Real>("PotentialE3","Standard potential of reaction, V");
  params.addParam<Real>("CoefE","Number of electron participate in reaction");
  params.addParam<Real>("CoefS","Number of electron participate in reaction");
  params.addParam<Real>("Kinetic_coefE","Kinetic constant");
  params.addParam<Real>("Kinetic_coefS","Kinetic constant");
  return params;
}

Test::Test(const InputParameters & parameters)
  : AuxKernel(parameters),
    _C(coupledValue("Reactant")),
    _m(getParam<Real>("Reaction_order")),
    _aE(getParam<Real>("AlphaE")),
    _aS(getParam<Real>("AlphaS")),
    _aS12(getParam<Real>("AlphaS12")),
    _aS3(getParam<Real>("AlphaS3")),
    _EE(getParam<Real>("PotentialE")),
    _ES12(getParam<Real>("PotentialS12")),
    _E3(getParam<Real>("PotentialE3")),
    _nE(getParam<Real>("CoefE")),
    _nS(getParam<Real>("CoefS")),
    _kE(getParam<Real>("Kinetic_coefE")),
    _kS(getParam<Real>("Kinetic_coefS"))
{
}

/**
 * Auxiliary Kernels override computeValue() instead of computeQpResidual().  Aux Variables
 * are calculated either one per elemenet or one per node depending on whether we declare
 * them as "Elemental (Constant Monomial)" or "Nodal (First Lagrange)".  No changes to the
 * source are necessary to switch from one type or the other.
 */
Real
Test::computeValue()
{
  return  1/(1 + _aE + _aS)* (_aE * _EE + _ES12 + _aS3 * _E3 - 8.314 * 298.15 / 96485 * log10(_nS * _kS / (_nE * _kE)*_C[_qp])) ;
}

//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "AuxCu2S.h"

registerMooseObject("corrosionApp", AuxCu2S);

template <>
InputParameters
validParams<AuxCu2S>()
{
  InputParameters params = validParams<AuxKernel>();

  params.addParam<Real>("Faraday_constant",96485.3329,"Faraday constants, C/mol");
  params.addRequiredParam<MaterialPropertyName>("Area","Porosity of porous medium");
  params.addParam<Real>("Kinetic",1.0,"Kinetic constant");
  params.addParam<Real>("AlphaS",0.5,"transfer coefficient");
  params.addRequiredParam<MaterialPropertyName>("Corrosion_potential","Corrosion potential");
  params.addParam<Real>("R",8.314,"Reaction order");
  params.addCoupledVar("Temperature",298.15,"Temperature of the system");
  params.addParam<Real>("AlphaS3",0.5,"Transfer coefficient");
  params.addParam<Real>("Standard_potential2",0.0,"Standard_potential");
  params.addParam<Real>("Standard_potential3",0.0,"Standard_potentia3");
  params.addParam<Real>("Num",1,"Number of produced or consumed chemical species per reaction");
  params.addRequiredCoupledVar("Reactant1","HS- anions");

  return params;
}

AuxCu2S::AuxCu2S(const InputParameters & parameters)
  : AuxKernel(parameters),
   _F(getParam<Real>("Faraday_constant")),
   _eps(getMaterialProperty<Real>("Area")),
   _kS(getParam<Real>("Kinetic")),
   _aS(getParam<Real>("AlphaS")),
   _E(getMaterialProperty<Real>("Corrosion_potential")),
   _R(getParam<Real>("R")),
   _T(coupledValue("Temperature")),
   _aS3(getParam<Real>("AlphaS3")),
   _ES12(getParam<Real>("Standard_potential2")),
   _ES3(getParam<Real>("Standard_potential3")),
   _Num(getParam<Real>("Num")),
   _C1(coupledValue("Reactant1"))
{
}

/**
 * Auxiliary Kernels override computeValue() instead of computeQpResidual().  Aux Variables
 * are calculated either one per elemenet or one per node depending on whether we declare
 * them as "Elemental (Constant Monomial)" or "Nodal (First Lagrange)".  No changes to the
 * source are necessary to switch from one type or the other.
 */
Real
AuxCu2S::computeValue()
{
return -_Num * _eps[_qp] * _kS * _C1[_qp] * _C1[_qp] * exp((1.0 + _aS) * _F /(_R * _T[_qp]) * _E[_qp]) * exp(-_F/(_R * _T[_qp]) * (_ES12 + _aS3 * _ES3));
}

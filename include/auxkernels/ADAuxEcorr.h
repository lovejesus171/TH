//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "AuxKernel.h"

#include "metaphysicl/raw_type.h"
// Forward Declarations
class ADAuxEcorr;

template <>
InputParameters validParams<ADAuxEcorr>();

/**
 * Coupled auxiliary value
 */
class ADAuxEcorr : public AuxKernel
{
public:
  /**
   * Factory constructor, takes parameters so that all derived classes can be built using the same
   * constructor.
   */
  ADAuxEcorr(const InputParameters & parameters);

protected:
  virtual Real computeValue() override;

  Real _aS;
  Real _aC;
  Real _aD;
  Real _aE;
  Real _aF;
  Real _aS3;

  Real _EA;
  Real _ES12;
  Real _ES3;
  Real _EC;
  Real _ED;
  Real _EE;
  Real _EF;
  
  Real _nA;
  Real _nD;
  Real _nE;
  Real _nF;
  Real _nO;
  Real _nS;

  Real _kA;
  Real _kC;
  Real _kD;
  Real _kE;
  Real _kS;
  Real _kF;
  Real _kBB;

  Real _Porosity;

  Real _Tol;
  Real _Ecorr;
  Real _DelE;

  Real _Area;
  
  Real _AnodeAreaValue;

  const ADVariableValue & _T;
  const ADVariableValue & _C9;
  const ADVariableValue & _C1;
  const ADVariableValue & _C0;
  const ADVariableValue & _C3;
  const ADVariableValue & _C6;


};


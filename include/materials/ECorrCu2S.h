//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "Material.h"

/**
 * Stateful material class that defines a few properties.
 */
class ECorrCu2S : public Material
{
public:
  static InputParameters validParams();

  ECorrCu2S(const InputParameters & parameters);

protected:
  virtual void initQpStatefulProperties();
  virtual void computeQpProperties();

private:

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
  Real _DelE;

  Real _Area;

  /**
   * Create two MooseArray Refs to hold the current
   * and previous material properties respectively
   */
  MaterialProperty<Real> & _ISS;
  const MaterialProperty<Real> & _ISS_old;
  MaterialProperty<Real> & _IEE;
  const MaterialProperty<Real> & _IEE_old;
  MaterialProperty<Real> & _IAA;
  const MaterialProperty<Real> & _IAA_old;
  MaterialProperty<Real> & _IFF;
  const MaterialProperty<Real> & _IFF_old;
  MaterialProperty<Real> & _Isum;
  const MaterialProperty<Real> & _Isum_old;

  Real _AnodeAreaValue;
  MaterialProperty<Real> & _AnodeArea;

  const VariableValue & _T;
  const VariableValue & _C9;
  const VariableValue & _C1;
  const VariableValue & _C0;
  const VariableValue & _C3;
  const VariableValue & _C6;
  const VariableValue & _Cu2SVar;

  MaterialProperty<Real> & _Ecorr;
  const MaterialProperty<Real> & _Ecorr_old;
  MaterialProperty<Real> & _Cu2SMat;

};

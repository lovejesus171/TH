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
class HandUO2_Debug : public Material
{
public:
  static InputParameters validParams();

  HandUO2_Debug(const InputParameters & parameters);

protected:
  virtual void initQpStatefulProperties();
  virtual void computeQpProperties();

private:

  Real _aA;
  Real _aB;
  Real _aC;
  Real _aD;
  Real _aE;
  Real _aF;
  Real _aG;
  Real _aH;
  Real _aI;
  Real _aJ;
  Real _aK;

  Real _EA;
  Real _EB;
  Real _EC;
  Real _ED;
  Real _EE;
  Real _EF;
  Real _EG;
  Real _EH;
  Real _EI;
  Real _EJ;
  Real _EK;
  
  Real _nA;
  Real _nB;
  Real _nC;
  Real _nD;
  Real _nE;
  Real _nF;
  Real _nG;
  Real _nH;
  Real _nI;
  Real _nJ;
  Real _nK;

  Real _kA;
  Real _kB;
  Real _kC;
  Real _kD;
  Real _kE;
  Real _kF;
  Real _kG;
  Real _kH;
  Real _kI;
  Real _kJ;
  Real _kK;

  Real _eps;
  Real _f;
  Real _DelH;

  Real _Tol;
  Real _DelE;


  /**
   * Create two MooseArray Refs to hold the current
   * and previous material properties respectively
   */
  MaterialProperty<Real> & _IAA;
  const MaterialProperty<Real> & _IAA_old;
  MaterialProperty<Real> & _IBB;
  const MaterialProperty<Real> & _IBB_old;
  MaterialProperty<Real> & _ICC;
  const MaterialProperty<Real> & _ICC_old;
  MaterialProperty<Real> & _IDD;
  const MaterialProperty<Real> & _IDD_old;
  MaterialProperty<Real> & _IEE;
  const MaterialProperty<Real> & _IEE_old;
  MaterialProperty<Real> & _IFF;
  const MaterialProperty<Real> & _IFF_old;
  MaterialProperty<Real> & _IGG;
  const MaterialProperty<Real> & _IGG_old;
  MaterialProperty<Real> & _IHH;
  const MaterialProperty<Real> & _IHH_old;
  MaterialProperty<Real> & _III;
  const MaterialProperty<Real> & _III_old;
  MaterialProperty<Real> & _IJJ;
  const MaterialProperty<Real> & _IJJ_old;
  MaterialProperty<Real> & _IKK;
  const MaterialProperty<Real> & _IKK_old;

  MaterialProperty<Real> & _Isum;
  const MaterialProperty<Real> & _Isum_old;

  const VariableValue & _T;
  const VariableValue & _C1;
  const VariableValue & _C2;
  const VariableValue & _C3;
  const VariableValue & _C4;

  MaterialProperty<Real> & _Ecorr;
  const MaterialProperty<Real> & _Ecorr_old;

};

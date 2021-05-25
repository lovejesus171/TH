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
class NoInitUO2Potential : public Material
{
public:
  static InputParameters validParams();

  NoInitUO2Potential(const InputParameters & parameters);

protected:
  virtual void initQpStatefulProperties();
  virtual void computeQpProperties();

private:

  const MaterialProperty<Real> & _aA;
  const MaterialProperty<Real> & _aB;
  const MaterialProperty<Real> & _aC;
  const MaterialProperty<Real> & _aD;
  const MaterialProperty<Real> & _aE;
  const MaterialProperty<Real> & _aF;
  const MaterialProperty<Real> & _aG;
  const MaterialProperty<Real> & _aH;
  const MaterialProperty<Real> & _aI;
  const MaterialProperty<Real> & _aJ;
  const MaterialProperty<Real> & _aK;

  const MaterialProperty<Real> & _EA;
  const MaterialProperty<Real> & _EB;
  const MaterialProperty<Real> & _EC;
  const MaterialProperty<Real> & _ED;
  const MaterialProperty<Real> & _EE;
  const MaterialProperty<Real> & _EF;
  const MaterialProperty<Real> & _EG;
  const MaterialProperty<Real> & _EH;
  const MaterialProperty<Real> & _EI;
  const MaterialProperty<Real> & _EJ;
  const MaterialProperty<Real> & _EK;
  
  const MaterialProperty<Real> & _nA;
  const MaterialProperty<Real> & _nB;
  const MaterialProperty<Real> & _nC;
  const MaterialProperty<Real> & _nD;
  const MaterialProperty<Real> & _nE;
  const MaterialProperty<Real> & _nF;
  const MaterialProperty<Real> & _nG;
  const MaterialProperty<Real> & _nH;
  const MaterialProperty<Real> & _nI;
  const MaterialProperty<Real> & _nJ;
  const MaterialProperty<Real> & _nK;
   
  const MaterialProperty<Real> & _kA;
  const MaterialProperty<Real> & _kB;
  const MaterialProperty<Real> & _kC;
  const MaterialProperty<Real> & _kD;
  const MaterialProperty<Real> & _kE;
  const MaterialProperty<Real> & _kF;
  const MaterialProperty<Real> & _kG;
  const MaterialProperty<Real> & _kH;
  const MaterialProperty<Real> & _kI;
  const MaterialProperty<Real> & _kJ;
  const MaterialProperty<Real> & _kK;
   
  const MaterialProperty<Real> & _eps;
  const MaterialProperty<Real> & _f;
  const MaterialProperty<Real> & _DelH;
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

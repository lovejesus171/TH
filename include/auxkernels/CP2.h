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

// Forward Declarations
class CP2;

template <>
InputParameters validParams<CP2>();

class CP2 : public AuxKernel
{
public:
  CP2(const InputParameters & parameters);

protected:
  virtual Real computeValue() override;

  const VariableValue & _C1;
  const VariableValue & _C0;
  const VariableValue & _C3;
  const VariableValue & _C9;
  const VariableValue & _C6;
  const VariableValue & _T;
  const VariableValue & _Ecorr;

  const Real & _aS;
  const Real & _aC;
  const Real & _aD;
  const Real & _aE;
  const Real & _aF;
  const Real & _aS3;


  const Real & _EA;
  const Real & _ES12;
  const Real & _ES3;
  const Real & _EC;
  const Real & _ED;
  const Real & _EE;
  const Real & _EF;

  const Real & _nA;
  const Real & _nD;
  const Real & _nE;
  const Real & _nF;
  const Real & _nO;
  const Real & _nS;

  const Real & _kA;
  const Real & _kC;
  const Real & _kD;
  const Real & _kE;
  const Real & _kS;
  const Real & _kF;
  const Real & _kBB;
  const Real & _Porosity;
  const Real & _Area;
  const Real & _Tol;
  const Real & _Del_E;

};


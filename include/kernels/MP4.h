//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "ADKernel.h"

// Forward Declarations
class MP4;

template <>
InputParameters validParams<MP4>();

class MP4 : public ADKernel
{
public:
  MP4(const InputParameters & parameters);

protected:
  virtual ADReal computeQpResidual() override;

  const ADVariableValue & _C1;
  const ADVariableValue & _C0;
  const ADVariableValue & _C3;
  const ADVariableValue & _C9;
  const ADVariableValue & _C6;
  const ADVariableValue & _T;

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

};


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
class ISS;

template <>
InputParameters validParams<ISS>();

/**
 * Coupled auxiliary value
 */
class ISS : public AuxKernel
{
public:
  /**
   * Factory constructor, takes parameters so that all derived classes can be built using the same
   * constructor.
   */
  ISS(const InputParameters & parameters);

protected:
  virtual Real computeValue() override;

  const VariableValue & _C6;
  const VariableValue & _C9;
  const VariableValue & _C1;
  const VariableValue & _T;
  const VariableValue & _Ecorr;

  const Real & _Porosity;

  const Real & _nA;
  const Real & _kA;
  const Real & _kB;
  const Real & _EA;

  const Real & _nS;
  const Real & _kS;
  const Real & _aS;
  const Real & _aS3;
  const Real & _ES12;
  const Real & _ES3;


};


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
class IE;

template <>
InputParameters validParams<IE>();

/**
 * Coupled auxiliary value
 */
class IE : public AuxKernel
{
public:
  /**
   * Factory constructor, takes parameters so that all derived classes can be built using the same
   * constructor.
   */
  IE(const InputParameters & parameters);

protected:
  virtual Real computeValue() override;

  const VariableValue & _C0;
  const VariableValue & _C3;
  const VariableValue & _C9;
  const VariableValue & _T;
  const VariableValue & _Ecorr;

  const Real & _Porosity;

  const Real & _nO;
  const Real & _kC;
  const Real & _aC;
  const Real & _EC;

  const Real & _nD;
  const Real & _kD;
  const Real & _aD;
  const Real & _ED;

  const Real & _nE;
  const Real & _kE;
  const Real & _aE;
  const Real & _EE;

  const Real & _nF;
  const Real & _kF;
  const Real & _aF;
  const Real & _EF;

};


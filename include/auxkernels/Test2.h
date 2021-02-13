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
class Test2;

template <>
InputParameters validParams<Test2>();

/**
 * Coupled auxiliary value
 */
class Test2 : public AuxKernel
{
public:
  /**
   * Factory constructor, takes parameters so that all derived classes can be built using the same
   * constructor.
   */
  Test2(const InputParameters & parameters);

protected:
  virtual Real computeValue() override;

  const VariableValue & _C;

  const Real & _m;
  const Real & _aE;
  const Real & _aS;
  const Real & _aS12;
  const Real & _aS3;
  const Real & _EE;
  const Real & _ES12;
  const Real & _E3;
  const Real & _nE;
  const Real & _nS;
  const Real & _kE;
  const Real & _kS;
  const Real & _aF;
  const Real & _EF;
  const Real & _kF;
  const Real & _nF;

};


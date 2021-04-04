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
class C1;

template <>
InputParameters validParams<C1>();

/**
 * Coupled auxiliary value
 */
class C1 : public AuxKernel
{
public:
  /**
   * Factory constructor, takes parameters so that all derived classes can be built using the same
   * constructor.
   */
  C1(const InputParameters & parameters);

protected:
  virtual Real computeValue() override;

  const VariableValue & _cs;
  const VariableValue & _cl;
  const MaterialProperty<Real> & _h;
};


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
class AuxCu2S;

template <>
InputParameters validParams<AuxCu2S>();

/**
 * Coupled auxiliary value
 */
class AuxCu2S : public AuxKernel
{
public:
  /**
   * Factory constructor, takes parameters so that all derived classes can be built using the same
   * constructor.
   */
  AuxCu2S(const InputParameters & parameters);

protected:
  virtual Real computeValue() override;

    const Real & _F;
    const MaterialProperty<Real> & _eps;
    const Real & _kS;
    const Real & _aS;
    const MaterialProperty<Real> & _E;
    const Real & _R;
    const VariableValue & _T;
    const Real & _aS3;
    const Real & _ES12;
    const Real & _ES3;
    const Real & _Num;
    const VariableValue & _C1;

};


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

#include "metaphysicl/raw_type.h"
// Forward Declarations
class ADAuxCu2SEVar;

template <>
InputParameters validParams<ADAuxCu2SEVar>();

/**
 * Coupled auxiliary value
 */
class ADAuxCu2SEVar : public AuxKernel
{
public:
  /**
   * Factory constructor, takes parameters so that all derived classes can be built using the same
   * constructor.
   */
  ADAuxCu2SEVar(const InputParameters & parameters);

protected:
  virtual Real computeValue() override;

    const Real & _F;
    const ADMaterialProperty<Real> & _eps;
    const Real & _kS;
    const Real & _aS;
    const ADVariableValue & _E;
    const Real & _R;
    const ADVariableValue & _T;
    const Real & _aS3;
    const Real & _ES12;
    const Real & _ES3;
    const Real & _Num;
    const ADVariableValue & _C1;

};


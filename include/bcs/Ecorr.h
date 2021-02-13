//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "IntegratedBC.h"

// Forward Declarations
class Ecorr;

template <>
InputParameters validParams<Ecorr>();

/**
 * Implements a simple coupled boundary condition where u=v on the boundary.
 */
class Ecorr : public IntegratedBC
{
public:
  static InputParameters validParams();

  Ecorr(const InputParameters & parameters);

protected:
  virtual Real computeQpResidual() override;
  virtual Real computeQpJacobian() override;
  virtual Real computeQpOffDiagJacobian(unsigned int jvar) override;

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
};

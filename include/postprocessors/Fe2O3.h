//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "NodalVariablePostprocessor.h"

// Forward Declarations
class Fe2O3;

template <>
InputParameters validParams<Fe2O3>();

/**
 * This class computes a maximum (over all the nodal values) of the
 * coupled variable.
 */
class Fe2O3 : public NodalVariablePostprocessor
{
public:
  static InputParameters validParams();

  Fe2O3(const InputParameters & parameters);

  virtual void initialize() override;
  virtual void execute() override;
  virtual Real getValue() override;
  virtual void threadJoin(const UserObject & y) override;

protected:
  Real _value;
  const VariableValue & _v;
  const VariableValue & _w;
  const VariableValue & _x;
  const VariableValue & _y;
  const Real & _k1;
  const Real & _k2;
  const Real & _k3;
  const Real & _k4;
 
//  const MaterialProperty<Real> & _Cs;
//  const MaterialProperty<Real> & _k1; 
};


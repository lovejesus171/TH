//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "Material.h"

/**
 * Stateful material class that defines a few properties.
 */
class UO32H2O : public Material
{
public:
  static InputParameters validParams();

  UO32H2O(const InputParameters & parameters);

protected:
  virtual void initQpStatefulProperties();
  virtual void computeQpProperties();

private:

  const MaterialProperty<Real> & _k1;
  const MaterialProperty<Real> & _k2;
  const MaterialProperty<Real> & _k3;
  const MaterialProperty<Real> & _k4;
  const MaterialProperty<Real> & _Sat1;
  const MaterialProperty<Real> & _Sat2;
  MaterialProperty<Real> & _UO32H2O;
  const MaterialProperty<Real> & _UO32H2O_old;

  const VariableValue & _v;
  const VariableValue & _w;
};

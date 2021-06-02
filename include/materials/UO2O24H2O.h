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
class UO2O24H2O : public Material
{
public:
  static InputParameters validParams();

  UO2O24H2O(const InputParameters & parameters);

protected:
  virtual void initQpStatefulProperties();
  virtual void computeQpProperties();

private:

  const MaterialProperty<Real> & _k;
  const MaterialProperty<Real> & _Sat;
  MaterialProperty<Real> & _UO2O24H2O;
  const MaterialProperty<Real> & _UO2O24H2O_old;

  const VariableValue & _v;
};

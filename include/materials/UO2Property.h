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
class UO2Property : public Material
{
public:
  static InputParameters validParams();

  UO2Property(const InputParameters & parameters);

protected:
  virtual void initQpStatefulProperties();
  virtual void computeQpProperties();

private:


  Real _UO22pValue;
  MaterialProperty<Real> & _Sat_UO22p;
  Real _UO2CO322mValue;
  MaterialProperty<Real> & _Sat_UO2CO322m;
  Real _UOH4Value;
  MaterialProperty<Real> & _Sat_UOH4;
  Real _Fe2pValue;
  MaterialProperty<Real> & _Sat_Fe2p;

};

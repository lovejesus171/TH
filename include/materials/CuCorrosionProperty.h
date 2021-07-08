//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "ADMaterial.h"

/**
 * Stateful material class that defines a few properties.
 */
class CuCorrosionProperty : public ADMaterial
{
public:
  static InputParameters validParams();

  CuCorrosionProperty(const InputParameters & parameters);

protected:
  virtual void initQpStatefulProperties();
  virtual void computeQpProperties();

private:

  Real _aS;
  Real _aC;
  Real _aD;
  Real _aE;
  Real _aF;
  Real _aS3;

  Real _EA;
  Real _ES12;
  Real _ES3;
  Real _EC;
  Real _ED;
  Real _EE;
  Real _EF;
  
  Real _nA;
  Real _nD;
  Real _nE;
  Real _nF;
  Real _nO;
  Real _nS;

  Real _kA;
  Real _kC;
  Real _kD;
  Real _kE;
  Real _kS;
  Real _kF;
  Real _kBB;

  Real _Porosity;

  Real _Area;

  /**
   * Create two MooseArray Refs to hold the current
   * and previous material properties respectively
   */

  Real _AnodeAreaValue;
  ADMaterialProperty<Real> & _AnodeArea;

};

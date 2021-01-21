//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "ADKernel.h"

/**
 * Adds contribution due to thermo-migration to the Cahn-Hilliard equation
 **/
class NernstPlanck : public ADKernel
{
public:
  static InputParameters validParams();

  NernstPlanck(const InputParameters & parameters);

protected:
  virtual ADReal computeQpResidual();

  // temperature variable
  const ADVariableValue & _T;
  const ADVariableValue & _EP;


  // Temperature variable gradient
  const ADVariableGradient & _grad_EP;

  // Mobility property name
  const ADMaterialProperty<Real> & _z;
  const ADMaterialProperty<Real> & _D;
  
  const Real _F;
  const Real _R;
};

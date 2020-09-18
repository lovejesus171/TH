/****************************************************************/
/*               DO NOT MODIFY THIS HEADER                      */
/* MOOSE - Multiphysics Object Oriented Simulation Environment  */
/*                                                              */
/*           (c) 2010 Battelle Energy Alliance, LLC             */
/*                   ALL RIGHTS RESERVED                        */
/*                                                              */
/*          Prepared by Battelle Energy Alliance, LLC           */
/*            Under Contract No. DE-AC07-05ID14517              */
/*            With the U. S. Department of Energy               */
/*                                                              */
/*            See COPYRIGHT for full restrictions               */
/****************************************************************/

#pragma once

#include "ADKernel.h"

class ADEEDFEnergyTownsendLog : public ADKernel
{
public:
  static InputParameters validParams();
  ADEEDFEnergyTownsendLog(const InputParameters & parameters);

protected:
  virtual ADReal computeQpResidual();

  Real _r_units;
  Real _threshold_energy;

  const ADMaterialProperty<Real> & _diffem;
  const ADMaterialProperty<Real> & _muem;
  const ADMaterialProperty<Real> & _alpha;

  const ADVariableGradient & _grad_potential;
  const ADVariableValue & _em;
  const ADVariableGradient & _grad_em;
  const ADVariableValue & _target;
  Real _energy_change;

private:
  ADReal _electron_flux_mag;
};

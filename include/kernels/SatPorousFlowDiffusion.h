/// Considering Saturation effect


//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once
#include "Diffusion.h"

// Forward Declarations

/**
 * Define the Kernel for a CoupledConvectionReactionSub operator that looks like:
 * grad (diff * grad_u)
 */
class SatPorousFlowDiffusion : public Diffusion
{
public:
  static InputParameters validParams();

  SatPorousFlowDiffusion(const InputParameters & parameters);

protected:
  virtual Real computeQpResidual() override;
  virtual Real computeQpJacobian() override;

  /// Pressure material property
  const VariableValue & _pressure;

  /// Material property of dispersion-diffusion coefficient.
  const MaterialProperty<Real> & _diffusivity;
  const MaterialProperty<Real> & _porosity;
  const MaterialProperty<Real> & _tortuosity;
  const MaterialProperty<Real> & _vancoeff;
  const MaterialProperty<Real> & _P0;

  const Real & _diff_coeff;
};

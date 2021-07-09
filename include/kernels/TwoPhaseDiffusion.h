//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "PorousFlowDictator.h"
#include "Diffusion.h"


class TwoPhaseDiffusion : public Diffusion
{
public:
  static InputParameters validParams();

  TwoPhaseDiffusion(const InputParameters & parameters);

protected:
  virtual Real computeQpResidual() override;
  virtual Real computeQpJacobian() override;

  /// The fluid component index
  const unsigned int _ph;

  /// PorousFlowDicator UserObject
  const PorousFlowDictator & _dictator;

  /// Variables for second order derivatives
  const VariableSecond & _second_u;

  /// Porosity at the nodes, but it can depend on grad(variables) which are actually evaluated at the qps
  const MaterialProperty<Real> & _porosity;

  /// Tortuosity at the nodess
  const MaterialProperty<Real> & _tortuosity;

  /// Nodal fluid saturation
  const MaterialProperty<std::vector<Real>> & _fluid_saturation_nodal;

  /// Diffusion coefficient of gas and aqueous O2
  const Real & _diff_coeff_gas;
  const Real & _diff_coeff_aq;

};

//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "TwoPhaseDiffusion.h"
#include "MooseVariable.h"
#include "libmesh/quadrature.h"
#include <limits>

registerMooseObject("corrosionApp", TwoPhaseDiffusion);

InputParameters
TwoPhaseDiffusion::validParams()
{
  InputParameters params = Diffusion::validParams();
  params.addParam<unsigned int>(
      "phase", 0, "Use the Darcy velocity of this fluid phase");
  params.addRequiredParam<UserObjectName>(
      "PorousFlowDictator", "The UserObject that holds the list of PorousFlow variable names");
  params.addRequiredParam<Real>("Diffusion_coeff_gas", "Put the value of diffusion coefficient of gaseous phase of O2");
  params.addRequiredParam<Real>("Diffusion_coeff_aq", "Put the value of diffusion coefficient of aqeuous phase of O2");
  params.addClassDescription("The diffusion kernel of O2 gaseous / aqueous phase");
  return params;
}

TwoPhaseDiffusion::TwoPhaseDiffusion(const InputParameters & parameters)
 : Diffusion(parameters),
   _dictator(getUserObject<PorousFlowDictator>("PorousFlowDictator")),
   _second_u(second()),
   _porosity(getMaterialProperty<Real>("porosity")),
   _tortuosity(getMaterialProperty<Real>("tortuosity")),
   _diff_coeff_gas(getParam<Real>("Diffusion_coeff_gas")),
   _ph(getParam<unsigned int>("phase")),
   _diff_coeff_aq(getParam<Real>("Diffusion_coeff_aq")),
   _fluid_saturation_nodal(getMaterialProperty<std::vector<Real>>("PorousFlow_saturation_nodal"))
{
}

Real
TwoPhaseDiffusion::computeQpResidual()
{
  return _grad_test[_i][_qp] * _porosity[_qp] * _tortuosity[_qp] * ( _diff_coeff_aq * _fluid_saturation_nodal[_i][_ph] + std::pow(1 - _fluid_saturation_nodal[_i][_ph],3) * _diff_coeff_gas * 31.4) * _grad_u[_qp];
}

Real
TwoPhaseDiffusion::computeQpJacobian()
{
  return _grad_test[_i][_qp] * _porosity[_qp] * _tortuosity[_qp] * ( _diff_coeff_aq * _fluid_saturation_nodal[_i][_ph] + std::pow(1 - _fluid_saturation_nodal[_i][_ph],3) * _diff_coeff_gas * 31.4) * _grad_phi[_j][_qp];
}


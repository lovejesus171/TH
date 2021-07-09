//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "GasPhaseTimeDerivative.h"

#include "MooseVariable.h"

#include "libmesh/quadrature.h"

#include <limits>

registerMooseObject("corrosionApp", GasPhaseTimeDerivative);

InputParameters
GasPhaseTimeDerivative::validParams()
{
  InputParameters params = TimeDerivative::validParams();
  params.addParam<unsigned int>(
      "phase", 0, "Use the Darcy velocity of this fluid phase");
  params.addRequiredParam<UserObjectName>(
      "PorousFlowDictator", "The UserObject that holds the list of PorousFlow variable names.");
  params.addClassDescription(
      "Component mass derivative wrt time for component given by fluid_component");
  return params;
}

GasPhaseTimeDerivative::GasPhaseTimeDerivative(const InputParameters & parameters)
  : TimeDerivative(parameters),
    _dictator(getUserObject<PorousFlowDictator>("PorousFlowDictator")),
    _num_phases(_dictator.numPhases()),
    _porosity(getMaterialProperty<Real>("porosity")),
    _ph(getParam<unsigned int>("phase")),
    _u_old(valueOld()),
    _phi_old(valueOld()),
    _fluid_saturation_nodal(getMaterialProperty<std::vector<Real>>("PorousFlow_saturation_nodal")),
    _fluid_saturation_nodal_old(
        getMaterialPropertyOld<std::vector<Real>>("PorousFlow_saturation_nodal")),
    _dfluid_saturation_nodal_dvar(
        getMaterialProperty<std::vector<std::vector<Real>>>("dPorousFlow_saturation_nodal_dvar"))
{
  if (_ph >= _dictator.numPhases())
    paramError(
        "phase",
        "The Dictator proclaims that the maximum fluid phase index in this simulation is ",
        _dictator.numPhases() - 1,
        " whereas you have used ",
        _ph,
        ". Remember that indexing starts at 0. The Dictator is watching you, to ensrue your wellbeing.");
}

Real
GasPhaseTimeDerivative::computeQpResidual()
{
  // H = Henry's law constant
//  Real _H = 31.4;

  return _porosity[_qp] * _test[_i][_qp] * ((1 - _fluid_saturation_nodal[_i][_ph]) * _u[_qp] - (1 - _fluid_saturation_nodal_old[_i][_ph]) * _u_old[_qp]) / _dt;
}

Real
GasPhaseTimeDerivative::computeQpJacobian()
{
//  Real _H = 31.4;
  // If the variable is not a PorousFlow variable (very unusual), the diag Jacobian terms are 0
  return _porosity[_qp] * _test[_i][_qp] * ((1 - _fluid_saturation_nodal[_i][_ph]) * _phi[_j][_qp]) / _dt;
}


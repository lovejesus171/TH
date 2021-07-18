//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "GasPhaseDiffusion.h"
#include "MooseVariable.h"
#include "libmesh/quadrature.h"
#include <limits>

registerMooseObject("corrosionApp", GasPhaseDiffusion);

InputParameters
GasPhaseDiffusion::validParams()
{
  InputParameters params = Diffusion::validParams();
  params.addParam<unsigned int>(
      "phase", 0, "Use the Darcy velocity of this fluid phase");
  params.addRequiredParam<UserObjectName>(
      "PorousFlowDictator", "The UserObject that holds the list of PorousFlow variable names");
  params.addRequiredCoupledVar("T", "Temperature of each quadrature point");
  params.addRequiredParam<MaterialPropertyName>("D_gas", "The diffusion coefficient of gaseous phase species");
  params.addRequiredParam<MaterialPropertyName>("EA_gas", "The activation energy of gaseous phase species");
  params.addClassDescription("The diffusion kernel of O2 gaseous / aqueous phase");
  return params;
}

GasPhaseDiffusion::GasPhaseDiffusion(const InputParameters & parameters)
 : Diffusion(parameters),
   _dictator(getUserObject<PorousFlowDictator>("PorousFlowDictator")),
   _porosity(getMaterialProperty<Real>("porosity")),
   _tortuosity(getMaterialProperty<Real>("tortuosity")),
   _D_gas(getMaterialProperty<Real>("D_gas")),
   _EA_gas(getMaterialProperty<Real>("EA_gas")),
   _T(coupledValue("T")),
   _T_id(coupled("T")),
   _ph(getParam<unsigned int>("phase")),
   _fluid_saturation_nodal(getMaterialProperty<std::vector<Real>>("PorousFlow_saturation_nodal"))
{
}

Real
GasPhaseDiffusion::computeQpResidual()
{
  Real R = 8.314;

  return _grad_test[_i][_qp] * _porosity[_qp] * _tortuosity[_qp] * std::pow(1 - _fluid_saturation_nodal[_i][_ph],3) * _D_gas[_qp] * exp(-_EA_gas[_qp] / (R * _T[_qp])) * 31.4 * exp(-_EA_gas[_qp] / (R * _T[_qp])) * _grad_u[_qp];
}

Real
GasPhaseDiffusion::computeQpJacobian()
{
  Real R = 8.314;

  return _grad_test[_i][_qp] * _porosity[_qp] * _tortuosity[_qp] * std::pow(1 - _fluid_saturation_nodal[_i][_ph],3) * _D_gas[_qp] * exp(-_EA_gas[_qp] / (R * _T[_qp])) * 31.4 * exp(-_EA_gas[_qp] / (R * _T[_qp])) * _grad_phi[_j][_qp];
}

Real
GasPhaseDiffusion::computeQpOffDiagJacobian(unsigned int jvar)
{
  Real R = 8.314; 

//  if (jvar == _T_id)
//	return _grad_test[_i][_qp] * _porosity[_qp] * _tortuosity[_qp] * std::pow(1 - _fluid_saturation_nodal[_i][_ph],3) * _D_gas[_qp] * _EA_gas[_qp] / (R * _T[_qp] * _T[_qp]) * _phi[_j][_qp] * exp(-_EA_gas[_qp] / (R * _T[_qp])) * 31.4 * _grad_u[_qp];
//  else
	return 0.0;
}


//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "SatPorousFlowDiffusion.h"
#include<math.h>

registerMooseObject("corrosionApp", SatPorousFlowDiffusion);

InputParameters
SatPorousFlowDiffusion::validParams()
{
  InputParameters params = Diffusion::validParams();
  params.addClassDescription("Diffusion of primary species");
  params.addRequiredCoupledVar("pressure", "Put the name of pressure parameter");
  params.addRequiredParam<Real>("Diffusion_coeff","Put the value of diffusion coefficient");
  return params;
}

SatPorousFlowDiffusion::SatPorousFlowDiffusion(const InputParameters & parameters)
  : Diffusion(parameters),
	_pressure(coupledValue("pressure")),

	_diff_coeff(getParam<Real>("Diffusion_coeff")),
       	_porosity(getMaterialProperty<Real>("porosity")),
       	_diffusivity(getMaterialProperty<Real>("diffusivity")),
       	_tortuosity(getMaterialProperty<Real>("tortuosity")),
	_vancoeff(getMaterialProperty<Real>("van_genuchten_coeff")),
	_P0(getMaterialProperty<Real>("van_genuchten_parameter"))
{
}

Real
SatPorousFlowDiffusion::computeQpResidual()
{
  return _porosity[_qp] * _tortuosity[_qp] * _diff_coeff * std::pow(1 + std::pow(-_pressure[_qp] / _P0[_qp],(1 / (1 - _vancoeff[_qp]))), -_vancoeff[_qp]) * Diffusion::computeQpResidual();
}

Real
SatPorousFlowDiffusion::computeQpJacobian()
{
  return _porosity[_qp] * _tortuosity[_qp] * _diff_coeff * std::pow(1 + std::pow(-_pressure[_qp] / _P0[_qp],(1 / (1 - _vancoeff[_qp]))), -_vancoeff[_qp]) * Diffusion::computeQpJacobian();
}

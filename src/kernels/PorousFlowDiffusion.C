//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "PorousFlowDiffusion.h"

registerMooseObject("corrosionApp", PorousFlowDiffusion);

InputParameters
PorousFlowDiffusion::validParams()
{
  InputParameters params = Diffusion::validParams();
  params.addClassDescription("Diffusion of primary species");
  return params;
}

PorousFlowDiffusion::PorousFlowDiffusion(const InputParameters & parameters)
  : Diffusion(parameters),
       	_porosity(getMaterialProperty<Real>("porosity")),
       	_diffusivity(getMaterialProperty<Real>("diffusivity")),
       	_tortuosity(getMaterialProperty<Real>("tortuosity"))
{
}

Real
PorousFlowDiffusion::computeQpResidual()
{
  return _porosity[_qp] * _tortuosity[_qp] * _diffusivity[_qp] * Diffusion::computeQpResidual();
}

Real
PorousFlowDiffusion::computeQpJacobian()
{
  return _porosity[_qp] * _tortuosity[_qp] * _diffusivity[_qp] * Diffusion::computeQpJacobian();
}

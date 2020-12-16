//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "NernstPlanck.h"

registerMooseObject("corrosionApp", NernstPlanck);

InputParameters
NernstPlanck::validParams()
{
  InputParameters params = ADKernel::validParams();
  params.addClassDescription("This kernel solve nernst-planck terms and should be combined with poisson term (diffusion)");
  params.addRequiredCoupledVar("T", "The temperature variable");
  params.addRequiredCoupledVar("Chemical_Species", "Add name of chemical species");
  params.addRequiredCoupledVar("Potential", "Potential distribution in ionic solution");
  params.addRequiredParam<MaterialPropertyName>("Charge_coef", "Charge valence of chemical species");
  params.addRequiredParam<MaterialPropertyName>("Diffusion_coef", "Diffusion coefficient in diluted solution (water base)");
  return params;
}

NernstPlanck::NernstPlanck(const InputParameters & parameters)
  : ADKernel(parameters),
    _T(adCoupledValue("T")),
    _C(adCoupledValue("Chemical_Species")),
    _EP(adCoupledValue("Potential")),
    _grad_EP(adCoupledGradient("Potential")),
    _z(getADMaterialProperty<Real>("Charge_coef")),
    _D(getADMaterialProperty<Real>("Diffusion_coef")),
    _F(96485),
    _R(8.314)
{
}

ADReal
NernstPlanck::computeQpResidual()
{
  return _z[_qp] * _D[_qp] * _F * _grad_EP[_qp] * _C[_qp] / ( _R * _T[_qp]) * _grad_test[_i][_qp];
}

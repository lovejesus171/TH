//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "ElectricField.h"

registerMooseObject("corrosionApp", ElectricField);

InputParameters
ElectricField::validParams()
{
  InputParameters params = ADKernel::validParams();
  params.addClassDescription("This kernel solve nernst-planck terms and should be combined with poisson term (diffusion)");
  params.addRequiredCoupledVar("Chemical_Species", "Add name of chemical species");
  params.addRequiredParam<MaterialPropertyName>("Charge_coef", "Charge valence of chemical species");
  return params;
}

ElectricField::ElectricField(const InputParameters & parameters)
  : ADKernel(parameters),
    _C(adCoupledValue("Chemical_Species")),
    _grad_C(adCoupledGradient("Chemical_Species")),
    _z(getADMaterialProperty<Real>("Charge_coef")),
    _F(96485)
{
}

ADReal
ElectricField::computeQpResidual()
{
  return _z[_qp]  * _F *  _C[_qp]  * _test[_i][_qp] + _grad_test[_i][_qp] * _grad_u[_qp];
}

// 2021.01.24 I have to add reaction products terms. ex) HS- -> Cu+

#include "DiffusionPBC.h"

registerMooseObject("corrosionApp", DiffusionPBC);

defineLegacyParams(DiffusionPBC);

InputParameters
DiffusionPBC::validParams()
{
  InputParameters params = ADIntegratedBC::validParams();
  params.addParam<Real>("Diffusion_coef","Porosity of porous medium");
  params.addParam<Real>("Num",1,"Number of produced or consumed chemical species per reaction");
  params.addRequiredCoupledVar("Reactant1","HS- anions");
  params.addClassDescription(
      "Computes a boundary residual contribution consistent with the Diffusion Kernel. "
      "Does not impose a boundary condition; instead computes the boundary "
      "contribution corresponding to the current value of grad(u) and accumulates "
      "it in the residual vector.");
  return params;
}

DiffusionPBC::DiffusionPBC(const InputParameters & parameters)
  : ADIntegratedBC(parameters),
   _D(getParam<Real>("Diffusion_coef")),
   _Num(getParam<Real>("Num")),
   _C1(adCoupledValue("Reactant1")),
   _grad_C1(adCoupledGradient("Reactant1"))
{
}

ADReal
DiffusionPBC::computeQpResidual()
{
     return _test[_i][_qp] * _Num * _D * _grad_C1[_qp] * _normals[_qp];
}

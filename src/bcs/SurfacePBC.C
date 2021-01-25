// 2021.01.24 I have to add reaction products terms. ex) HS- -> Cu+

#include "SurfacePBC.h"

registerMooseObject("corrosionApp", SurfacePBC);

defineLegacyParams(SurfacePBC);

InputParameters
SurfacePBC::validParams()
{
  InputParameters params = FluxBC::validParams();
  params.addParam<Real>("Saturation",1.0,"Degree of saturation (relative sautration)");
  params.addParam<Real>("Diffusion_coef",0,"Diffusion coefficient");
  params.addParam<Real>("Tortuosity",1.0,"Tortuosity of porous medium");
  params.addParam<Real>("Faraday_constant",96485.3329,"Faraday constants, C/mol");
  params.addParam<Real>("Charge_number",0.0,"Charge number of anion or cation");
  params.addParam<Real>("Porosity",1.0,"Porosity of porous medium");
  params.addRequiredCoupledVar("Reactant1","Reactants to produce products");
  params.addClassDescription(
      "Computes a boundary residual contribution consistent with the Diffusion Kernel. "
      "Does not impose a boundary condition; instead computes the boundary "
      "contribution corresponding to the current value of grad(u) and accumulates "
      "it in the residual vector.");
  return params;
}

SurfacePBC::SurfacePBC(const InputParameters & parameters)
  : FluxBC(parameters),
   _S(getParam<Real>("Saturation")),
   _D(getParam<Real>("Diffusion_coef")),
   _tau(getParam<Real>("Tortuosity")),
   _F(getParam<Real>("Faraday_constant")),
   _n(getParam<Real>("Charge_number")),
   _eps(getParam<Real>("Porosity")),
   _R1(coupledValue("Reactant1")),
   _grad_R1(coupledGradient("Reactant1"))
{
}

RealGradient
SurfacePBC::computeQpFluxResidual()
{
 
   return -_eps * _n * _S * _D * _tau * _F * _grad_R1[_qp];   
}

// I have to modify Jacobian (derivation the jacobian first)

RealGradient
SurfacePBC::computeQpFluxJacobian()
{
 
   return 0;   
}




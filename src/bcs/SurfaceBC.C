// 2021.01.24 I have to add reaction products terms. ex) HS- -> Cu+

#include "SurfaceBC.h"

registerMooseObject("corrosionApp", SurfaceBC);

defineLegacyParams(SurfaceBC);

InputParameters
SurfaceBC::validParams()
{
  InputParameters params = FluxBC::validParams();
  params.addParam<Real>("Saturation",1.0,"Degree of saturation (relative sautration)");
  params.addParam<Real>("Diffusion_coef",0,"Diffusion coefficient");
  params.addParam<Real>("Tortuosity",1.0,"Tortuosity of porous medium");
  params.addParam<Real>("Faraday_constant",96485.3329,"Faraday constants, C/mol");
  params.addParam<Real>("Charge_number",0.0,"Charge number of anion or cation");
  params.addParam<Real>("Porosity",1.0,"Porosity of porous medium");
  params.addClassDescription(
      "Computes a boundary residual contribution consistent with the Diffusion Kernel. "
      "Does not impose a boundary condition; instead computes the boundary "
      "contribution corresponding to the current value of grad(u) and accumulates "
      "it in the residual vector.");
  return params;
}

SurfaceBC::SurfaceBC(const InputParameters & parameters)
  : FluxBC(parameters),
   _S(getParam<Real>("Saturation")),
   _D(getParam<Real>("Diffusion_coef")),
   _tau(getParam<Real>("Tortuosity")),
   _F(getParam<Real>("Faraday_constant")),
   _n(getParam<Real>("Charge_number")),
   _eps(getParam<Real>("Porosity"))
{
}

RealGradient
SurfaceBC::computeQpFluxResidual()
{
 
   return -_eps * _n * _S * _D * _tau * _F * _grad_u[_qp];   
}

RealGradient
SurfaceBC::computeQpFluxJacobian()
{
 
   return -_eps * _n * _S * _D * _tau * _F * _grad_phi[_j][_qp];   
}




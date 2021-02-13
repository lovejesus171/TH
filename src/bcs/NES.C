// 2021.01.24 I have to add reaction products terms. ex) HS- -> Cu+

#include "NES.h"

registerMooseObject("corrosionApp", NES);

defineLegacyParams(NES);

InputParameters
NES::validParams()
{
  InputParameters params = NodalBC::validParams();
  params.addParam<Real>("Faraday_constant",96485.3329,"Faraday constants, C/mol");
  params.addParam<Real>("Charge_number",0.0,"Charge number of anion or cation");
  params.addParam<Real>("Porosity",1.0,"Porosity of porous medium");
  params.addParam<Real>("Kinetic",1.0,"Kinetic constant");
  params.addRequiredCoupledVar("Reactant","Chemical species");
  params.addParam<Real>("Kinetic_order",1.0,"Reaction order");
  params.addParam<Real>("AlphaS",0.5,"transfer coefficient");
  params.addRequiredCoupledVar("Corrosion_potential","Corrosion potential");
  params.addParam<Real>("R",8.314,"Reaction order");
  params.addParam<Real>("T",298.15,"transfer coefficient");
  params.addParam<Real>("AlphaS3",0.5,"Transfer coefficient");
  params.addParam<Real>("Standard_potential2",0.0,"Standard_potential");
  params.addParam<Real>("Standard_potential3",0.0,"Standard_potentia3");
  params.addClassDescription(
      "Computes a boundary residual contribution consistent with the Diffusion Kernel. "
      "Does not impose a boundary condition; instead computes the boundary "
      "contribution corresponding to the current value of grad(u) and accumulates "
      "it in the residual vector.");
  return params;
}

NES::NES(const InputParameters & parameters)
  : NodalBC(parameters),
   _F(getParam<Real>("Faraday_constant")),
   _n(getParam<Real>("Charge_number")),
   _eps(getParam<Real>("Porosity")),
   _kS(getParam<Real>("Kinetic")),
   _C(coupledValue("Reactant")),
   _m(getParam<Real>("Kinetic_order")),
   _aS(getParam<Real>("AlphaS")),
   _E(coupledValue("Corrosion_potential")),
   _R(getParam<Real>("R")),
   _T(getParam<Real>("T")),
   _aS3(getParam<Real>("AlphaS3")),
   _ES12(getParam<Real>("Standard_potential2")),
   _ES3(getParam<Real>("Standard_potential3"))

{
}

Real
NES::computeQpResidual()
{
 
   return -_n * _eps * _F * _kS * pow(_u[_qp], _m) * exp(( 1.0 + _aS) * _F /(_R * _T) * _E[_qp]) * exp(-_F / (_R * _T) * (_ES12 + _aS3 * _ES3 ));   
}

Real
NES::computeQpJacobian()
{
   return -_n * _eps * _F * _kS *(_m - 1.0) * pow(_u[_qp], _m) * exp(( 1.0 + _aS) * _F /(_R * _T) * _E[_qp]) * exp(-_F / (_R * _T) * (_ES12 + _aS3 * _ES3 ));
}

Real
NES::computeQpOffDiagJacobian(unsigned int jvar)
{
   return -_n * _eps * _F * _kS * pow(_u[_qp], _m) *(1.0 + _aS)/(_R * _T) * _E[_qp] * exp(( 1.0 + _aS) * _F /(_R * _T) * _E[_qp]) * exp(-_F / (_R * _T) * (_ES12 + _aS3 * _ES3 ));
}

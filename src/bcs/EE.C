// 2021.01.24 I have to add reaction products terms. ex) HS- -> Cu+

#include "EE.h"
#include "math.h"

registerMooseObject("corrosionApp", EE);

defineLegacyParams(EE);

InputParameters
EE::validParams()
{
  InputParameters params = ADNodalBC::validParams();
  params.addParam<Real>("Faraday_constant",96485.3329,"Faraday constants, C/mol");
  params.addParam<Real>("Charge_number",0.0,"Charge number of anion or cation");
  params.addParam<Real>("Porosity",1.0,"Porosity of porous medium");
  params.addParam<Real>("Kinetic",1.0,"Kinetic constant");
  params.addRequiredCoupledVar("Reactant","Chemical species");
  params.addParam<Real>("Kinetic_order",1.0,"Reaction order");
  params.addParam<Real>("AlphaE",0.5,"transfer coefficient");
  params.addRequiredCoupledVar("Corrosion_potential","Corrosion potential");
  params.addParam<Real>("Standard_potential",0,"Standard potential for typcial reaction");
  params.addParam<Real>("R",8.314,"Reaction order");
  params.addParam<Real>("T",298.15,"transfer coefficient");
  params.addClassDescription("Calculate the flux.");
  return params;
}

EE::EE(const InputParameters & parameters)
  : ADNodalBC(parameters),
   _F(getParam<Real>("Faraday_constant")),
   _n(getParam<Real>("Charge_number")),
   _eps(getParam<Real>("Porosity")),
   _kE(getParam<Real>("Kinetic")),
   _C(adCoupledValue("Reactant")),
   _m(getParam<Real>("Kinetic_order")),
   _aE(getParam<Real>("AlphaE")),
   _E(adCoupledValue("Corrosion_potential")),
   _EE(getParam<Real>("Standard_potential")),
   _R(getParam<Real>("R")),
   _T(getParam<Real>("T"))
{
}

ADReal
EE::computeQpResidual()
{
   return -_n * _eps * _F * _kE * _C[_qp] * (_aE * _F / (_R * _T) * _E[_qp]);
//(-_aE * _F /(_R * _T) * (_E[_qp] - _EE ));   
}
//Auto differentiate X -> Jacobian derived...

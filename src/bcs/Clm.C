// 2021.01.24 I have to add reaction products terms. ex) HS- -> Cu+

#include "Clm.h"

registerMooseObject("corrosionApp", Clm);

defineLegacyParams(Clm);

InputParameters
Clm::validParams()
{
  InputParameters params = IntegratedBC::validParams();
  params.addCoupledVar("Corrosion_potential",0.0,"Corrosion potential");
  params.addCoupledVar("Reactant1",0.0,"CuCl2-");
  params.addCoupledVar("Temperature",0.0,"Temperature of the system");
  params.addParam<Real>("Faraday_constant",96485.3329,"Faraday constants, C/mol");
  params.addParam<Real>("Porosity",1.0,"Porosity of porous medium");
  params.addParam<Real>("R",8.314,"Reaction order");
  params.addParam<Real>("kF",0.0,"Kinetic constant");
  params.addParam<Real>("kB",0.0,"Kinetic constant");
  params.addParam<Real>("StandardPotential",0.0,"Standard potential");
  params.addParam<Real>("TransferCoef",1.0,"Transfer coefficient");
  params.addParam<Real>("Num",1.0,"Number of produced or consumed chemical species per a single reaction");
  params.addClassDescription(
      "This kernel is designed to calculate Cl- concentration change by the formation of CuCl2-");
  return params;
}

Clm::Clm(const InputParameters & parameters)
  : IntegratedBC(parameters),
   _E(coupledValue("Corrosion_potential")),
   _C1(coupledValue("Reactant1")),
   _T(coupledValue("Temperature")),
   _F(getParam<Real>("Faraday_constant")),
   _eps(getParam<Real>("Porosity")),
   _R(getParam<Real>("R")),
   _kF(getParam<Real>("kF")),
   _kB(getParam<Real>("kB")),
   _EA(getParam<Real>("StandardPotential")),
   _a(getParam<Real>("TransferCoef")),
   _E_id(coupled("Corrosion_potential")),
   _T_id(coupled("Temperature")),
   _C1_id(coupled("Reactant1")),
   _Num(getParam<Real>("Num"))
{
}

Real
Clm::computeQpResidual()
{
   return -_Num * _test[_i][_qp] * _eps * (_kF * _u[_qp] * _u[_qp] * exp(-_a * _F  / (_R * _T[_qp]) * (_E[_qp] - _EA)) - _kB * _C1[_qp]); 
}


Real
Clm::computeQpJacobian()
{
   return -_Num * _test[_i][_qp] * _eps * 2 * _kF * _phi[_j][_qp] * _u[_qp] * exp(-_a * _F  / (_R * _T[_qp]) * (_E[_qp] - _EA)); 
}

Real
Clm::computeQpOffDiagJacobian(unsigned int jvar)
{

   Real Front;
   Front =  -_Num * _test[_i][_qp] * _eps * _kF * _u[_qp] * _u[_qp];

   Real Factor;
   Factor = _a * _F /_R;

   if (jvar == _E_id)
     return Front * (-Factor/_T[_qp]) * _phi[_j][_qp] * exp(-Factor / _T[_qp] * (_E[_qp] - _EA));
   else if (jvar == _T_id)
     return Front * (Factor * (_E[_qp] - _EA) / _phi[_j][_qp] / _T[_qp]) * exp(-Factor / _T[_qp] * (_E[_qp] - _EA));
   else if (jvar == _C1_id)
     return -_Num * _test[_i][_qp] * _eps * _kB * _phi[_j][_qp];
   else
     return 0.0;
   
}

// 2021.01.24 I have to add reaction products terms. ex) HS- -> Cu+

#include "ADClmEVar.h"

registerMooseObject("corrosionApp", ADClmEVar);

defineLegacyParams(ADClmEVar);

InputParameters
ADClmEVar::validParams()
{
  InputParameters params = ADIntegratedBC::validParams();
  params.addRequiredCoupledVar("Corrosion_potential","Corrosion potential");
  params.addCoupledVar("Reactant1",0.0,"CuCl2-");
  params.addCoupledVar("Temperature",0.0,"Temperature of the system");
  params.addParam<Real>("Faraday_constant",96485.3329,"Faraday constants, C/mol");
  params.addRequiredParam<MaterialPropertyName>("Area","Area of anode surface");
  params.addParam<Real>("R",8.314,"Reaction order");
  params.addParam<Real>("kF",0.0,"Kinetic constant");
  params.addParam<Real>("kB",0.0,"Kinetic constant");
  params.addParam<Real>("StandardPotential",0.0,"Standard potential");
  params.addParam<Real>("Num",1.0,"Number of produced or consumed chemical species per a single reaction");
  params.addClassDescription(
      "This kernel is designed to calculate Cl- concentration change by the formation of CuCl2-");
  return params;
}

ADClmEVar::ADClmEVar(const InputParameters & parameters)
  : ADIntegratedBC(parameters),
   _E(adCoupledValue("Corrosion_potential")),
   _C1(adCoupledValue("Reactant1")),
   _T(adCoupledValue("Temperature")),
   _F(getParam<Real>("Faraday_constant")),
   _eps(getADMaterialProperty<Real>("Area")),
   _R(getParam<Real>("R")),
   _kF(getParam<Real>("kF")),
   _kB(getParam<Real>("kB")),
   _EA(getParam<Real>("StandardPotential")),
   _Num(getParam<Real>("Num"))
{
}

ADReal
ADClmEVar::computeQpResidual()
{
//   if (_u[_qp] -_Num * _test[_i][_qp] * _eps * (_kF * _u[_qp] * _u[_qp] * exp(_F  / (_R * _T[_qp]) * (_E[_qp] - _EA)) - _kB * _C1[_qp]) >= 0.0)
     return -_Num * _test[_i][_qp] * _eps[_qp] * (_kF * _u[_qp] * _u[_qp] * exp(_F  / (_R * _T[_qp]) * (_E[_qp] - _EA)) - _kB * _C1[_qp]); 
//   else
}


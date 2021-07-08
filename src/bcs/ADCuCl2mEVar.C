// 2021.01.24 I have to add reaction products terms. ex) HS- -> Cu+

#include "ADCuCl2mEVar.h"

registerMooseObject("corrosionApp", ADCuCl2mEVar);

defineLegacyParams(ADCuCl2mEVar);

InputParameters
ADCuCl2mEVar::validParams()
{
  InputParameters params = ADIntegratedBC::validParams();
  params.addRequiredCoupledVar("Corrosion_potential","Corrosion potential");
  params.addCoupledVar("Reactant1",0.0,"Cl-");
  params.addCoupledVar("Temperature",0.0,"Temperature of the system");
  params.addParam<Real>("Faraday_constant",96485.3329,"Faraday constants, C/mol");
  params.addRequiredParam<MaterialPropertyName>("Area","Porosity of porous medium");
  params.addParam<Real>("R",8.314,"Reaction order");
  params.addParam<Real>("kF",0.0,"Kinetic constant");
  params.addParam<Real>("kB",0.0,"Kinetic constant");
  params.addParam<Real>("StandardPotential",0.0,"Standard potential");
  params.addParam<Real>("Num",1.0,"Number of produced or consumed chemical species per a single reaction");
  params.addClassDescription(
      "This kernel is designed to calculate Cl- concentration change by the formation of CuCl2-");
  return params;
}

ADCuCl2mEVar::ADCuCl2mEVar(const InputParameters & parameters)
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
ADCuCl2mEVar::computeQpResidual()
{
   
//   if (_u[_qp] - _Num * _test[_i][_qp] * _eps * (_kF * _C1[_qp] * _C1[_qp] * exp(_F  / (_R * _T[_qp]) * (_E[_qp] - _EA)) - _kB * _u[_qp]) >= 0.0)
     return -_Num * _test[_i][_qp] * _eps[_qp] * (_kF * _C1[_qp] * _C1[_qp] * exp(_F  / (_R * _T[_qp]) * (_E[_qp] - _EA)) - _kB * _u[_qp]); 
//   else
}

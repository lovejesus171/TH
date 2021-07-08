// 2021.01.24 I have to add reaction products terms. ex) HS- -> Cu+

#include "CuCl2m.h"

registerMooseObject("corrosionApp", CuCl2m);

defineLegacyParams(CuCl2m);

InputParameters
CuCl2m::validParams()
{
  InputParameters params = IntegratedBC::validParams();
  params.addRequiredParam<MaterialPropertyName>("Corrosion_potential","Corrosion potential");
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

CuCl2m::CuCl2m(const InputParameters & parameters)
  : IntegratedBC(parameters),
   _E(getMaterialProperty<Real>("Corrosion_potential")),
   _C1(coupledValue("Reactant1")),
   _T(coupledValue("Temperature")),
   _F(getParam<Real>("Faraday_constant")),
   _eps(getMaterialProperty<Real>("Area")),
   _R(getParam<Real>("R")),
   _kF(getParam<Real>("kF")),
   _kB(getParam<Real>("kB")),
   _EA(getParam<Real>("StandardPotential")),
   _Num(getParam<Real>("Num")),
   _T_id(coupled("Temperature")),
   _C1_id(coupled("Reactant1"))
{
}

Real
CuCl2m::computeQpResidual()
{
        return -_Num * _test[_i][_qp] * _eps[_qp] * (_kF * _C1[_qp] * _C1[_qp] * exp(_F  / (_R * _T[_qp]) * (_E[_qp] - _EA)) - _kB * _u[_qp]); 
}


Real
CuCl2m::computeQpJacobian()
{
	   return -_Num * _test[_i][_qp] * _eps[_qp] * ( - _kB * _phi[_j][_qp]); 
}


Real
CuCl2m::computeQpOffDiagJacobian(unsigned int jvar)
{
 
  if (jvar == _C1_id)
	  return -_Num * _test[_i][_qp] * _eps[_qp] * _kF * 2 * _C1[_qp] * _phi[_j][_qp] * exp(_F  / (_R * _T[_qp]) * (_E[_qp] - _EA)); 
  else if (jvar == _T_id)
	  return -_Num * _test[_i][_qp] * _eps[_qp] * _kF * _C1[_qp] * _C1[_qp] * (-_F / (_R * _T[_qp]) * _phi[_j][_qp]) * exp(_F  / (_R * _T[_qp]) * (_E[_qp] - _EA)); 
  else
	  return 0.0;

}


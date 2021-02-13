// 2021.01.24 I have to add reaction products terms. ex) HS- -> Cu+

#include "ConsumedBC.h"

registerMooseObject("corrosionApp", ConsumedBC);

defineLegacyParams(ConsumedBC);

InputParameters
ConsumedBC::validParams()
{
  InputParameters params = IntegratedBC::validParams();
  params.addCoupledVar("Corrosion_potential",0.0,"Corrosion potential");
  params.addCoupledVar("Reactant1",0.0,"Chemical species");
  params.addCoupledVar("Temperature",0.0,"Temperature of the system");
  params.addParam<Real>("Faraday_constant",96485.3329,"Faraday constants, C/mol");
  params.addParam<Real>("Porosity",1.0,"Porosity of porous medium");
  params.addParam<Real>("R",8.314,"Reaction order");
  params.addParam<Real>("kF",0.0,"Kinetic constant");
  params.addParam<Real>("StandardPotential",0.0,"Standard potential");
  params.addParam<Real>("TransferCoef",1.0,"Transfer coefficient");
  params.addParam<Real>("Num",1.0,"Number of produced or consumed chemical species per reaction");
  params.addClassDescription(
      "Computes a boundary residual contribution consistent with the Diffusion Kernel. "
      "Does not impose a boundary condition; instead computes the boundary "
      "contribution corresponding to the current value of grad(u) and accumulates "
      "it in the residual vector.");
  return params;
}

ConsumedBC::ConsumedBC(const InputParameters & parameters)
  : IntegratedBC(parameters),
   _E(coupledValue("Corrosion_potential")),
   _C1(coupledValue("Reactant1")),
   _T(coupledValue("Temperature")),
   _F(getParam<Real>("Faraday_constant")),
   _eps(getParam<Real>("Porosity")),
   _R(getParam<Real>("R")),
   _kF(getParam<Real>("kF")),
   _EA(getParam<Real>("StandardPotential")),
   _a(getParam<Real>("TransferCoef")),
   _E_id(coupled("Corrosion_potential")),
   _T_id(coupled("Temperature")),
   _Num(getParam<Real>("Num"))
{
}

Real
ConsumedBC::computeQpResidual()
{
   return -_Num * _test[_i][_qp] * _eps * _kF * _u[_qp] * exp(-_a * _F  / (_R * _T[_qp]) * (_E[_qp] - _EA)); 
}


Real
ConsumedBC::computeQpJacobian()
{
   return -_Num * _test[_i][_qp] * _eps * _kF * _phi[_j][_qp] * exp(-_a * _F / (_R * _T[_qp])*(_E[_qp] - _EA));
}

Real
ConsumedBC::computeQpOffDiagJacobian(unsigned int jvar)
{

   Real Front;
   Front =  -_Num * _test[_i][_qp] * _eps * _kF * _u[_qp];

   Real Factor;
   Factor = _a * _F /_R;

   if (jvar == _E_id)
     return Front * (-Factor/_T[_qp]) * _phi[_j][_qp] * exp(-Factor / _T[_qp] * (_E[_qp] - _EA));
   else if (jvar == _T_id)
     return Front * (Factor * (_E[_qp] - _EA) / _phi[_j][_qp] / _T[_qp]) * exp(-Factor / _T[_qp] * (_E[_qp] - _EA));
   else
     return 0.0;
   
}

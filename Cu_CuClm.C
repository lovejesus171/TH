// 2021.01.24 I have to add reaction products terms. ex) HS- -> Cu+

#include "Cu_CuCl2m.h"

registerMooseObject("corrosionApp", Cu_CuCl2m);

defineLegacyParams(Cu_CuCl2m);

InputParameters
Cu_CuCl2m::validParams()
{
  InputParameters params = IntegratedBC::validParams();
  params.addRequiredCoupledVar("Corrosion_potential","Corrosion potential");
  params.addRequiredCoupledVar("Reactant1","Chemical species");
  params.addRequiredCoupledVar("Temperature","Temperature of the system");
  params.addParam<Real>("Faraday_constant",96485.3329,"Faraday constants, C/mol");
  params.addParam<Real>("Porosity",1.0,"Porosity of porous medium");
  params.addParam<Real>("R",8.314,"Reaction order");
  params.addParam<Real>("kF",0,"Kinetic constant");
  params.addParam<Real>("kB",0,"Reverse reaction");
  params.addParam<Real>("StandardPotential",0,"Standard potential");

 params.addClassDescription(
      "Computes a boundary residual contribution consistent with the Diffusion Kernel. "
      "Does not impose a boundary condition; instead computes the boundary "
      "contribution corresponding to the current value of grad(u) and accumulates "
      "it in the residual vector.");
  return params;
}

Cu_CuCl2m::Cu_CuCl2m(const InputParameters & parameters)
  : IntegratedBC(parameters),
   _E(coupledValue("Corrosion_potential")),
   _C1(coupledValue("Reactant1")),
   _T(coupledValue("Temperature")),
   _F(getParam<Real>("Faraday_constant")),
   _eps(getParam<Real>("Porosity")),
   _R(getParam<Real>("R")),
   _kA(getParam<Real>("kF")),
   _kB(getParam<Real>("kB")),
   _EA(getParam<Real>("Standard_potential"))
{
}

Real
Cu_CuCl2m::computeQpResidual()
{
 
   return -_test[_i][_qp] * _eps *  (_kA * _u[_qp] * _u[_qp] * exp(_F /(_R * _T) * (_E[_qp] - _EA)) - _kB * _C1[_qp]);   
}

Real
Cu_CuCl2m::computeQpJacobian()
{
   return -_test[_i][_qp] * _eps * 2 * _kA * _phi[_j][_qp] * _u[_qp] * exp(_F / (_R * _T)) * (_E[_qp] - _EA) ;
}

Real
Cu_CuCl2m::computeQpOffDiagJacobian(unsigned int jvar)
{
   return 0.0;
}

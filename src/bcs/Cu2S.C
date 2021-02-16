// 2021.01.24 I have to add reaction products terms. ex) HS- -> Cu+

#include "Cu2S.h"

registerMooseObject("corrosionApp", Cu2S);

defineLegacyParams(Cu2S);

InputParameters
Cu2S::validParams()
{
  InputParameters params = IntegratedBC::validParams();
  params.addParam<Real>("Faraday_constant",96485.3329,"Faraday constants, C/mol");
  params.addParam<Real>("Porosity",1.0,"Porosity of porous medium");
  params.addParam<Real>("Kinetic",1.0,"Kinetic constant");
  params.addParam<Real>("AlphaS",0.5,"transfer coefficient");
  params.addRequiredCoupledVar("Corrosion_potential","Corrosion potential");
  params.addParam<Real>("R",8.314,"Reaction order");
  params.addCoupledVar("Temperature",298.15,"Temperature of the system");
  params.addParam<Real>("AlphaS3",0.5,"Transfer coefficient");
  params.addParam<Real>("Standard_potential2",0.0,"Standard_potential");
  params.addParam<Real>("Standard_potential3",0.0,"Standard_potentia3");
  params.addParam<Real>("Num",1,"Number of produced or consumed chemical species per reaction");
  params.addRequiredCoupledVar("Reactant1","HS- anions");
  params.addClassDescription(
      "Computes a boundary residual contribution consistent with the Diffusion Kernel. "
      "Does not impose a boundary condition; instead computes the boundary "
      "contribution corresponding to the current value of grad(u) and accumulates "
      "it in the residual vector.");
  return params;
}

Cu2S::Cu2S(const InputParameters & parameters)
  : IntegratedBC(parameters),
   _F(getParam<Real>("Faraday_constant")),
   _eps(getParam<Real>("Porosity")),
   _kS(getParam<Real>("Kinetic")),
   _aS(getParam<Real>("AlphaS")),
   _E(coupledValue("Corrosion_potential")),
   _R(getParam<Real>("R")),
   _T(coupledValue("Temperature")),
   _aS3(getParam<Real>("AlphaS3")),
   _ES12(getParam<Real>("Standard_potential2")),
   _ES3(getParam<Real>("Standard_potential3")),
   _Num(getParam<Real>("Num")),
   _E_id(coupled("Corrosion_potential")),
   _T_id(coupled("Temperature")),
   _C1(coupledValue("Reactant1")),
   _C1_id(coupled("Reactant1"))

{
}

Real
Cu2S::computeQpResidual()
{
   return -_Num * _test[_i][_qp] * _eps * _kS * _C1[_qp] * _C1[_qp] * exp((1.0 + _aS) * _F /(_R * _T[_qp]) * _E[_qp]) * exp(-_F/(_R * _T[_qp]) * (_ES12 + _aS3 * _ES3));

}

Real
Cu2S::computeQpJacobian()
{
   return 0.0;
}

Real
Cu2S::computeQpOffDiagJacobian(unsigned int jvar)
{
   Real Front;
   Front = -_Num * _test[_i][_qp] * _eps * _kS;

   Real Factor;
   Factor = _F / _R;

   Real ExFactor;
   ExFactor = exp((1+_aS) * _F / _R / _T[_qp]*_E[_qp]) * exp(-_F/_R/_T[_qp] * (_ES12 + _aS3 * _ES3));
   if (jvar == _C1_id)
     return Front * 2 * _phi[_j][_qp] * _C1[_qp] * ExFactor;
   else if (jvar == _E_id)
     return Front * _C1[_qp] * _C1[_qp] * (1.0 + _aS)/(_R * _T[_qp]) * _F * _phi[_j][_qp] * ExFactor;
   else if (jvar == _T_id)
     return Front * _C1[_qp] * _C1[_qp] * Factor / (_T[_qp] * _phi[_j][_qp]) * ExFactor * (1 - (1 + _aS) * _E[_qp]);
   else
     return 0.0;
}

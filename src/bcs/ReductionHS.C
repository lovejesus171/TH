// 2021.01.24 I have to add reaction products terms. ex) HS- -> Cu+

#include "ReductionHS.h"

registerMooseObject("corrosionApp", ReductionHS);

defineLegacyParams(ReductionHS);

InputParameters
ReductionHS::validParams()
{
  InputParameters params = IntegratedBC::validParams();
  params.addParam<Real>("Faraday_constant",96485.3329,"Faraday constants, C/mol");
  params.addRequiredParam<MaterialPropertyName>("Area","Porosity of porous medium");
  params.addParam<Real>("Kinetic",1.0,"Kinetic constant");
  params.addParam<Real>("AlphaS",0.5,"transfer coefficient");
  params.addRequiredParam<MaterialPropertyName>("Corrosion_potential","Corrosion potential");
  params.addParam<Real>("R",8.314,"Reaction order");
  params.addCoupledVar("Temperature",298.15,"Temperature of the system");
  params.addParam<Real>("AlphaS3",0.5,"Transfer coefficient");
  params.addParam<Real>("Standard_potential2",0.0,"Standard_potential");
  params.addParam<Real>("Standard_potential3",0.0,"Standard_potentia3");
  params.addParam<Real>("Num",1,"Number of produced or consumed chemical species per reaction");
  params.addClassDescription(
      "Computes a boundary residual contribution consistent with the Diffusion Kernel. "
      "Does not impose a boundary condition; instead computes the boundary "
      "contribution corresponding to the current value of grad(u) and accumulates "
      "it in the residual vector.");
  return params;
}

ReductionHS::ReductionHS(const InputParameters & parameters)
  : IntegratedBC(parameters),
   _F(getParam<Real>("Faraday_constant")),
   _eps(getMaterialProperty<Real>("Area")),
   _kS(getParam<Real>("Kinetic")),
   _aS(getParam<Real>("AlphaS")),
   _E(getMaterialProperty<Real>("Corrosion_potential")),
   _R(getParam<Real>("R")),
   _T(coupledValue("Temperature")),
   _aS3(getParam<Real>("AlphaS3")),
   _ES12(getParam<Real>("Standard_potential2")),
   _ES3(getParam<Real>("Standard_potential3")),
   _Num(getParam<Real>("Num")),
   _T_id(coupled("Temperature"))
{
}

Real
ReductionHS::computeQpResidual()
{
// if (_u[_qp] - _Num * _test[_i][_qp] * _eps * _kS * _u[_qp] * _u[_qp] * exp(( 1.0 + _aS) * _F /(_R * _T[_qp]) * _E[_qp]) * exp(-_F / (_R * _T[_qp]) * (_ES12 + _aS3 * _ES3 )) >= 0)
//    printf("Corrosion potential: %f \n",_E[_qp]);
//    std::cout << _E[_qp] << "\n";
    return -_Num * _test[_i][_qp] * _eps[_qp] * _kS * _u[_qp] * _u[_qp] * exp(( 1.0 + _aS) * _F /(_R * _T[_qp]) * _E[_qp]) * exp(-_F / (_R * _T[_qp]) * (_ES12 + _aS3 * _ES3 ));   
//  else
}

Real
ReductionHS::computeQpJacobian()
{
    return -_Num * _test[_i][_qp] * _eps[_qp] * _kS * 2 *_phi[_j][_qp] * _u[_qp] * exp(( 1.0 + _aS) * _F /(_R * _T[_qp]) * _E[_qp]) * exp(-_F / (_R * _T[_qp]) * (_ES12 + _aS3 * _ES3 ));   
}

Real
ReductionHS::computeQpOffDiagJacobian(unsigned int jvar)
{
   if (jvar == _T_id)
      return -_Num * _test[_i][_qp] * _eps[_qp] * _kS * _u[_qp] * _u[_qp] * exp(( 1.0 + _aS) * _F /(_R * _T[_qp]) * _E[_qp]) * exp(-_F / (_R * _T[_qp]) * (_ES12 + _aS3 * _ES3 )) * ((1.0 + _aS) * _E[_qp] - (_ES12 + _aS3 * _ES3)) * _F / (_R * _T[_qp] * _T[_qp]) * _phi[_j][_qp];   
   else
      return 0;
}


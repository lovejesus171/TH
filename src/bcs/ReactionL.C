//Production of UO2(CO3)22-

#include "ReactionL.h"

registerMooseObject("corrosionApp", ReactionL);

defineLegacyParams(ReactionL);

InputParameters
ReactionL::validParams()
{
  InputParameters params = IntegratedBC::validParams();
  params.addParam<Real>("Num",1.0,"Put the number to decide production or consumption with + and - sign");
  params.addRequiredParam<MaterialPropertyName>("Porosity","Kinetic constant");
  params.addRequiredParam<MaterialPropertyName>("Kinetic","Kinetic constant");
  params.addRequiredParam<MaterialPropertyName>("DelH","transfer coefficient");
  params.addCoupledVar("Temperature",298.15,"Temperature of the system");
  params.addRequiredParam<MaterialPropertyName>("fraction","Coverage fraction of NMP on UO2");
  params.addRequiredParam<MaterialPropertyName>("Saturation","Saturation name");
  params.addClassDescription(
      "Computes a boundary residual contribution consistent with the Diffusion Kernel. "
      "Does not impose a boundary condition; instead computes the boundary "
      "contribution corresponding to the current value of grad(u) and accumulates "
      "it in the residual vector.");
  return params;
}

ReactionL::ReactionL(const InputParameters & parameters)
  : IntegratedBC(parameters),
   _Num(getParam<Real>("Num")),
   _eps(getMaterialProperty<Real>("Porosity")),
   _k(getMaterialProperty<Real>("Kinetic")),
   _DelH(getMaterialProperty<Real>("DelH")),
   _T(coupledValue("Temperature")),
   _f(getMaterialProperty<Real>("fraction")),
   _Cs(getMaterialProperty<Real>("Saturation")),
   _T_id(coupled("Temperature"))
{
}

Real
ReactionL::computeQpResidual()
{
	Real Tref = 298.15;
	Real F = 96485;
	Real R = 8.314;
     
	if (_u[_qp] >= _Cs[_qp])
          return 0;
	else
          return -_Num * (1 - _f[_qp]) * _eps[_qp] * _k[_qp] * exp(_DelH[_qp]/R * (1/Tref - 1/_T[_qp]));
}

Real
ReactionL::computeQpJacobian()
{

//	Real Tref = 298.15;
//	Real F = 96485;
//	Real R = 8.314;
//        if (_u[_qp] >= _Cs[_qp])
          return 0;
//	else
//	return -_Num * (1 - _f[_qp]) * _eps[_qp] * _k[_qp] * exp(_DelH[_qp]/R * (1/Tref - 1/_T[_qp]));
}

Real
ReactionL::computeQpOffDiagJacobian(unsigned int jvar)
{
	Real Tref = 298.15;
	Real F = 96485;
	Real R = 8.314;

	if (_u[_qp] >= _Cs[_qp])
          return 0;
        else if	(jvar == _T_id)
          return -_Num * (1 - _f[_qp]) * _eps[_qp] * _k[_qp] * exp(_DelH[_qp]/R * (1/Tref - 1/_T[_qp])) * _DelH[_qp] / (R * _T[_qp] * _T[_qp]) * _phi[_j][_qp];
	else
	       return 0;

}


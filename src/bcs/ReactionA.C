//Production of UO2(CO3)22-

#include "ReactionA.h"

registerMooseObject("corrosionApp", ReactionA);

defineLegacyParams(ReactionA);

InputParameters
ReactionA::validParams()
{
  InputParameters params = IntegratedBC::validParams();
  params.addRequiredParam<MaterialPropertyName>("Porosity","Kinetic constant");
  params.addRequiredParam<MaterialPropertyName>("Kinetic","Kinetic constant");
  params.addRequiredParam<MaterialPropertyName>("DelH","transfer coefficient");
  params.addRequiredParam<MaterialPropertyName>("Corrosion_potential","Corrosion potential");
  params.addCoupledVar("Temperature",298.15,"Temperature of the system");
  params.addRequiredParam<MaterialPropertyName>("Alpha","Transfer coefficient");
  params.addRequiredParam<MaterialPropertyName>("Standard_potential","Standard_potential");
  params.addRequiredParam<MaterialPropertyName>("fraction","Coverage fraction");
  params.addClassDescription(
      "Computes a boundary residual contribution consistent with the Diffusion Kernel. "
      "Does not impose a boundary condition; instead computes the boundary "
      "contribution corresponding to the current value of grad(u) and accumulates "
      "it in the residual vector.");
  return params;
}

ReactionA::ReactionA(const InputParameters & parameters)
  : IntegratedBC(parameters),
   _eps(getMaterialProperty<Real>("Porosity")),
   _kA(getMaterialProperty<Real>("Kinetic")),
   _DelH(getMaterialProperty<Real>("DelH")),
   _Ecorr(getMaterialProperty<Real>("Corrosion_potential")),
   _T(coupledValue("Temperature")),
   _aA(getMaterialProperty<Real>("Alpha")),
   _EA(getMaterialProperty<Real>("Standard_potential")),
   _f(getMaterialProperty<Real>("fraction")),
   _T_id(coupled("Temperature"))
{
}

Real
ReactionA::computeQpResidual()
{
	Real Tref = 298.15;
	Real F = 96485;
	Real R = 8.314;
    
//       printf("This is the boundary condition of UO22+ \n");	
          return -_test[_i][_qp] * (1 - _f[_qp]) * _eps[_qp] * _kA[_qp] * exp(_DelH[_qp]/R * (1/Tref - 1/_T[_qp])) * exp(_aA[_qp] * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EA[_qp]));

}

Real
ReactionA::computeQpJacobian()
{
	Real Tref = 298.15;
	Real F = 96485;
	Real R = 8.314;

        return 0;
}

Real
ReactionA::computeQpOffDiagJacobian(unsigned int jvar)
{
	Real Tref = 298.15;
	Real F = 96485;
	Real R = 8.314;

        if	(jvar == _T_id)
               return -_test[_i][_qp] * (1 - _f[_qp]) * _eps[_qp] * _kA[_qp] * exp(_DelH[_qp]/R * (1/Tref - 1/_T[_qp])) * exp(_aA[_qp] * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EA[_qp])) * (_DelH[_qp] - _aA[_qp] * F * (_Ecorr[_qp] - _EA[_qp])) / (R * _T[_qp] * _T[_qp]) * _phi[_j][_qp];
	else
	       return 0;

}


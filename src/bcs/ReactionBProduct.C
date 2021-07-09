//Production of UO2(CO3)22-

#include "ReactionBProduct.h"
#include "MooseVariable.h"
#include <algorithm>
#include <limits>

registerMooseObject("corrosionApp", ReactionBProduct);

defineLegacyParams(ReactionBProduct);

InputParameters
ReactionBProduct::validParams()
{
  InputParameters params = IntegratedBC::validParams();
  params.addParam<Real>("Num",1.0,"Put the number to decide production or consumption with + and - sign");
  params.addRequiredParam<MaterialPropertyName>("Porosity","Kinetic constant");
  params.addRequiredParam<MaterialPropertyName>("Kinetic","Kinetic constant");
  params.addRequiredParam<MaterialPropertyName>("DelH","transfer coefficient");
  params.addRequiredParam<MaterialPropertyName>("Corrosion_potential","Corrosion potential");
  params.addCoupledVar("Temperature",298.15,"Temperature of the system");
  params.addCoupledVar("v",0,"Concentration of chemical species: CO32-");
  params.addRequiredParam<MaterialPropertyName>("Alpha","Transfer coefficient");
  params.addRequiredParam<MaterialPropertyName>("Standard_potential","Standard_potential");
  params.addRequiredParam<MaterialPropertyName>("fraction","Coverage fraction of NMP on UO2");
  params.addClassDescription(
      "Computes a boundary residual contribution consistent with the Diffusion Kernel. "
      "Does not impose a boundary condition; instead computes the boundary "
      "contribution corresponding to the current value of grad(u) and accumulates "
      "it in the residual vector.");
  return params;
}

ReactionBProduct::ReactionBProduct(const InputParameters & parameters)
  : IntegratedBC(parameters),
   _Num(getParam<Real>("Num")),
   _eps(getMaterialProperty<Real>("Porosity")),
   _k(getMaterialProperty<Real>("Kinetic")),
   _DelH(getMaterialProperty<Real>("DelH")),
   _Ecorr(getMaterialProperty<Real>("Corrosion_potential")),
   _T(coupledValue("Temperature")),
   _C(coupledValue("v")),
   _a(getMaterialProperty<Real>("Alpha")),
   _E(getMaterialProperty<Real>("Standard_potential")),
   _f(getMaterialProperty<Real>("fraction")),
   _T_id(coupled("Temperature")),
   _C_id(coupled("v"))
{
}

Real
ReactionBProduct::computeQpResidual()
{
	Real Tref = 298.15;
	Real F = 96485;
	Real R = 8.314;
     
          return -_test[_i][_qp] * _Num * (1 - _f[_qp]) * _eps[_qp] * _k[_qp] * pow(_C[_qp], 0.66) * exp(_DelH[_qp]/R * (1/Tref - 1/_T[_qp])) * exp(_a[_qp] * F /(R * _T[_qp]) * (_Ecorr[_qp] - _E[_qp]));
}

Real
ReactionBProduct::computeQpJacobian()
{
	Real Tref = 298.15;
	Real F = 96485;
	Real R = 8.314;

        return 0;
}

Real
ReactionBProduct::computeQpOffDiagJacobian(unsigned int jvar)
{
	Real Tref = 298.15;
	Real F = 96485;
	Real R = 8.314;

	if (jvar == _C_id)
               return -_test[_i][_qp] * _Num * (1 - _f[_qp]) * _eps[_qp] * _k[_qp] * 0.66 * _phi[_j][_qp] * pow(_C[_qp], -0.34) * exp(_DelH[_qp]/R * (1/Tref - 1/_T[_qp])) * exp(_a[_qp] * F /(R * _T[_qp]) * (_Ecorr[_qp] - _E[_qp]));
	else if	(jvar == _T_id)
               return -_test[_i][_qp] * _Num * (1 - _f[_qp]) * _eps[_qp] * _k[_qp] * pow(_C[_qp], 0.66) * exp(_DelH[_qp]/R * (1/Tref - 1/_T[_qp])) * exp(_a[_qp] * F /(R * _T[_qp]) * (_Ecorr[_qp] - _E[_qp])) * (_DelH[_qp] - _a[_qp] * F * (_Ecorr[_qp] - _E[_qp])) / (R * _T[_qp] * _T[_qp]) * _phi[_j][_qp];
	else
	       return 0;

}


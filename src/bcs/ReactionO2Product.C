//Production of UO2(CO3)22-

#include "ReactionO2Product.h"

registerMooseObject("corrosionApp", ReactionO2Product);

defineLegacyParams(ReactionO2Product);

InputParameters
ReactionO2Product::validParams()
{
  InputParameters params = IntegratedBC::validParams();
  params.addParam<Real>("Num",1.0,"Put the number to decide production or consumption with + and - sign");
  params.addRequiredParam<MaterialPropertyName>("Porosity","Kinetic constant");
  params.addRequiredParam<MaterialPropertyName>("Kinetic1","Kinetic constant");
  params.addRequiredParam<MaterialPropertyName>("DelH","transfer coefficient");
  params.addRequiredParam<MaterialPropertyName>("Corrosion_potential","Corrosion potential");
  params.addCoupledVar("Temperature",298.15,"Temperature of the system");
  params.addCoupledVar("v",298.15,"Put H2");
  params.addRequiredParam<MaterialPropertyName>("Alpha1","Transfer coefficient");
  params.addRequiredParam<MaterialPropertyName>("Standard_potential1","Standard_potential");
  params.addRequiredParam<MaterialPropertyName>("fraction","Coverage fraction of NMP on UO2");
  params.addClassDescription(
      "Computes a boundary residual contribution consistent with the Diffusion Kernel. "
      "Does not impose a boundary condition; instead computes the boundary "
      "contribution corresponding to the current value of grad(u) and accumulates "
      "it in the residual vector.");
  return params;
}

ReactionO2Product::ReactionO2Product(const InputParameters & parameters)
  : IntegratedBC(parameters),
   _Num(getParam<Real>("Num")),
   _eps(getMaterialProperty<Real>("Porosity")),
   _k1(getMaterialProperty<Real>("Kinetic1")),
   _DelH(getMaterialProperty<Real>("DelH")),
   _Ecorr(getMaterialProperty<Real>("Corrosion_potential")),
   _T(coupledValue("Temperature")),
   _v(coupledValue("v")),
   _a1(getMaterialProperty<Real>("Alpha1")),
   _E1(getMaterialProperty<Real>("Standard_potential1")),
   _f(getMaterialProperty<Real>("fraction")),
   _T_id(coupled("Temperature")),
   _v_id(coupled("v"))
{
}

Real
ReactionO2Product::computeQpResidual()
{
	Real Tref = 298.15;
	Real F = 96485;
	Real R = 8.314;

     if (_v[_qp] <= 0)
        return 0;
     else     
        return -_test[_i][_qp] * _Num *  (1 - _f[_qp]) * _eps[_qp] * _k1[_qp] * _v[_qp] * exp(_DelH[_qp]/R * (1/Tref - 1/_T[_qp])) * exp(_a1[_qp] * F /(R * _T[_qp]) * (_Ecorr[_qp] - _E1[_qp]));
}
Real
ReactionO2Product::computeQpJacobian()
{
        return 0;
}


Real
ReactionO2Product::computeQpOffDiagJacobian(unsigned int jvar)
{
	Real Tref = 298.15;
	Real F = 96485;
	Real R = 8.314;

	if (_v[_qp] <= 0)
		return 0;
	else if (jvar == _T_id)
          return -_test[_i][_qp] * _Num *  (1 - _f[_qp]) * _eps[_qp] * _k1[_qp] * _v[_qp] * exp(_DelH[_qp]/R * (1/Tref - 1/_T[_qp])) * exp(_a1[_qp] * F /(R * _T[_qp]) * (_Ecorr[_qp] - _E1[_qp])) * (_DelH[_qp] - _a1[_qp] * F * (_Ecorr[_qp] - _E1[_qp])) / (R * _T[_qp] * _T[_qp]) * _phi[_j][_qp];
	else if (jvar == _v_id)
          return -_test[_i][_qp] * _Num *  (1 - _f[_qp]) * _eps[_qp] * _k1[_qp] * _phi[_j][_qp] * exp(_DelH[_qp]/R * (1/Tref - 1/_T[_qp])) * exp(_a1[_qp] * F /(R * _T[_qp]) * (_Ecorr[_qp] - _E1[_qp]));
	else
	       return 0;

}


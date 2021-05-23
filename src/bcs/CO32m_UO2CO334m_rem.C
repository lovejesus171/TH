//Production of UO2(CO3)22-

#include "CO32m_UO2CO334m_rem.h"

registerMooseObject("corrosionApp", CO32m_UO2CO334m_rem);

defineLegacyParams(CO32m_UO2CO334m_rem);

InputParameters
CO32m_UO2CO334m_rem::validParams()
{
  InputParameters params = IntegratedBC::validParams();
  params.addParam<Real>("Num1",3.0,"Put the number to decide production or consumption with + and - sign");
  params.addParam<Real>("Porosity",1.0,"Kinetic constant");
  params.addParam<Real>("Kinetic1",1.3E-8,"Kinetic constant");
  params.addParam<Real>("DelH",6E4,"transfer coefficient");
  params.addRequiredParam<MaterialPropertyName>("Corrosion_potential","Corrosion potential");
  params.addCoupledVar("Temperature",298.15,"Temperature of the system");
  params.addParam<Real>("Alpha1",0.82,"Transfer coefficient");
  params.addParam<Real>("Standard_potential1",0.184,"Standard_potential");
  params.addParam<Real>("m",0.66,"Reaction order constant");
  params.addParam<Real>("fraction",1,"Coverage fraction of NMP on UO2");
  params.addClassDescription(
      "Computes a boundary residual contribution consistent with the Diffusion Kernel. "
      "Does not impose a boundary condition; instead computes the boundary "
      "contribution corresponding to the current value of grad(u) and accumulates "
      "it in the residual vector.");
  return params;
}

CO32m_UO2CO334m_rem::CO32m_UO2CO334m_rem(const InputParameters & parameters)
  : IntegratedBC(parameters),
   _Num1(getParam<Real>("Num1")),
   _eps(getParam<Real>("Porosity")),
   _k1(getParam<Real>("Kinetic1")),
   _DelH(getParam<Real>("DelH")),
   _Ecorr(getMaterialProperty<Real>("Corrosion_potential")),
   _T(coupledValue("Temperature")),
   _a1(getParam<Real>("Alpha1")),
   _E1(getParam<Real>("Standard_potential1")),
   _m(getParam<Real>("m")),
   _f(getParam<Real>("fraction")),
   _T_id(coupled("Temperature"))
{
}

Real
CO32m_UO2CO334m_rem::computeQpResidual()
{
	Real Tref = 298.15;
	Real F = 96485;
	Real R = 8.314;
     
          return -_test[_i][_qp] * _Num1 * (1 - _f) * _eps * _k1 * pow(_u[_qp], _m) * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * exp(_a1 * F /(R * _T[_qp]) * (_Ecorr[_qp] - _E1))
;

}

Real
CO32m_UO2CO334m_rem::computeQpJacobian()
{
	Real Tref = 298.15;
	Real F = 96485;
	Real R = 8.314;

          return -_test[_i][_qp] * _Num1 * (1 - _f) * _eps * _k1 * _m * _phi[_j][_qp] * pow(_u[_qp], _m-1) * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * exp(_a1 * F /(R * _T[_qp]) * (_Ecorr[_qp] - _E1))
;

}

Real
CO32m_UO2CO334m_rem::computeQpOffDiagJacobian(unsigned int jvar)
{
	Real Tref = 298.15;
	Real F = 96485;
	Real R = 8.314;

	return -_test[_i][_qp] * _Num1 * (1 - _f) * _eps * _k1 * pow(_u[_qp], _m) * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * exp(_a1 * F /(R * _T[_qp]) * (_Ecorr[_qp] - _E1)) * (_DelH - _a1 * F * (_Ecorr[_qp] - _E1)) / (R * _T[_qp] * _T[_qp]) * _phi[_j][_qp];
;

}


//Production of UO2(CO3)22-

#include "UO2CO334m_BC_rem.h"
#include "MooseVariable.h"
#include <algorithm>
#include <limits>

registerMooseObject("corrosionApp", UO2CO334m_BC_rem);

defineLegacyParams(UO2CO334m_BC_rem);

InputParameters
UO2CO334m_BC_rem::validParams()
{
  InputParameters params = IntegratedBC::validParams();
  params.addParam<Real>("Num",1.0,"Put the number to decide production or consumption with + and - sign");
  params.addParam<Real>("Porosity",1.0,"Kinetic constant");
  params.addParam<Real>("Kinetic",1.3E-8,"Kinetic constant");
  params.addParam<Real>("DelH",6E4,"transfer coefficient");
  params.addRequiredParam<MaterialPropertyName>("Corrosion_potential","Corrosion potential");
  params.addCoupledVar("Temperature",298.15,"Temperature of the system");
  params.addCoupledVar("v",0,"Concentration of chemical species: CO32-");
  params.addParam<Real>("Alpha",0.82,"Transfer coefficient");
  params.addParam<Real>("Standard_potential",0.046,"Standard_potential");
  params.addParam<Real>("m",1,"Reaction order constant");
  params.addParam<Real>("fraction",1,"Coverage fraction of NMP on UO2");
  params.addClassDescription(
      "Computes a boundary residual contribution consistent with the Diffusion Kernel. "
      "Does not impose a boundary condition; instead computes the boundary "
      "contribution corresponding to the current value of grad(u) and accumulates "
      "it in the residual vector.");
  return params;
}

UO2CO334m_BC_rem::UO2CO334m_BC_rem(const InputParameters & parameters)
  : IntegratedBC(parameters),
   _Num(getParam<Real>("Num")),
   _eps(getParam<Real>("Porosity")),
   _k(getParam<Real>("Kinetic")),
   _DelH(getParam<Real>("DelH")),
   _Ecorr(getMaterialProperty<Real>("Corrosion_potential")),
   _T(coupledValue("Temperature")),
   _C(coupledValue("v")),
   _a(getParam<Real>("Alpha")),
   _E(getParam<Real>("Standard_potential")),
   _m(getParam<Real>("m")),
   _f(getParam<Real>("fraction")),
   _T_id(coupled("Temperature")),
   _C_id(coupled("v"))
{
}

Real
UO2CO334m_BC_rem::computeQpResidual()
{
	Real Tref = 298.15;
	Real F = 96485;
	Real R = 8.314;
     
          return -_test[_i][_qp] * _Num * _f * _eps * _k * pow(_C[_qp],0.66) * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * exp(_a * F /(R * _T[_qp]) * (_Ecorr[_qp] - _E));
}

Real
UO2CO334m_BC_rem::computeQpJacobian()
{
	Real Tref = 298.15;
	Real F = 96485;
	Real R = 8.314;

        return 0;
}

Real
UO2CO334m_BC_rem::computeQpOffDiagJacobian(unsigned int jvar)
{
	Real Tref = 298.15;
	Real F = 96485;
	Real R = 8.314;

	if (jvar == _C_id)
               return -_test[_i][_qp] * _Num * _f * _eps * _k * 0.66 * _phi[_j][_qp] * pow(_C[_qp], -0.34) * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * exp(_a * F /(R * _T[_qp]) * (_Ecorr[_qp] - _E));
	else if	(jvar == _T_id)
               return -_test[_i][_qp] * _Num * _f * _eps * _k * pow(_C[_qp], 0.66)  * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * exp(_a * F /(R * _T[_qp]) * (_Ecorr[_qp] - _E)) * (_DelH - _a * F * (_Ecorr[_qp] - _E)) / (R * _T[_qp] * _T[_qp]) * _phi[_j][_qp];
	else
	       return 0;

}


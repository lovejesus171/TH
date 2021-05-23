//Production of UO2(CO3)22-

#include "Chem_rem.h"

registerMooseObject("corrosionApp", Chem_rem);

defineLegacyParams(Chem_rem);

InputParameters
Chem_rem::validParams()
{
  InputParameters params = IntegratedBC::validParams();
  params.addParam<Real>("Num",1.0,"Put the number to decide production or consumption with + and - sign");
  params.addParam<Real>("Porosity",1.0,"Kinetic constant");
  params.addParam<Real>("Kinetic",1.3E-8,"Kinetic constant");
  params.addParam<Real>("DelH",6E4,"transfer coefficient");
  params.addCoupledVar("Temperature",298.15,"Temperature of the system");
  params.addParam<Real>("m",1,"Reaction order constant");
  params.addParam<Real>("fraction",1,"Coverage fraction of NMP on UO2");
  params.addRequiredParam<MaterialPropertyName>("Saturation","Saturation name");
  params.addClassDescription(
      "Computes a boundary residual contribution consistent with the Diffusion Kernel. "
      "Does not impose a boundary condition; instead computes the boundary "
      "contribution corresponding to the current value of grad(u) and accumulates "
      "it in the residual vector.");
  return params;
}

Chem_rem::Chem_rem(const InputParameters & parameters)
  : IntegratedBC(parameters),
   _Num(getParam<Real>("Num")),
   _eps(getParam<Real>("Porosity")),
   _k(getParam<Real>("Kinetic")),
   _DelH(getParam<Real>("DelH")),
   _T(coupledValue("Temperature")),
   _m(getParam<Real>("m")),
   _f(getParam<Real>("fraction")),
   _T_id(coupled("Temperature"))
{
}

Real
Chem_rem::computeQpResidual()
{
	Real Tref = 298.15;
	Real F = 96485;
	Real R = 8.314;
     
          return -_test[_i][_qp] * _Num * _f * _eps * _k * exp(_DelH/R * (1/Tref - 1/_T[_qp]));
}

Real
Chem_rem::computeQpJacobian()
{

          return 0;
}

Real
Chem_rem::computeQpOffDiagJacobian(unsigned int jvar)
{
	Real Tref = 298.15;
	Real F = 96485;
	Real R = 8.314;

        if	(jvar == _T_id)
          return -_test[_i][_qp] * _Num * _f * _eps * _k * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * _DelH / (R * _T[_qp] * _T[_qp]) * _phi[_j][_qp];
	else
	       return 0;

}


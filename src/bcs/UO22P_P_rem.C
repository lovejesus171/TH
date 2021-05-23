//Production of UO2(CO3)22-

#include "UO22P_P_rem.h"

registerMooseObject("corrosionApp", UO22P_P_rem);

defineLegacyParams(UO22P_P_rem);

InputParameters
UO22P_P_rem::validParams()
{
  InputParameters params = IntegratedBC::validParams();
  params.addParam<Real>("Porosity",1.0,"Kinetic constant");
  params.addParam<Real>("Kinetic",1.0,"Kinetic constant");
  params.addParam<Real>("DelH",6E4,"transfer coefficient");
  params.addRequiredParam<MaterialPropertyName>("Corrosion_potential","Corrosion potential");
  params.addCoupledVar("Temperature",298.15,"Temperature of the system");
  params.addParam<Real>("Alpha",0.96,"Transfer coefficient");
  params.addParam<Real>("Standard_potential",0.453,"Standard_potential");
  params.addParam<Real>("fraction",1,"Coverage fraction");
  params.addClassDescription(
      "Computes a boundary residual contribution consistent with the Diffusion Kernel. "
      "Does not impose a boundary condition; instead computes the boundary "
      "contribution corresponding to the current value of grad(u) and accumulates "
      "it in the residual vector.");
  return params;
}

UO22P_P_rem::UO22P_P_rem(const InputParameters & parameters)
  : IntegratedBC(parameters),
   _eps(getParam<Real>("Porosity")),
   _kA(getParam<Real>("Kinetic")),
   _DelH(getParam<Real>("DelH")),
   _Ecorr(getMaterialProperty<Real>("Corrosion_potential")),
   _T(coupledValue("Temperature")),
   _aA(getParam<Real>("Alpha")),
   _EA(getParam<Real>("Standard_potential")),
   _f(getParam<Real>("fraction")),
   _T_id(coupled("Temperature"))
{
}

Real
UO22P_P_rem::computeQpResidual()
{
	Real Tref = 298.15;
	Real F = 96485;
	Real R = 8.314;
    
//       printf("This is the boundary condition of UO22+ \n");	
          return -_test[_i][_qp] * _f * _eps * _kA * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * exp(_aA * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EA));

}

Real
UO22P_P_rem::computeQpJacobian()
{
	Real Tref = 298.15;
	Real F = 96485;
	Real R = 8.314;

        return 0;
}

Real
UO22P_P_rem::computeQpOffDiagJacobian(unsigned int jvar)
{
	Real Tref = 298.15;
	Real F = 96485;
	Real R = 8.314;

        if	(jvar == _T_id)
               return -_test[_i][_qp] * _f * _eps * _kA * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * exp(_aA * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EA)) * (_DelH - _aA * F * (_Ecorr[_qp] - _EA)) / (R * _T[_qp] * _T[_qp]) * _phi[_j][_qp];
	else
	       return 0;

}


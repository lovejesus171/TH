//Production of UO2(CO3)22-

#include "AAA.h"

registerMooseObject("corrosionApp", AAA);

defineLegacyParams(AAA);

InputParameters
AAA::validParams()
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
  params.addRequiredParam<MaterialPropertyName>("Saturation","Saturation name");
  params.addClassDescription(
      "Computes a boundary residual contribution consistent with the Diffusion Kernel. "
      "Does not impose a boundary condition; instead computes the boundary "
      "contribution corresponding to the current value of grad(u) and accumulates "
      "it in the residual vector.");
  return params;
}

AAA::AAA(const InputParameters & parameters)
  : IntegratedBC(parameters),
   _eps(getParam<Real>("Porosity")),
   _kA(getParam<Real>("Kinetic")),
   _DelH(getParam<Real>("DelH")),
   _Ecorr(getMaterialProperty<Real>("Corrosion_potential")),
   _T(coupledValue("Temperature")),
   _aA(getParam<Real>("Alpha")),
   _EA(getParam<Real>("Standard_potential")),
   _f(getParam<Real>("fraction")),
   _Cs(getMaterialProperty<Real>("Saturation")),
   _T_id(coupled("Temperature"))
{
}

Real
AAA::computeQpResidual()
{
	Real Tref = 298.15;
	Real F = 96485;
	Real R = 8.314;
     
          return -_f * _eps * _kA * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * exp(_aA * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EA));

}

Real
AAA::computeQpJacobian()
{
	Real Tref = 298.15;
	Real F = 96485;
	Real R = 8.314;

        return 0;
}

Real
AAA::computeQpOffDiagJacobian(unsigned int jvar)
{
	Real Tref = 298.15;
	Real F = 96485;
	Real R = 8.314;

        if (jvar == _T_id)
               return -_f * _eps * _kA * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * exp(_aA * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EA)) * (_DelH - _aA * F * (_Ecorr[_qp] - _EA)) / (R * _T[_qp] * _T[_qp]) * _phi[_j][_qp];
       	//* (_DelH/R * (1 / (_phi[_j][_qp] * _T[_qp])) - _aA * F / (R * _T[_qp] * _phi[_j][_qp]));
	else
	       return 0;

}


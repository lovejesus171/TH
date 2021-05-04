//Production of UO22+ 

#include "UO22P_P.h"

registerMooseObject("corrosionApp", UO22P_P);

defineLegacyParams(UO22P_P);

InputParameters
UO22P_P::validParams()
{
  InputParameters params = ADIntegratedBC::validParams();
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

UO22P_P::UO22P_P(const InputParameters & parameters)
  : ADIntegratedBC(parameters),
   _eps(getParam<Real>("Porosity")),
   _kA(getParam<Real>("Kinetic")),
   _DelH(getParam<Real>("DelH")),
   _Ecorr(getADMaterialProperty<Real>("Corrosion_potential")),
   _T(adCoupledValue("Temperature")),
   _aA(getParam<Real>("Alpha")),
   _EA(getParam<Real>("Standard_potential")),
   _f(getParam<Real>("fraction"))
{
}

ADReal
UO22P_P::computeQpResidual()
{
	Real Tref = 298.15;
	Real F = 96485;
	Real R = 8.314;

        return _f * _eps * _kA * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * exp(_aA * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EA));
}

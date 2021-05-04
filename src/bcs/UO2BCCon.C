//Production of UO2(CO3)22-

#include "UO2BCCon.h"

registerMooseObject("corrosionApp", UO2BCCon);

defineLegacyParams(UO2BCCon);

InputParameters
UO2BCCon::validParams()
{
  InputParameters params = ADIntegratedBC::validParams();
  params.addParam<Real>("Num",1.0,"Put the number to decide production or consumption with + and - sign");
  params.addParam<Real>("Porosity",1.0,"Kinetic constant");
  params.addParam<Real>("Kinetic",1.3E-8,"Kinetic constant");
  params.addParam<Real>("DelH",6E4,"transfer coefficient");
  params.addRequiredParam<MaterialPropertyName>("Corrosion_potential","Corrosion potential");
  params.addCoupledVar("Temperature",298.15,"Temperature of the system");
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

UO2BCCon::UO2BCCon(const InputParameters & parameters)
  : ADIntegratedBC(parameters),
   _Num(getParam<Real>("Num")),
   _eps(getParam<Real>("Porosity")),
   _k(getParam<Real>("Kinetic")),
   _DelH(getParam<Real>("DelH")),
   _Ecorr(getADMaterialProperty<Real>("Corrosion_potential")),
   _T(adCoupledValue("Temperature")),
   _a(getParam<Real>("Alpha")),
   _E(getParam<Real>("Standard_potential")),
   _m(getParam<Real>("m")),
   _f(getParam<Real>("fraction"))
{
}

ADReal
UO2BCCon::computeQpResidual()
{
	Real Tref = 298.15;
	Real F = 96485;
	Real R = 8.314;

        return _Num * _f * _eps * _k * pow(_u[_qp], _m) * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * exp(_a * F /(R * _T[_qp]) * (_Ecorr[_qp] - _E));
}

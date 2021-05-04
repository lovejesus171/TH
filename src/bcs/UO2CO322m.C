//Production of UO2(CO3)22-

#include "UO2CO322m.h"

registerMooseObject("corrosionApp", UO2CO322m);

defineLegacyParams(UO2CO322m);

InputParameters
UO2CO322m::validParams()
{
  InputParameters params = ADIntegratedBC::validParams();
  params.addParam<Real>("Num",1.0,"Put the number to decide production or consumption with + and - sign");
  params.addParam<Real>("Porosity",1.0,"Kinetic constant");
  params.addParam<Real>("Kinetic",1.3E-8,"Kinetic constant");
  params.addParam<Real>("DelH",6E4,"transfer coefficient");
  params.addRequiredParam<MaterialPropertyName>("Corrosion_potential","Corrosion potential");
  params.addCoupledVar("Temperature",298.15,"Temperature of the system");
  params.addCoupledVar("Chemical",0,"Concentration of chemical species: CO32-");
  params.addParam<Real>("Alpha",0.82,"Transfer coefficient");
  params.addParam<Real>("Standard_potential",0.046,"Standard_potential");
  params.addParam<Real>("m",1,"Reaction order constant");
  params.addClassDescription(
      "Computes a boundary residual contribution consistent with the Diffusion Kernel. "
      "Does not impose a boundary condition; instead computes the boundary "
      "contribution corresponding to the current value of grad(u) and accumulates "
      "it in the residual vector.");
  return params;
}

UO2CO322m::UO2CO322m(const InputParameters & parameters)
  : ADIntegratedBC(parameters),
   _Num(getParam<Real>("Num")),
   _eps(getParam<Real>("Porosity")),
   _k(getParam<Real>("Kinetic")),
   _DelH(getParam<Real>("DelH")),
   _Ecorr(getADMaterialProperty<Real>("Corrosion_potential")),
   _T(adCoupledValue("Temperature")),
   _C(adCoupledValue("Concentration")),
   _a(getParam<Real>("Alpha")),
   _E(getParam<Real>("Standard_potential")),
   _m(getParam<Real>("m"))
{
}

ADReal
UO2CO322m::computeQpResidual()
{
	Real Tref = 298.15;
	Real F = 96485;
	Real R = 8.314;

        return _Num * _eps * _k * pow(_C[_qp], _m) * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * exp(_a * F /(R * _T[_qp]) * (_Ecorr[_qp] - _E));
}

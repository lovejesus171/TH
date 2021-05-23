//Production of UO2(CO3)22-

#include "H2.h"

registerMooseObject("corrosionApp", H2);

defineLegacyParams(H2);

InputParameters
H2::validParams()
{
  InputParameters params = ADIntegratedBC::validParams();
  params.addParam<Real>("Num1",1.0,"Put the number to decide production or consumption with + and - sign");
  params.addParam<Real>("Num2",1.0,"Put the number to decide production or consumption with + and - sign");
  params.addParam<Real>("Porosity",1.0,"Kinetic constant");
  params.addParam<Real>("Kinetic1",3.6E-12,"Kinetic constant");
  params.addParam<Real>("Kinetic2",1E-6,"Kinetic constant");
  params.addParam<Real>("DelH",6E4,"transfer coefficient");
  params.addRequiredParam<MaterialPropertyName>("Corrosion_potential","Corrosion potential");
  params.addCoupledVar("Temperature",298.15,"Temperature of the system");
  params.addParam<Real>("Alpha1",0.5,"Transfer coefficient");
  params.addParam<Real>("Alpha2",0.5,"Transfer coefficient");
  params.addParam<Real>("Standard_potential1",0.049,"Standard_potential");
  params.addParam<Real>("Standard_potential2",0.049,"Standard_potential");
  params.addParam<Real>("m",1,"Reaction order constant");
  params.addParam<Real>("fraction",0.99,"Coverage fraction of NMP on UO2");
  params.addClassDescription(
      "Computes a boundary residual contribution consistent with the Diffusion Kernel. "
      "Does not impose a boundary condition; instead computes the boundary "
      "contribution corresponding to the current value of grad(u) and accumulates "
      "it in the residual vector.");
  return params;
}

H2::H2(const InputParameters & parameters)
  : ADIntegratedBC(parameters),
   _Num1(getParam<Real>("Num1")),
   _Num2(getParam<Real>("Num2")),
   _eps(getParam<Real>("Porosity")),
   _k1(getParam<Real>("Kinetic1")),
   _k2(getParam<Real>("Kinetic2")),
   _DelH(getParam<Real>("DelH")),
   _Ecorr(getADMaterialProperty<Real>("Corrosion_potential")),
   _T(adCoupledValue("Temperature")),
   _a1(getParam<Real>("Alpha1")),
   _a2(getParam<Real>("Alpha2")),
   _E1(getParam<Real>("Standard_potential1")),
   _E2(getParam<Real>("Standard_potential2")),
   _m(getParam<Real>("m")),
   _f(getParam<Real>("fraction"))
{
}

ADReal
H2::computeQpResidual()
{
	Real Tref = 298.15;
	Real F = 96485;
	Real R = 8.314;

        return -_Num1 * (1 - _f) * _eps * _k1 * pow(_u[_qp], _m) * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * exp(_a1 * F /(R * _T[_qp]) * (_Ecorr[_qp] - _E1))
	       -_Num2 * _f * _eps * _k2 * pow(_u[_qp], _m) * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * exp(_a2 * F /(R * _T[_qp]) * (_Ecorr[_qp] - _E2));
}

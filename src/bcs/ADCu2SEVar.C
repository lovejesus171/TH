// 2021.01.24 I have to add reaction products terms. ex) HS- -> Cu+

#include "ADCu2SEVar.h"
#include <vector>

registerMooseObject("corrosionApp", ADCu2SEVar);

defineLegacyParams(ADCu2SEVar);

InputParameters
ADCu2SEVar::validParams()
{
  InputParameters params = ADIntegratedBC::validParams();
  params.addParam<Real>("Faraday_constant",96485.3329,"Faraday constants, C/mol");
  params.addRequiredParam<MaterialPropertyName>("Area","Porosity of porous medium");
  params.addParam<Real>("Kinetic",1.0,"Kinetic constant");
  params.addParam<Real>("AlphaS",0.5,"transfer coefficient");
  params.addRequiredCoupledVar("Corrosion_potential","Corrosion potential");
  params.addParam<Real>("R",8.314,"Reaction order");
  params.addCoupledVar("Temperature",298.15,"Temperature of the system");
  params.addParam<Real>("AlphaS3",0.5,"Transfer coefficient");
  params.addParam<Real>("Standard_potential2",0.0,"Standard_potential");
  params.addParam<Real>("Standard_potential3",0.0,"Standard_potentia3");
  params.addParam<Real>("Num",1,"Number of produced or consumed chemical species per reaction");
  params.addRequiredCoupledVar("Reactant1","HS- anions");
  params.addClassDescription(
      "Computes a boundary residual contribution consistent with the Diffusion Kernel. "
      "Does not impose a boundary condition; instead computes the boundary "
      "contribution corresponding to the current value of grad(u) and accumulates "
      "it in the residual vector.");
  return params;
}

ADCu2SEVar::ADCu2SEVar(const InputParameters & parameters)
  : ADIntegratedBC(parameters),
   _F(getParam<Real>("Faraday_constant")),
   _eps(getADMaterialProperty<Real>("Area")),
   _kS(getParam<Real>("Kinetic")),
   _aS(getParam<Real>("AlphaS")),
   _E(adCoupledValue("Corrosion_potential")),
   _R(getParam<Real>("R")),
   _T(adCoupledValue("Temperature")),
   _aS3(getParam<Real>("AlphaS3")),
   _ES12(getParam<Real>("Standard_potential2")),
   _ES3(getParam<Real>("Standard_potential3")),
   _Num(getParam<Real>("Num")),
   _C1(adCoupledValue("Reactant1"))
{
}

ADReal
ADCu2SEVar::computeQpResidual()
{


//	int n = _qrule->n_points();
//	std::array<Real,n> psi = _E[_qp];

//	std::vector<double> psi;

//        std::array<Real,50> psi;

//	for (unsigned int qp = 0; qp < _qrule->n_points(); ++qp)
//	{
//	       psi[qp] = _E[qp];
//	}

//	std::cout << "In BC Ecorr: : " << _E[_qp] << std::endl;
	return -_Num * _test[_i][_qp] * _eps[_qp] * _kS * _C1[_qp] * _C1[_qp] * exp((1.0 + _aS) * _F /(_R * _T[_qp]) * _E[_qp]) * exp(-_F/(_R * _T[_qp]) * (_ES12 + _aS3 * _ES3));
}

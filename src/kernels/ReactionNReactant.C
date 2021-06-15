#include "ReactionNReactant.h"

// MOOSE includes
#include "MooseVariable.h"
#include <algorithm>
#include <limits>

registerMooseObject("corrosionApp", ReactionNReactant);

template <>
InputParameters
validParams<ReactionNReactant>()
{
  InputParameters params = validParams<Kernel>();
  params.addRequiredParam<MaterialPropertyName>("Reaction_rate","Reaction rate coefficient.");
  params.addRequiredParam<Real>("Num", "The stoichiometric coeffient.");
  params.addRequiredParam<MaterialPropertyName>("Activation_energy", "Put the activation energy of the reaction.");
  params.addRequiredParam<MaterialPropertyName>("Saturation","Put the saturated concentration.");
  params.addRequiredCoupledVar("v","Coupled concentration");
  params.addRequiredCoupledVar("T","Temperature of electrolyte or the system");

  params.addParam<std::string>(
      "number",
      "",
      "The reaction number. Optional, just for material property naming purposes. If a single "
      "reaction has multiple different rate coefficients (frequently the case when multiple "
      "species are lumped together to simplify a reaction network), this will prevent the same "
      "material property from being declared multiple times.");
  return params;
}

ReactionNReactant::ReactionNReactant(const InputParameters & parameters)
  : Kernel(parameters),
    _Reaction_rate(getMaterialProperty<Real>("Reaction_rate")),
    _Num(getParam<Real>("Num")),
    _Ea(getMaterialProperty<Real>("Activation_energy")),
    _Cs(getMaterialProperty<Real>("Saturation")),
    _v(coupledValue("v")),
    _T(coupledValue("T")),
    _T_id(coupled("T"))
{
}

Real
ReactionNReactant::computeQpResidual()
{
  Real R = 8.314;
  Real T_Re = 298.15;

  Real vv = _v[_qp] - _Reaction_rate[_qp] * _v[_qp];

  if (_u[_qp] <= _Cs[_qp] || _u[_qp] <= 0 || vv <= 0)
	  {
		  //printf("Return 0 \n");
		  return 0;
	  }
  else
  {//printf("Return Non Zero \n");
          return -_test[_i][_qp] * _Num * _Reaction_rate[_qp] * exp(_Ea[_qp] / R * (1/T_Re - 1/_T[_qp])) * (_u[_qp] - _Cs[_qp]);}
}

Real
ReactionNReactant::computeQpJacobian()
{
  Real R = 8.314;
  Real T_Re = 298.15;
  Real k;
  Real vv = _v[_qp] - _Reaction_rate[_qp] * _v[_qp];

  k = _Num * _Reaction_rate[_qp] * exp(_Ea[_qp] / R * (1/T_Re - 1/_T[_qp])) * (_u[_qp] - _Cs[_qp]);

    if (_u[_qp] <= _Cs[_qp] || _u[_qp] <= 0 || vv <= 0)
	return 0;
    else
	return -_test[_i][_qp] * _Num * _Reaction_rate[_qp] * exp(_Ea[_qp] / R * (1/T_Re - 1/_T[_qp])) * _phi[_j][_qp];

}

Real
ReactionNReactant::computeQpOffDiagJacobian(unsigned int jvar)
{
  Real R = 8.314;
  Real T_Re = 298.15;
  Real vv = _v[_qp] - _Reaction_rate[_qp] * _v[_qp];
    if (_u[_qp] <= _Cs[_qp] || _u[_qp] <= 0 || vv <= 0)
	    return 0;
    else if (jvar == _T_id)
	return -_test[_i][_qp] * _Num * _Reaction_rate[_qp] * _Ea[_qp] / (R * _T[_qp] * _T[_qp]) * _phi[_j][_qp] * exp(_Ea[_qp] / R * (1/T_Re - 1/_T[_qp])) * (_u[_qp] - _Cs[_qp]);
    else
	    return 0;
}

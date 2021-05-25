#include "ReactionUReactant.h"

// MOOSE includes
#include "MooseVariable.h"
#include <algorithm>
#include <limits>

registerMooseObject("corrosionApp", ReactionUReactant);

template <>
InputParameters
validParams<ReactionUReactant>()
{
  InputParameters params = validParams<Kernel>();
  params.addRequiredParam<MaterialPropertyName>("Reaction_rate","Reaction rate coefficient.");
  params.addRequiredParam<Real>("Num", "The stoichiometric coeffient.");
  params.addRequiredParam<MaterialPropertyName>("Activation_energy", "Put the activation energy of the reaction.");
  params.addRequiredCoupledVar("T","Temperature of electrolyte or the system");
  params.addRequiredCoupledVar("v","Reactant concentration");
  return params;
}

ReactionUReactant::ReactionUReactant(const InputParameters & parameters)
  : Kernel(parameters),
    _Reaction_rate(getMaterialProperty<Real>("Reaction_rate")),
    _Num(getParam<Real>("Num")),
    _Ea(getMaterialProperty<Real>("Activation_energy")),
    _T(coupledValue("T")),
    _v(coupledValue("v")),
    _T_id(coupled("T")),
    _v_id(coupled("v"))
{
}

Real
ReactionUReactant::computeQpResidual()
{
  Real R = 8.314;
  Real T_Re = 298.15;

  if (_u[_qp] <= 0 || _v[_qp] <= 0)
	  return 0;
  else
       return -_test[_i][_qp] * _Num * _u[_qp] * _v[_qp] * _Reaction_rate[_qp] * exp(_Ea[_qp] / R * (1/T_Re - 1/_T[_qp])) ;
}

Real
ReactionUReactant::computeQpJacobian()
{
  Real R = 8.314;
  Real T_Re = 298.15;
  if (_u[_qp] <= 0 || _v[_qp] <= 0)
	  return 0;
  else
	return -_test[_i][_qp] * _Num * _phi[_j][_qp] * _v[_qp] * _Reaction_rate[_qp] * exp(_Ea[_qp] / R * (1/T_Re - 1/_T[_qp])) ;
}

Real
ReactionUReactant::computeQpOffDiagJacobian(unsigned int jvar)
{
  Real R = 8.314;
  Real T_Re = 298.15;

  if (_u[_qp] <= 0 || _v[_qp] <= 0)
	  return 0;
  else if (jvar == _v_id)
	return -_test[_i][_qp] * _Num * _u[_qp] * _phi[_j][_qp] * _Reaction_rate[_qp] * exp(_Ea[_qp] / R * (1/T_Re - 1/_T[_qp])) ;
     else if (jvar == _T_id)
	return -_test[_i][_qp] * _Num * _u[_qp] * _v[_qp] * _Reaction_rate[_qp] * _Ea[_qp] / (R * _T[_qp] * _T[_qp]) * _phi[_j][_qp] * exp(_Ea[_qp] / R * (1/T_Re - 1/_T[_qp]));
     else 
	return 0.0;
}

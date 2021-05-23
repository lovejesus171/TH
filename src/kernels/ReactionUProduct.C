#include "ReactionUProduct.h"

// MOOSE includes
#include "MooseVariable.h"
#include <algorithm>
#include <limits>

registerMooseObject("corrosionApp", ReactionUProduct);

template <>
InputParameters
validParams<ReactionUProduct>()
{
  InputParameters params = validParams<Kernel>();
  params.addRequiredParam<MaterialPropertyName>("Reaction_rate","Reaction rate coefficient.");
  params.addRequiredParam<Real>("Num", "The stoichiometric coeffient.");
  params.addRequiredParam<MaterialPropertyName>("Activation_energy", "Put the activation energy of the reaction.");
  params.addRequiredCoupledVar("T","Temperature of electrolyte or the system");
  params.addRequiredCoupledVar("v","Reactant concentration");
  params.addRequiredCoupledVar("w","Reactant concentration");
  return params;
}

ReactionUProduct::ReactionUProduct(const InputParameters & parameters)
  : Kernel(parameters),
    _Reaction_rate(getMaterialProperty<Real>("Reaction_rate")),
    _Num(getParam<Real>("Num")),
    _Ea(getMaterialProperty<Real>("Activation_energy")),
    _T(coupledValue("T")),
    _v(coupledValue("v")),
    _w(coupledValue("w")),
    _T_id(coupled("T")),
    _v_id(coupled("v")),
    _w_id(coupled("w"))

{
}

Real
ReactionUProduct::computeQpResidual()
{
  Real R = 8.314;
  Real T_Re = 298.15;

          return -_test[_i][_qp] * _Num * _v[_qp] * _w[_qp] * _Reaction_rate[_qp] * exp(_Ea[_qp] / R * (1/T_Re - 1/_T[_qp])) ;
}

Real
ReactionUProduct::computeQpJacobian()
{
    return 0.0;
}

Real
ReactionUProduct::computeQpOffDiagJacobian(unsigned int jvar)
{
  Real R = 8.314;
  Real T_Re = 298.15;
  
  if (jvar == _v_id)
	return -_test[_i][_qp] * _Num * _phi[_j][_qp] * _w[_qp] * _Reaction_rate[_qp] * exp(_Ea[_qp] / R * (1/T_Re - 1/_T[_qp])) ;
  else if (jvar == _w_id)
	return -_test[_i][_qp] * _Num * _v[_qp] * _phi[_j][_qp] * _Reaction_rate[_qp] * exp(_Ea[_qp] / R * (1/T_Re - 1/_T[_qp])) ;
  else if (jvar == _T_id)
	return -_test[_i][_qp] * _Num * _v[_qp] * _w[_qp] * _Reaction_rate[_qp] * _Ea[_qp] /(R * _T[_qp] * _T[_qp]) * _phi[_j][_qp] * exp(_Ea[_qp] / R * (1/T_Re - 1/_T[_qp]));
  else 
	return 0.0;
}

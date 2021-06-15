#include "ReactionNProduct.h"

// MOOSE includes
#include "MooseVariable.h"
#include <algorithm>
#include <limits>

registerMooseObject("corrosionApp", ReactionNProduct);

template <>
InputParameters
validParams<ReactionNProduct>()
{
  InputParameters params = validParams<Kernel>();
  params.addRequiredParam<MaterialPropertyName>("Reaction_rate","Reaction rate coefficient.");
  params.addRequiredParam<Real>("Num", "The stoichiometric coeffient.");
  params.addRequiredParam<MaterialPropertyName>("Activation_energy", "Put the activation energy of the reaction.");
  params.addRequiredParam<MaterialPropertyName>("Saturation","Put the name of saturation property");
  params.addRequiredCoupledVar("T","Temperature of electrolyte or the system");
  params.addRequiredCoupledVar("v","Product or reactant concentration");
  params.addParam<std::string>(
      "number",
      "",
      "The reaction number. Optional, just for material property naming purposes. If a single "
      "reaction has multiple different rate coefficients (frequently the case when multiple "
      "species are lumped together to simplify a reaction network), this will prevent the same "
      "material property from being declared multiple times.");
  return params;
}

ReactionNProduct::ReactionNProduct(const InputParameters & parameters)
  : Kernel(parameters),
    _Reaction_rate(getMaterialProperty<Real>("Reaction_rate")),
    _Num(getParam<Real>("Num")),
    _Ea(getMaterialProperty<Real>("Activation_energy")),
    _Cs(getMaterialProperty<Real>("Saturation")),
    _T(coupledValue("T")),
    _v(coupledValue("v")),
    _T_id(coupled("T")),
    _v_id(coupled("v"))

{
}

Real
ReactionNProduct::computeQpResidual()
{
  Real R = 8.314;
  Real T_Re = 298.15;
  Real z = 0;

/*  if (_v[_qp] > _Cs[_qp] && _v[_qp] > 0)
          return -_test[_i][_qp] * _Num * _Reaction_rate[_qp] * exp(_Ea[_qp] / R * (1/T_Re - 1/_T[_qp])) * (_v[_qp] - _Cs[_qp]);
  else
	  return 0;
*/

  Real uu = _u[_qp] - _Reaction_rate[_qp] * _v[_qp];

  if (_v[_qp] <=  _Cs[_qp] || _v[_qp] <= 0 || uu <= 0)
  {//printf("Return 0 and _v = %f", _v[_qp]);
//  printf("Saturation_value = %f \n", _Cs[_qp]);
	  return 0;}
  else
  {//printf("Return Non Zero and _v = %f", _v[_qp]);
//  printf("Saturation_value = %f \n", _Cs[_qp]);
          return -_test[_i][_qp] * _Num * _Reaction_rate[_qp] * exp(_Ea[_qp] / R * (1/T_Re - 1/_T[_qp])) * (_v[_qp] - _Cs[_qp]);}

}

Real
ReactionNProduct::computeQpJacobian()
{
	return 0;
}

Real
ReactionNProduct::computeQpOffDiagJacobian(unsigned int jvar)
{
  Real R = 8.314;
  Real T_Re = 298.15;
  Real uu = _u[_qp] - _Reaction_rate[_qp] * _v[_qp];

    if (_v[_qp] <= _Cs[_qp] || _v[_qp] <= 0 || uu <= 0)
	return 0;
    else if (jvar == _v_id)
	return -_test[_i][_qp] * _Num * _Reaction_rate[_qp] * exp(_Ea[_qp]/R * (1/T_Re - 1/_T[_qp])) * _phi[_j][_qp];
    else if (jvar == _T_id)
	return -_test[_i][_qp] * _Num * _Reaction_rate[_qp] * _Ea[_qp]/ (R * _T[_qp] * _T[_qp]) * _phi[_j][_qp] * exp(_Ea[_qp]/R * (1/T_Re - 1/_T[_qp])) * (_v[_qp] - _Cs[_qp]);
    else
	return 0;
}

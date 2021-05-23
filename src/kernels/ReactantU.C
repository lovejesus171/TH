#include "ReactantU.h"

// MOOSE includes
#include "MooseVariable.h"
#include <algorithm>
#include <limits>

registerMooseObject("corrosionApp", ReactantU);

template <>
InputParameters
validParams<ReactantU>()
{
  InputParameters params = validParams<Kernel>();
  params.addRequiredParam<Real>("Reaction_rate","Reaction rate coefficient.");
  params.addRequiredParam<Real>("Num", "The stoichiometric coeffient.");
  params.addRequiredParam<Real>("Activation_energy", "Put the activation energy of the reaction.");
  params.addRequiredParam<MaterialPropertyName>("Saturation","Put the saturated concentration.");
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

ReactantU::ReactantU(const InputParameters & parameters)
  : Kernel(parameters),
    _Reaction_rate(getParam<Real>("Reaction_rate")),
    _Num(getParam<Real>("Num")),
    _Ea(getParam<Real>("Activation_energy")),
    _Cs(getMaterialProperty<Real>("Saturation")),
    _T(coupledValue("T"))
{
}

Real
ReactantU::computeQpResidual()
{
  Real R = 8.314;
  Real T_Re = 298.15;

  if (_u[_qp] <= _Cs[_qp] )
	  return 0;
  else
          return -_test[_i][_qp] * _Num * _Reaction_rate * exp(_Ea / R * (1/T_Re - 1/_T[_qp])) * (_u[_qp] - _Cs[_qp]);
}

Real
ReactantU::computeQpJacobian()
{
  Real R = 8.314;
  Real T_Re = 298.15;
  Real k;

  k = _Num * _Reaction_rate * exp(_Ea / R * (1/T_Re - 1/_T[_qp])) * (_u[_qp] - _Cs[_qp]);

    if (_u[_qp] <= _Cs[_qp])
	return 0;
    else
	return -_test[_i][_qp] * _Num * _Reaction_rate * exp(_Ea / R * (1/T_Re - 1/_T[_qp])) * _phi[_j][_qp];

}

Real
ReactantU::computeQpOffDiagJacobian(unsigned int jvar)
{
  Real R = 8.314;
  Real T_Re = 298.15;
    if (_u[_qp] <= _Cs[_qp])
	    return 0;
    else if (jvar == _T_id)
	return -_test[_i][_qp] * _Num * _Reaction_rate * _Ea / (R * _T[_qp] * _T[_qp]) * _phi[_j][_qp] * exp(_Ea / R * (1/T_Re - 1/_T[_qp])) * (_u[_qp] - _Cs[_qp]);
    else
	    return 0;
}

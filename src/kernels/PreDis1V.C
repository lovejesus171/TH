#include "PreDis1V.h"

// MOOSE includes
#include "MooseVariable.h"
#include <algorithm>
#include <limits>

registerMooseObject("corrosionApp", PreDis1V);

template <>
InputParameters
validParams<PreDis1V>()
{
  InputParameters params = validParams<Kernel>();
  params.addRequiredParam<Real>("Reaction_rate","Reaction rate coefficient.");
  params.addRequiredParam<Real>("Num", "The stoichiometric coeffient.");
  params.addRequiredParam<Real>("Activation_energy", "Put the activation energy of the reaction.");
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

PreDis1V::PreDis1V(const InputParameters & parameters)
  : Kernel(parameters),
    _Reaction_rate(getParam<Real>("Reaction_rate")),
    _Num(getParam<Real>("Num")),
    _Ea(getParam<Real>("Activation_energy")),
    _Cs(getMaterialProperty<Real>("Saturation")),
    _T(coupledValue("T")),
    _v(coupledValue("v")),
    _T_id(coupled("T")),
    _v_id(coupled("v"))

{
}

Real
PreDis1V::computeQpResidual()
{
  Real R = 8.314;
  Real T_Re = 298.15;
  Real k;

  k = _Num * _Reaction_rate * exp(_Ea / R * (1/T_Re - 1/_T[_qp])) * (_v[_qp] - _Cs[_qp]);

  if (k <= 0 )
	  return 0;
  else
          return -_test[_i][_qp] * _Num * _Reaction_rate * exp(_Ea / R * (1/T_Re - 1/_T[_qp])) * (_v[_qp] - _Cs[_qp]);
}

Real
PreDis1V::computeQpJacobian()
{
	return 0;
}

Real
PreDis1V::computeQpOffDiagJacobian(unsigned int jvar)
{
  Real R = 8.314;
  Real T_Re = 298.15;
  Real k;

  k = _Num * _Reaction_rate * exp(_Ea / R * (1/T_Re - 1/_T[_qp])) * (_v[_qp] - _Cs[_qp]);

    if (k <= 0)
	return 0;
    else if (jvar == _v_id)
	return -_test[_i][_qp] * _Num * _Reaction_rate * exp(_Ea/R * (1/T_Re - 1/_T[_qp])) * _phi[_j][_qp];
    else
	return -_test[_i][_qp] * _Num * _Reaction_rate * _Ea/R * 1 / (_phi[_j][_qp] * _T[_qp]) * exp(_Ea/R * (1/T_Re - 1/_T[_qp])) * (_v[_qp] - _Cs[_qp]);

}

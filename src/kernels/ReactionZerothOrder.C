#include "ReactionZerothOrder.h"

// MOOSE includes
#include "MooseVariable.h"

registerMooseObject("corrosionApp", ReactionZerothOrder);

template <>
InputParameters
validParams<ReactionZerothOrder>()
{
  InputParameters params = validParams<Kernel>();
  params.addRequiredParam<Real>("Reaction_rate","Reaction rate coefficient.");
  params.addRequiredParam<Real>("Num", "The stoichiometric coeffient.");
  params.addRequiredParam<Real>("Activation_energy", "Put the activation energy of the reaction.");
  params.addParam<Real>("Saturation",1, "Put the saturated concentration.");
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

ReactionZerothOrder::ReactionZerothOrder(const InputParameters & parameters)
  : Kernel(parameters),
    _Reaction_rate(getParam<Real>("Reaction_rate")),
    _Num(getParam<Real>("Num")),
    _Ea(getParam<Real>("Activation_energy")),
    _Cs(getParam<Real>("Saturation")),
    _T(coupledValue("T"))

{
}

Real
ReactionZerothOrder::computeQpResidual()
{
  Real R = 8.314;
  Real T_Re = 298.15;
  Real z = 0;
  z = _u[_qp] + _Num * _Reaction_rate * exp(_Ea/R * (1/T_Re - 1/_T[_qp]));

  if (z <= 0)
	  return -_test[_i][_qp] * _u[_qp];
  else
          return -_test[_i][_qp] * _Num * _Reaction_rate * exp(_Ea / R * (1/T_Re - 1/_T[_qp]));
}

Real
ReactionZerothOrder::computeQpJacobian()
{
  Real R = 8.314;
  Real T_Re = 298.15;
  Real z = 0;
  z = _u[_qp] + _Num * _Reaction_rate * exp(_Ea/R * (1/T_Re - 1/_T[_qp]));

  if (z <= 0)
     	return -_test[_i][_qp] * _phi[_j][_qp];
  else
        return 0.0;
}

Real
ReactionZerothOrder::computeQpOffDiagJacobian(unsigned int jvar)
{
  Real R = 8.314;
  Real T_Re = 298.15;
  Real z = 0;
  z = _u[_qp] + _Num * _Reaction_rate * exp(_Ea/R * (1/T_Re - 1/_T[_qp]));
  if (z <= 0)
	  return 0.0;
  else
          return -_test[_i][_qp] * _Num * _Reaction_rate * _Ea / (R * _T[_qp] * _T[_qp]) * _phi[_j][_qp] * exp(_Ea / R * (1/T_Re - 1/_T[_qp]));

}

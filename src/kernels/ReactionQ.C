#include "ReactionQ.h"

// MOOSE includes
#include "MooseVariable.h"

registerMooseObject("corrosionApp", ReactionQ);

template <>
InputParameters
validParams<ReactionQ>()
{
  InputParameters params = validParams<Kernel>();
  params.addRequiredParam<MaterialPropertyName>("Reaction_rate","Reaction rate coefficient.");
  params.addRequiredParam<Real>("Num", "The stoichiometric coeffient.");
  params.addRequiredParam<MaterialPropertyName>("Activation_energy", "Put the activation energy of the reaction.");
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

ReactionQ::ReactionQ(const InputParameters & parameters)
  : Kernel(parameters),
    _Reaction_rate(getMaterialProperty<Real>("Reaction_rate")),
    _Num(getParam<Real>("Num")),
    _Ea(getMaterialProperty<Real>("Activation_energy")),
    _T(coupledValue("T"))

{
}

Real
ReactionQ::computeQpResidual()
{
  Real R = 8.314;
  Real T_Re = 298.15;


          return -_test[_i][_qp] * _Num * _Reaction_rate[_qp] * exp(_Ea[_qp] / R * (1/T_Re - 1/_T[_qp]));
}

Real
ReactionQ::computeQpJacobian()
{
  Real R = 8.314;
  Real T_Re = 298.15;

        return 0.0;
}

Real
ReactionQ::computeQpOffDiagJacobian(unsigned int jvar)
{
  Real R = 8.314;
  Real T_Re = 298.15;

        return -_test[_i][_qp] * _Num * _Reaction_rate[_qp] * _Ea[_qp] / (R * _T[_qp] * _T[_qp]) * _phi[_j][_qp] * exp(_Ea[_qp] / R * (1/T_Re - 1/_T[_qp]));

}

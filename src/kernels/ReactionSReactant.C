#include "ReactionSReactant.h"

// MOOSE includes
#include "MooseVariable.h"

registerMooseObject("corrosionApp", ReactionSReactant);

template <>
InputParameters
validParams<ReactionSReactant>()
{
  InputParameters params = validParams<Kernel>();
  params.addRequiredParam<MaterialPropertyName>("Reaction_rate","Reaction rate coefficient.");
  params.addRequiredParam<Real>("Num", "The stoichiometric coeffient.");
  params.addRequiredParam<MaterialPropertyName>("Activation_energy", "Put the activation energy of the reaction.");
  params.addRequiredCoupledVar("T","Temperature of electrolyte or the system");
  params.addRequiredParam<PostprocessorName>("pp","The postprocessor to use as the value");
  params.addParam<std::string>(
      "number",
      "",
      "The reaction number. Optional, just for material property naming purposes. If a single "
      "reaction has multiple different rate coefficients (frequently the case when multiple "
      "species are lumped together to simplify a reaction network), this will prevent the same "
      "material property from being declared multiple times.");
  return params;
}

ReactionSReactant::ReactionSReactant(const InputParameters & parameters)
  : Kernel(parameters),
    _Reaction_rate(getMaterialProperty<Real>("Reaction_rate")),
    _Num(getParam<Real>("Num")),
    _Ea(getMaterialProperty<Real>("Activation_energy")),
    _T(coupledValue("T")),
    _pp_value(getPostprocessorValue("pp"))

{
}

Real
ReactionSReactant::computeQpResidual()
{
  Real R = 8.314;
  Real T_Re = 298.15;

   if (_pp_value > 0 && _u[_qp] > 0)
          return -_test[_i][_qp] * _Num * _Reaction_rate[_qp] * exp(_Ea[_qp] / R * (1/T_Re - 1/_T[_qp]));
   else
	   return 0;
}

Real
ReactionSReactant::computeQpJacobian()
{
  Real R = 8.314;
  Real T_Re = 298.15;

        return 0.0;
}

Real
ReactionSReactant::computeQpOffDiagJacobian(unsigned int jvar)
{
  Real R = 8.314;
  Real T_Re = 298.15;

  if (_pp_value > 0 && _u[_qp] > 0)
        return -_test[_i][_qp] * _Num * _Reaction_rate[_qp] * _Ea[_qp] / (R * _T[_qp] * _T[_qp]) * _phi[_j][_qp] * exp(_Ea[_qp] / R * (1/T_Re - 1/_T[_qp]));

  else
	  return 0;
}

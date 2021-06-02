#include "RT2.h"

// MOOSE includes
#include "MooseVariable.h"
#include <algorithm>
#include <limits>

registerMooseObject("corrosionApp", RT2);

template <>
InputParameters
validParams<RT2>()
{
  InputParameters params = validParams<Kernel>();
  params.addRequiredParam<Real>("Num", "The stoichiometric coeffient.");
  params.addRequiredParam<Real>("k", "The stoichiometric coeffient.");
  params.addRequiredParam<MaterialPropertyName>("UO2precip", "The stoichiometric coeffient.");

  params.addParam<std::string>(
      "number",
      "",
      "The reaction number. Optional, just for material property naming purposes. If a single "
      "reaction has multiple different rate coefficients (frequently the case when multiple "
      "species are lumped together to simplify a reaction network), this will prevent the same "
      "material property from being declared multiple times.");
  return params;
}

RT2::RT2(const InputParameters & parameters)
  : Kernel(parameters),
    _Num(getParam<Real>("Num")),
    _UO2precip(getMaterialProperty<Real>("UO2precip")),
    _k(getParam<Real>("k"))
{
}

Real
RT2::computeQpResidual()
{
	if (_UO2precip[_qp] > 0)
	  return -_test[_i][_qp] * _Num * _k;
	else
		return 0;
}

Real
RT2::computeQpJacobian()
{

	return 0;

}

Real
RT2::computeQpOffDiagJacobian(unsigned int jvar)
{
		return 0;
}

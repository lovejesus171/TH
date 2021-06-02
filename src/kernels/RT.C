#include "RT.h"

// MOOSE includes
#include "MooseVariable.h"
#include <algorithm>
#include <limits>

registerMooseObject("corrosionApp", RT);

template <>
InputParameters
validParams<RT>()
{
  InputParameters params = validParams<Kernel>();
  params.addRequiredParam<Real>("Num", "The stoichiometric coeffient.");
  params.addRequiredParam<Real>("k", "The stoichiometric coeffient.");
  params.addRequiredParam<Real>("Sat", "The stoichiometric coeffient.");
  params.addParam<std::string>(
      "number",
      "",
      "The reaction number. Optional, just for material property naming purposes. If a single "
      "reaction has multiple different rate coefficients (frequently the case when multiple "
      "species are lumped together to simplify a reaction network), this will prevent the same "
      "material property from being declared multiple times.");
  return params;
}

RT::RT(const InputParameters & parameters)
  : Kernel(parameters),
    _Num(getParam<Real>("Num")),
    _Sat(getParam<Real>("Sat")),
    _k(getParam<Real>("k"))
{
}

Real
RT::computeQpResidual()
{
  if (_u[_qp] <= _Sat)
	  {
		  return 0;
	  }
  else
  {
	  return -_test[_i][_qp] * _Num * _k * (_u[_qp] - _Sat);
  }
}

Real
RT::computeQpJacobian()
{

    if (_u[_qp] <= _Sat)
	return 0;
    else
	return -_test[_i][_qp]  * _Num * _k * _phi[_j][_qp];

}

Real
RT::computeQpOffDiagJacobian(unsigned int jvar)
{
	    return 0;
}

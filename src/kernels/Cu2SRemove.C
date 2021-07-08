#include "Cu2SRemove.h"

// MOOSE includes
#include "MooseVariable.h"
#include <algorithm>
#include <limits>

registerMooseObject("corrosionApp", Cu2SRemove);

template <>
InputParameters
validParams<Cu2SRemove>()
{
  InputParameters params = validParams<Kernel>();
  params.addRequiredParam<Real>("Kinetic", "Put the kinetic constant of precipitation");
  params.addRequiredParam<MaterialPropertyName>("Saturation","Put the name of saturation property");
  return params;
}

Cu2SRemove::Cu2SRemove(const InputParameters & parameters)
  : Kernel(parameters),
    _Reaction_rate(getParam<Real>("Kinetic")),
    _Cs(getMaterialProperty<Real>("Saturation"))
{
}

Real
Cu2SRemove::computeQpResidual()
{
  Real R = 8.314;
  Real T_Re = 298.15;

  if (_u[_qp] <= 0)
          return 0;
  else if (_u[_qp] < _Cs[_qp])
          return _test[_i][_qp] * _Reaction_rate * _u[_qp];
  else if (_u[_qp] >= _Cs[_qp])
          return _test[_i][_qp] * _Cs[_qp];
  else
          return 0;

}

Real
Cu2SRemove::computeQpJacobian()
{
  if (_u[_qp] <= 0)
          return 0;
  else if (_u[_qp] < _Cs[_qp])
          return _test[_i][_qp] * _Reaction_rate * _phi[_j][_qp];
  else if (_u[_qp] >= _Cs[_qp])
          return 0;
  else
          return 0;

}

Real
Cu2SRemove::computeQpOffDiagJacobian(unsigned int jvar)
{
	return 0;
}

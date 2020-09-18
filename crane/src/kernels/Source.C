#include "Source.h"
#include "MooseVariable.h"

registerMooseObject("CraneApp",Source);

template<>
InputParameters
validParams<Source>()
{
  InputParameters params = validParams<Kernel>();
  params.addClassDescription("Compute the source term of chemical reactions.");
  params.addRequiredParam<Real>("Source","Source term input as mol/m^3 unit");
  return params;
}

Source::Source(const InputParameters & parameters)
  : Kernel(parameters),
    _S(getParam<Real>("Source"))
{
}

Real
Source::computeQpResidual()
{
  return -_test[_i][_qp] * _S;
}

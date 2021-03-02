#include "SatCal.h"

registerMooseObject("corrosionApp", SatCal);

InputParameters
SatCal::validParams()
{
  InputParameters params = ADKernel::validParams();
  params.addClassDescription("This kernel solve dryout terms and should be coupled with an amount of water ");
  params.addRequiredCoupledVar("T", "The temperature variable");
  params.addRequiredCoupledVar("P", "The pressure variable");
  return params;
}

SatCal::SatCal(const InputParameters & parameters)
  : ADKernel(parameters),
    _P(adCoupledValue("P")),
    _T(adCoupledValue("T")),
    _g(9.81),
    _h(500),
    _rho_w(1000)
{
}

ADReal
SatCal::computeQpResidual()
{
	return _test[_i][_qp] * (_P[_qp]/ _g / _h - (8E-4 * pow(_T[_qp] - 273.15, 3) + 3.41E-2 * pow(_T[_qp] - 273.15, 2) - 1.3471 * (_T[_qp] - 273.15) + 0.0799 ) / 1000) / _rho_w;
}


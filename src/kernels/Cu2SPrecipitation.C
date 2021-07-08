#include "Cu2SPrecipitation.h"

// MOOSE includes
#include "MooseVariable.h"
#include <algorithm>
#include <limits>

registerMooseObject("corrosionApp", Cu2SPrecipitation);

template <>
InputParameters
validParams<Cu2SPrecipitation>()
{
  InputParameters params = validParams<Kernel>();
  params.addRequiredParam<Real>("Kinetic", "Put the kinetic constant of precipitation");
  params.addRequiredParam<MaterialPropertyName>("Saturation","Put the name of saturation property");
  params.addRequiredCoupledVar("v","Product or reactant concentration");
  return params;
}

Cu2SPrecipitation::Cu2SPrecipitation(const InputParameters & parameters)
  : Kernel(parameters),
    _Reaction_rate(getParam<Real>("Kinetic")),
    _Cs(getMaterialProperty<Real>("Saturation")),
    _v(coupledValue("v")),
    _v_id(coupled("v"))

{
}

Real
Cu2SPrecipitation::computeQpResidual()
{
  Real R = 8.314;
  Real T_Re = 298.15;

  if (_v[_qp] <= 0)  //No Cu2S
          return 0;
  else if (_v[_qp] < _Cs[_qp]) //Yes Cu2S, Start to precipitate in some locations
  {
	  if (_u[_qp] > 0 && _v[_qp] + _u[_qp] <= _Cs[_qp]) // Summation of precipiated Cu2S and newly arrived Cu2S < Maximum precipitated Cu2S
            return -_test[_i][_qp] * _Reaction_rate * _v[_qp];
	  else if (_u[_qp] > 0 && _v[_qp] + _u[_qp] > _Cs[_qp]) // Summation of total Cu2S is larger than maximum precipitated Cu2S
            return -_test[_i][_qp]  ; //Fix it
	  else
	    return -_test[_i][_qp] * _Reaction_rate * _v[_qp]; // Fix it
  }
  else 
          return 0;
}

Real
Cu2SPrecipitation::computeQpJacobian()
{
	return 0;
}

Real
Cu2SPrecipitation::computeQpOffDiagJacobian(unsigned int jvar)
{
  Real R = 8.314;
  Real T_Re = 298.15;
    if (_v[_qp] <= 0)
	    return 0;
    else if (_v[_qp] < _Cs[_qp] && jvar == _v_id)
	    return -_test[_i][_qp] * _Reaction_rate * _phi[_j][_qp];
    else
            return 0;
}

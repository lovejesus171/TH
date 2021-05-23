#include "PreDis2ReactU.h"

// MOOSE includes
#include "MooseVariable.h"
#include <algorithm>
#include <limits>

registerMooseObject("corrosionApp", PreDis2ReactU);

template <>
InputParameters
validParams<PreDis2ReactU>()
{
  InputParameters params = validParams<Kernel>();
  params.addRequiredParam<Real>("Reaction_rate","Reaction rate coefficient.");
  params.addRequiredParam<Real>("Num", "The stoichiometric coeffient.");
  params.addRequiredParam<Real>("Activation_energy", "Put the activation energy of the reaction.");
  params.addRequiredCoupledVar("T","Temperature of electrolyte or the system");
  params.addRequiredCoupledVar("v","Reactant concentration");
  params.addRequiredParam<MaterialPropertyName>("Saturation","Saturation of UO22+ or UO2CO332-");
  return params;
}

PreDis2ReactU::PreDis2ReactU(const InputParameters & parameters)
  : Kernel(parameters),
    _Reaction_rate(getParam<Real>("Reaction_rate")),
    _Num(getParam<Real>("Num")),
    _Ea(getParam<Real>("Activation_energy")),
    _T(coupledValue("T")),
    _v(coupledValue("v")),
    _T_id(coupled("T")),
    _v_id(coupled("v")),
    _Cs(getMaterialProperty<Real>("Saturation"))
{
}

Real
PreDis2ReactU::computeQpResidual()
{
  Real R = 8.314;
  Real T_Re = 298.15;
     if(_v[_qp] <= _Cs[_qp])
       return 0;
     else
       return -_test[_i][_qp] * _Num * (_u[_qp] - _Cs[_qp]) * _v[_qp] * _Reaction_rate * exp(_Ea / R * (1/T_Re - 1/_T[_qp])) ;
}

Real
PreDis2ReactU::computeQpJacobian()
{
  Real R = 8.314;
  Real T_Re = 298.15;
     if(_v[_qp] <= _Cs[_qp])
        return 0;
     else
	return -_test[_i][_qp] * _Num * _phi[_j][_qp] * _v[_qp] * _Reaction_rate * exp(_Ea / R * (1/T_Re - 1/_T[_qp])) ;
}

Real
PreDis2ReactU::computeQpOffDiagJacobian(unsigned int jvar)
{
  Real R = 8.314;
  Real T_Re = 298.15;

     if(_v[_qp] <= _Cs[_qp])
	     return 0;
     else if (jvar == _v_id)
	return -_test[_i][_qp] * _Num * (_u[_qp] - _Cs[_qp]) * _phi[_j][_qp] * _Reaction_rate * exp(_Ea / R * (1/T_Re - 1/_T[_qp])) ;
     else if (jvar == _T_id)
	return -_test[_i][_qp] * _Num * (_u[_qp] - _Cs[_qp]) * (_v[_qp] - _Cs[_qp]) * _Reaction_rate * _Ea / (R * _T[_qp] * _T[_qp]) * _phi[_j][_qp] * exp(_Ea / R * (1/T_Re - 1/_T[_qp]));
     else 
	return 0.0;
}

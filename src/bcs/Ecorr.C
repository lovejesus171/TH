//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "Ecorr.h"

registerMooseObject("corrosionApp", Ecorr);

defineLegacyParams(Ecorr);

InputParameters
Ecorr::validParams()
{
  InputParameters params = IntegratedBC::validParams();
  params.addRequiredCoupledVar("Reactant", "The variable whose value we are to match.");
  params.addParam<Real>("Reaction_order","Reaction order parameters");
  params.addParam<Real>("AlphaE","Transfer coefficient, unitless");
  params.addParam<Real>("AlphaS","Transfer coefficient, unitless");
  params.addParam<Real>("AlphaS12","Transfer coefficient, unitless");
  params.addParam<Real>("AlphaS3","Transfer coefficient, unitless");
  params.addParam<Real>("PotentialE","Standard potential of reaction, V");
  params.addParam<Real>("PotentialS12","Standard potential of reaction, V");
  params.addParam<Real>("PotentialE3","Standard potential of reaction, V");
  params.addParam<Real>("CoefE","Number of electron participate in reaction");
  params.addParam<Real>("CoefS","Number of electron participate in reaction");
  params.addParam<Real>("Kinetic_coefE","Kinetic constant"); 
  params.addParam<Real>("Kinetic_coefS","Kinetic constant"); 


  params.addClassDescription("Implements a NodalBC which equates two different Variables' values "
                             "on a specified boundary.");
  return params;
}

Ecorr::Ecorr(const InputParameters & parameters)
  : IntegratedBC(parameters),
    _C(coupledValue("Reactant")),
    _m(getParam<Real>("Reaction_order")),
    _aE(getParam<Real>("AlphaE")),
    _aS(getParam<Real>("AlphaS")),
    _aS12(getParam<Real>("AlphaS12")),
    _aS3(getParam<Real>("AlphaS3")),
    _EE(getParam<Real>("PotentialE")),
    _ES12(getParam<Real>("PotentialS12")),
    _E3(getParam<Real>("PotentialE3")),
    _nE(getParam<Real>("CoefE")),
    _nS(getParam<Real>("CoefS")),
    _kE(getParam<Real>("Kinetic_coefE")),
    _kS(getParam<Real>("Kinetic_coefS"))
{
}

Real
Ecorr::computeQpResidual()
{
  return  -_test[_i][_qp] * 1/(1 + _aE + _aS)* (_aE * _EE + _ES12 + _aS3 * _E3 - 8.314 * 298.15 / 96485 * log10(_nS * _kS / (_nE * _kE * 1000)/_C[_qp])) ;
}

Real
Ecorr::computeQpJacobian()
{
  return  0.0;
}

Real
Ecorr::computeQpOffDiagJacobian(unsigned int jvar)
{
  return 0.0;
//  return  -_test[_i][_qp] * 1/(1 + _aE + _aS)* (_aE * _EE + _ES12 + _aS3 * _E3 - 8.314 * 298.15 / 96485 * log10(_nS * _kS / (_nE * _kE)) / (_C[_qp] * _C[_qp])) ;
}

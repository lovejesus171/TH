//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "CorrosionPotential.h"

registerMooseObject("corrosionApp", CorrosionPotential);

template <>
InputParameters
validParams<CorrosionPotential>()
{
  InputParameters params = validParams<AuxKernel>();
  params.addCoupledVar("C1",0,"The variable whose value we are to match.");
  params.addCoupledVar("C0",0,"The variable whose value we are to match.");
  params.addCoupledVar("C3",0, "The variable whose value we are to match.");
  params.addCoupledVar("C9",0,"The variable whose value we are to match.");
  params.addCoupledVar("C6",0, "The variable whose value we are to match.");
  params.addCoupledVar("T",298.15, "Temperature of the system");


  params.addParam<Real>("aS",0.5,"Transfer coefficient");
  params.addParam<Real>("aC",0.37,"Transfer coefficient");
  params.addParam<Real>("aD",0.5,"Transfer coefficient");
  params.addParam<Real>("aE",0.5,"Transfer coefficient");
  params.addParam<Real>("aF",0.15,"Transfer coefficient");
  params.addParam<Real>("aS3",0.5,"Transfer coefficient");

 
  params.addParam<Real>("EA",-0.105,"Standard potential");
  params.addParam<Real>("ES12",-0.747,"Standard potential");
  params.addParam<Real>("ES3",-0.747,"Standard potential");
  params.addParam<Real>("EC",0.16,"Standard potential");
  params.addParam<Real>("ED",0.223,"Standard potential");
  params.addParam<Real>("EE",-1.005,"Standard potential");
  params.addParam<Real>("EF",-0.764,"Standard potential");
  
  params.addParam<Real>("nA",1,"Number of charge which is participate in reactions");
  params.addParam<Real>("nD",1,"Number of charge which is participate in reactions");
  params.addParam<Real>("nE",1,"Number of charge which is participate in reactions");
  params.addParam<Real>("nF",1,"Number of charge which is participate in reactions");
  params.addParam<Real>("nO",4,"Number of charge which is participate in reactions");
  params.addParam<Real>("nS",1,"Number of charge which is participate in reactions");

  params.addParam<Real>("kA",1.1880E-4,"Number of charge which is participate in reactions");
  params.addParam<Real>("kC",6.12E-7,"Number of charge which is participate in reactions");
  params.addParam<Real>("kD",7.2E-6,"Number of charge which is participate in reactions");
  params.addParam<Real>("kE",7.2E-6,"Number of charge which is participate in reactions");
  params.addParam<Real>("kS",2.16E2,"Number of charge which is participate in reactions");
  params.addParam<Real>("kF",2.4444E-3,"Number of charge which is participate in reactions");
  params.addParam<Real>("kBB",2.4444E-3,"Number of charge which is participate in reactions");


  return params;
}

CorrosionPotential::CorrosionPotential(const InputParameters & parameters)
  : AuxKernel(parameters),
    _C1(coupledValue("C1")),
    _C0(coupledValue("C0")),
    _C3(coupledValue("C3")),
    _C9(coupledValue("C9")),
    _C6(coupledValue("C6")),
    _T(coupledValue("T")),

    _aS(getParam<Real>("aS")),
    _aC(getParam<Real>("aC")),
    _aD(getParam<Real>("aD")),
    _aE(getParam<Real>("aE")),
    _aF(getParam<Real>("aF")),
    _aS3(getParam<Real>("aS3")),

    _EA(getParam<Real>("EA")),
    _ES12(getParam<Real>("ES12")),
    _ES3(getParam<Real>("ES3")),
    _EC(getParam<Real>("EC")),
    _ED(getParam<Real>("ED")),
    _EE(getParam<Real>("EE")),
    _EF(getParam<Real>("EF")),

    _nA(getParam<Real>("nA")),
    _nD(getParam<Real>("nD")),
    _nE(getParam<Real>("nE")),
    _nF(getParam<Real>("nF")),
    _nO(getParam<Real>("nO")),
    _nS(getParam<Real>("nS")),

    _kA(getParam<Real>("kA")),
    _kC(getParam<Real>("kC")),
    _kD(getParam<Real>("kD")),
    _kE(getParam<Real>("kE")),
    _kS(getParam<Real>("kS")),
    _kF(getParam<Real>("kF")),
    _kBB(getParam<Real>("kBB"))
{
}

/**
 * Auxiliary Kernels override computeValue() instead of computeQpResidual().  Aux Variables
 * are calculated either one per elemenet or one per node depending on whether we declare
 * them as "Elemental (Constant Monomial)" or "Nodal (First Lagrange)".  No changes to the
 * source are necessary to switch from one type or the other.
 */
Real
CorrosionPotential::computeValue()
{
  Real Alpha = 2 + _aS - _aC - _aD - _aE - _aF;
  Real n = _nO + _nD + _nE + _nF / (_nA * _nS);
  return  (_EA + _ES12 + _aS3 * _ES3 - _aC * _EC - _aD * _ED - _aE * _EE - _aF * _EF) / Alpha + 8.314 * 298.15 / 96485 / Alpha * log(n * _kBB* _C1[_qp] / (_kA * _C6[_qp] * _C6[_qp]) * _kC * _C0[_qp] /_kS/(_C9[_qp] * _C9[_qp]) * _kD * _C3[_qp] * _kE * _C9[_qp] / _kF ) ;
}

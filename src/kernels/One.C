//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "One.h"

registerMooseObject("corrosionApp", One);

template <>
InputParameters
validParams<One>()
{
  InputParameters params = validParams<ADKernel>();
  params.addCoupledVar("C1",0,"CuCl2-");
  params.addCoupledVar("C0",0,"O2(aq)");
  params.addCoupledVar("C3",0, "Cu2+");
  params.addCoupledVar("C9",0,"HS-");
  params.addCoupledVar("C6",0, "Cl-");
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

  params.addParam<Real>("Porosity",0,"porosity of film");
  params.addParam<Real>("Area",0,"Fractional surface area for the cathodic reactions");


  return params;
}

One::One(const InputParameters & parameters)
  : ADKernel(parameters),
    _C1(adCoupledValue("C1")),
    _C0(adCoupledValue("C0")),
    _C3(adCoupledValue("C3")),
    _C9(adCoupledValue("C9")),
    _C6(adCoupledValue("C6")),
    _T(adCoupledValue("T")),

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
    _kBB(getParam<Real>("kBB")),

    _Porosity(getParam<Real>("Porosity")),
    _Area(getParam<Real>("Area"))
{
}



ADReal
One::computeQpResidual()
{
  Real Alpha = 1 + _aS + _aF;
  Real E =  _ES12 + _aS3 * _ES3 + _aF * _EF;
  
  return _test[_i][_qp] * _u[_qp] - _test[_i][_qp] * (E / Alpha + 1 / Alpha * 8.314 * _T[_qp] / 96485 * log((1 - _Porosity) * _kF /(_Porosity * _kS * _C9[_qp] * _C9[_qp])));
}

//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "IE.h"

registerMooseObject("corrosionApp", IE);

template <>
InputParameters
validParams<IE>()
{
  InputParameters params = validParams<AuxKernel>();
  params.addCoupledVar("C0",0,"O2");
  params.addCoupledVar("C3",0,"Cu2+ ion");
  params.addCoupledVar("C9",0,"HS- ion");
  params.addCoupledVar("T","Temperature");
  params.addCoupledVar("Ecorr","Corroion potential");

  params.addParam<Real>("Porosity",1,"Porosity of film");

  params.addParam<Real>("nO",4,"Number of electron");
  params.addParam<Real>("kC",6.12E-7,"Cu to CuCl2- oxidation rate");
  params.addParam<Real>("aC",0.37,"CuCl2- to Cu reduction rate");
  params.addParam<Real>("EC",0.16,"Standard potential");

  params.addParam<Real>("nD",1,"Number of electron");
  params.addParam<Real>("kD",7.2E-6,"Cu to CuCl2- oxidation rate");
  params.addParam<Real>("aD",0.5,"CuCl2- to Cu reduction rate");
  params.addParam<Real>("ED",0.223,"Standard potential");


  params.addParam<Real>("nE",1,"Number of electron");
  params.addParam<Real>("kE",7.2E-6,"Cu to CuCl2- oxidation rate");
  params.addParam<Real>("aE",0.5,"CuCl2- to Cu reduction rate");
  params.addParam<Real>("EE",-1.005,"Standard potential");
  
  params.addParam<Real>("nF",1,"Number of electron");
  params.addParam<Real>("kF",2.44E-3,"Cu to CuCl2- oxidation rate");
  params.addParam<Real>("aF",0.15,"CuCl2- to Cu reduction rate");
  params.addParam<Real>("EF",-0.764,"Standard potential");
 

  return params;
}

IE::IE(const InputParameters & parameters)
  : AuxKernel(parameters),
    _C0(coupledValue("C0")),
    _C3(coupledValue("C3")),
    _C9(coupledValue("C9")),
    _T(coupledValue("T")),
    _Ecorr(coupledValue("Ecorr")),

    _Porosity(getParam<Real>("Porosity")),

    _nO(getParam<Real>("nO")),
    _kC(getParam<Real>("kC")),
    _aC(getParam<Real>("aC")),
    _EC(getParam<Real>("EC")),

    _nD(getParam<Real>("nD")),
    _kD(getParam<Real>("kD")),
    _aD(getParam<Real>("aD")),
    _ED(getParam<Real>("ED")),

    _nE(getParam<Real>("nE")),
    _kE(getParam<Real>("kE")),
    _aE(getParam<Real>("aE")),
    _EE(getParam<Real>("EE")),

    _nF(getParam<Real>("nF")),
    _kF(getParam<Real>("kF")),
    _aF(getParam<Real>("aF")),
    _EF(getParam<Real>("EF"))
{
}

/**
 * Auxiliary Kernels override computeValue() instead of computeQpResidual().  Aux Variables
 * are calculated either one per elemenet or one per node depending on whether we declare
 * them as "Elemental (Constant Monomial)" or "Nodal (First Lagrange)".  No changes to the
 * source are necessary to switch from one type or the other.
 */
Real
IE::computeValue()
{
  Real F = 96485;
  Real R = 8.314;

  return + _nE * (1 - _Porosity) * F * _kE * _C9[_qp] * exp(-_aE * F / (R * _T[_qp]) * (_Ecorr[_qp] - _EE))
	  ;
    // Oxygen reduction 
    //_nO * (1 - _Porosity) * F * _kC * _C0[_qp] * exp(-_aC * F / (R * _T[_qp]) * (_Ecorr[_qp] - _EC))

}

//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "ISS.h"

registerMooseObject("corrosionApp", ISS);

template <>
InputParameters
validParams<ISS>()
{
  InputParameters params = validParams<AuxKernel>();
  params.addCoupledVar("C6",0,"Cl- ion");
  params.addCoupledVar("C9",0,"HS- ion");
  params.addCoupledVar("C1",0,"CuCl2- ion");
  params.addCoupledVar("T","Temperature");
  params.addRequiredParam<MaterialPropertyName>("Ecorr","Corroion potential");

  params.addParam<Real>("Porosity",1,"Porosity of film");

  params.addParam<Real>("nA",1,"Number of electron");
  params.addParam<Real>("kA",1.188E-4,"Cu to CuCl2- oxidation rate");
  params.addParam<Real>("kB",2.44E-3,"CuCl2- to Cu reduction rate");
  params.addParam<Real>("EA",-0.105,"Standard potential");

  params.addParam<Real>("nS",1,"Number of electron");
  params.addParam<Real>("kS",2.16E2,"Cu to Cu2S oxidation rate");
  params.addParam<Real>("aS",0.5,"Transfer coefficient");
  params.addParam<Real>("aS3",0.5,"Transfer coefficient");
  params.addParam<Real>("ES12",-0.747,"Standard potential");
  params.addParam<Real>("ES3",-0.747,"Standard potential");




  return params;
}

ISS::ISS(const InputParameters & parameters)
  : AuxKernel(parameters),
    _C6(coupledValue("C6")),
    _C9(coupledValue("C9")),
    _C1(coupledValue("C1")),
    _T(coupledValue("T")),
    _Ecorr(getADMaterialProperty<Real>("Ecorr")),

    _Porosity(getParam<Real>("Porosity")),

    _nA(getParam<Real>("nA")),
    _kA(getParam<Real>("kA")),
    _kB(getParam<Real>("kB")),
    _EA(getParam<Real>("EA")),

    _nS(getParam<Real>("nS")),
    _kS(getParam<Real>("kS")),
    _aS(getParam<Real>("aS")),
    _aS3(getParam<Real>("aS3")),
    _ES12(getParam<Real>("ES12")),
    _ES3(getParam<Real>("ES3"))
{
}

/**
 * Auxiliary Kernels override computeValue() instead of computeQpResidual().  Aux Variables
 * are calculated either one per elemenet or one per node depending on whether we declare
 * them as "Elemental (Constant Monomial)" or "Nodal (First Lagrange)".  No changes to the
 * source are necessary to switch from one type or the other.
 */
Real
ISS::computeValue()
{
  Real F = 96485;
  Real R = 8.314;

//  for (unsigned int qp = 0; _qrule->n_points(); ++qp)
//      ava += _Ecorr[qp];
//    	  return -_nS * _Porosity * _C9[_qp] * exp(_T[_qp]) * _Ecorr[_qp];
   return 0;

//  return -_nS * _Porosity * F * _kS * _C9[_qp] * _C9[_qp] * exp((1+_aS) * F / (R * _T[_qp]) * _Ecorr[_qp]) * exp(-F / (R * _T[_qp]) * (_ES12 + _aS3 * _ES3));
}

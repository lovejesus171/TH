//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "AN.h"

registerMooseObject("MooseApp", AN);

defineLegacyParams(AN);

InputParameters
AN::validParams()
{
  InputParameters params = GeneralPostprocessor::validParams();
  params.addRequiredParam<VariableName>("C6", "Cl- concentration");
  params.addRequiredParam<VariableName>("C1","CuCl2- concentration");
  params.addRequiredParam<VariableName>("T","Temperature");
  params.addRequiredParam<VariableName>("Ecorr","Corrosion potential");

  params.addParam<Real>("Porosity",0.05,"Porosity of film");

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

AN::AN(const InputParameters & parameters)
  : GeneralPostprocessor(parameters),
    _C6(parameters.get<VariableName>("C6")),
    _C9(parameters.get<VariableName>("C9")),
    _C1(parameters.get<VariableName>("C1")),
    _T(parameters.get<VariableName>("T")),
    _Ecorr(parameters.get<VariableName>("Ecorr")),

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

void
AN::initialize()
{
   _IA = 0.0;
}

void
AN::execute()
{
   Real F = 96485;
   Real R = 8.314;

   _IA = -_nS * _Porosity * F * _kS * _u[_qp] * _u[_qp] * exp((1+_aS) * F / (R * _T) * _Ecorr) * exp(-F / (R * _T * (_ES12 + _aS3 * _ES3)));
}


PostprocessorValue
AN::getValue()
{

   Real F = 96485;
   Real R = 8.314;

   return _IA;

}

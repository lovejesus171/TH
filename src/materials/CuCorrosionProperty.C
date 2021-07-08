//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "CuCorrosionProperty.h"

registerMooseObject("corrosionApp", CuCorrosionProperty);

InputParameters
CuCorrosionProperty::validParams()
{
  InputParameters params = ADMaterial::validParams();
  params.addParam<Real>("aS", 0.5, "Constant");
  params.addParam<Real>("aC", 0.37 , "Constant");
  params.addParam<Real>("aD", 0.5, "Constant");
  params.addParam<Real>("aE", 0.5, "Constant");
  params.addParam<Real>("aF", 0.15, "Constant");
  params.addParam<Real>("aS3", 0.5, "Constant");


  params.addParam<Real>("EA", -0.105, "Constant");
  params.addParam<Real>("ES12", -0.747, "Constant");
  params.addParam<Real>("ES3", -0.747, "Constant");
  params.addParam<Real>("EC", 0.16, "Constant");
  params.addParam<Real>("ED", 0.223, "Constant");
  params.addParam<Real>("EE", -1.005, "Constant");
  params.addParam<Real>("EF", -0.764, "Constant");

  params.addParam<Real>("nA",1, "Constant");
  params.addParam<Real>("nD",1, "Constant");
  params.addParam<Real>("nE",1, "Constant");
  params.addParam<Real>("nF",1,"Constant");
  params.addParam<Real>("nO",4,"Constant");
  params.addParam<Real>("nS",1,"Constant"); 

  params.addParam<Real>("kA", 1.1880E-4, "Constant");
  params.addParam<Real>("kC", 6.12E-7, "Constant");
  params.addParam<Real>("kD", 7.2E-6, "Constant");
  params.addParam<Real>("kE", 7.2E-6, "Constant");
  params.addParam<Real>("kS", 2.16E2, "Constant");
  params.addParam<Real>("kF", 2.4444E-3, "Constant");
  params.addParam<Real>("kBB", 0.5112, "Constant");


  params.addParam<Real>("Porosity", 0.05, "Constant");

  params.addParam<Real>("Area",0,"Area of film");

  params.addRequiredParam<Real>("AnodeAreaValue","Put the value for anode area");


  return params;
}

CuCorrosionProperty::CuCorrosionProperty(const InputParameters & parameters)
  : Material(parameters),
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

    _Area(getParam<Real>("Area")),
    _AnodeAreaValue(getParam<Real>("AnodeAreaValue")),
    _AnodeArea(declareADProperty<Real>("AnodeArea"))
{
}

void
CuCorrosionProperty::initQpStatefulProperties()
{
  _AnodeArea[_qp] = _AnodeAreaValue;
}

void
CuCorrosionProperty::computeQpProperties()
{
}

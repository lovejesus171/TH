//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "ADUO2Property.h"

registerMooseObject("corrosionApp", ADUO2Property);

InputParameters
ADUO2Property::validParams()
{
  InputParameters params = ADMaterial::validParams();
  params.addParam<Real>("UO22p",1E-5,"Put the saturation value");
  params.addParam<Real>("UO2CO322m",1E-4,"Put the saturation value");
  params.addParam<Real>("UOH4",4E-10,"Put the saturation value");
  params.addParam<Real>("Fe2p",5E-6,"Put the saturation value");


  return params;
}

ADUO2Property::ADUO2Property(const InputParameters & parameters)
  : ADMaterial(parameters),
    _UO22pValue(getParam<Real>("UO22p")),
    _Sat_UO22p(declareADProperty<Real>("Sat_UO22p")),

    _UO2CO322mValue(getParam<Real>("UO2CO322m")),
    _Sat_UO2CO322m(declareADProperty<Real>("Sat_UO2CO322m")),

    _UOH4Value(getParam<Real>("UOH4")),
    _Sat_UOH4(declareADProperty<Real>("Sat_UOH4")),

    _Fe2pValue(getParam<Real>("Fe2p")),
    _Sat_Fe2p(declareADProperty<Real>("Sat_Fe2p"))


{
}

void
ADUO2Property::initQpStatefulProperties()
{
	_Sat_UO22p[_qp] = _UO22pValue;
	_Sat_UO2CO322m[_qp] = _UO2CO322mValue;
	_Sat_UOH4[_qp] = _UOH4Value;
	_Sat_Fe2p[_qp] = _Fe2pValue;

}

void
ADUO2Property::computeQpProperties()
{
  _Sat_UO22p[_qp] = _UO22pValue;
  _Sat_UO2CO322m[_qp] = _UO2CO322mValue;
  _Sat_UOH4[_qp] = _UOH4Value;
  _Sat_Fe2p[_qp] = _Fe2pValue;

}

//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "MEcorr.h"

registerMooseObject("corrosionApp", MEcorr);

InputParameters
MEcorr::validParams()
{
  InputParameters params = ADMaterial::validParams();
  params.addRequiredCoupledVar("C9", "HS- Concentration variable");
  params.addRequiredParam<MaterialPropertyName>("Ecorr",
                                                "Name of the ad property this material defines, (Corrosion Potential)");
  params.addRequiredParam<MaterialPropertyName>("Isum",
                                                "Sum of current");
  params.addRequiredCoupledVar("T", "Temperature of the system");

  params.addCoupledVar("C1",0,"CuCl2-");
  params.addCoupledVar("C0",0,"O2(aq)");
  params.addCoupledVar("C3",0, "Cu2+");
  params.addCoupledVar("C6",0, "Cl-");



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
  params.addParam<Real>("Tol",1E-10,"Tolerance for this iteration");
  params.addParam<Real>("Del_E",1E-5,"Potential change");

  params.addRequiredParam<MaterialPropertyName>("IS","Current from reaction A");
  params.addRequiredParam<MaterialPropertyName>("IA","Current from reaction S");
  params.addRequiredParam<MaterialPropertyName>("IE","Current from reaction E");
  params.addRequiredParam<MaterialPropertyName>("IF","Current from reaction F");




  return params;
}

MEcorr::MEcorr(const InputParameters & parameters)
  : ADMaterial(parameters),
    _Ecorr(declareADProperty<Real>(getParam<MaterialPropertyName>("Ecorr"))),
    _Isum(declareADProperty<Real>(getParam<MaterialPropertyName>("Isum"))),
    _C9(adCoupledValue("C9")),

    _T(adCoupledValue("T")),
    
    _C1(adCoupledValue("C1")),
    _C0(adCoupledValue("C0")),
    _C3(adCoupledValue("C3")),
    _C6(adCoupledValue("C6")),

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

    _Tol(getParam<Real>("Tol")),
    _Del_E(getParam<Real>("Del_E")),

    _IS(declareADProperty<Real>("IS")),
    _IA(declareADProperty<Real>("IA")),
    _IE(declareADProperty<Real>("IE")),
    _IF(declareADProperty<Real>("IF"))

{
}

// Note that the structure of the two (uncommented) methods below are for testing purposes only;
// e.g. this material demonstrates that you get bad convergence when you drop the derivative
// information from the coupled variable. A production version of this material would look like
// this:
//
// // void
// MEcorr::computeQpProperties()
// {
//   _ad_mat_prop[_qp] = 4.0 * _coupled_var[_qp];
// }

void
MEcorr::computeQpProperties()
{
   Real F = 96485;
   Real R = 8.314;
   _Ecorr[_qp] = -0.99;  //Initial guess
   _IA[_qp] = 1;
   _IS[_qp] = 2;
   _IE[_qp] = 3;
   _IF[_qp] = 4;
//   _Isum[_qp] = 0; // Initial guess

        //Herein, Find the Ecorr which produce sum of current < Tol.
        while (true)
//       for(int count=0; count < 1000; ++count)
         {
           _Isum[_qp] =
	       _nS * _Porosity * _kS * _C9[_qp] * _C9[_qp] * exp((1 + _aS) * F / (R * _T[_qp]) * _Ecorr[_qp]) * exp(-F / (R * _T[_qp]) * (_ES12 + _aS3 * _ES3))
	      - _nE * (1 - _Porosity) * _kE * _C9[_qp] * exp(-_aE * F / (R * _T[_qp]) * (_Ecorr[_qp] - _EE));
             if (_Isum[_qp] < -_Tol)
	     { _Ecorr[_qp] +=  _Del_E;}
             else if (_Isum[_qp] > _Tol)
	     {  _Ecorr[_qp] -=  _Del_E;}
	     else
	     {  break;}
          }

//	_IA[_qp] = _nA * _Porosity * _kA * _C6[_qp] * _C6[_qp] * exp(F / (R * _T[_qp]) * (_Ecorr[_qp] - _EA)) - _nA * _Porosity * _kBB * _C1[_qp];
//        _IS[_qp] = _nS * _Porosity * _kS * _C9[_qp] * _C9[_qp] * exp((1 + _aS) * F / (R * _T[_qp]) * _Ecorr[_qp]) * exp(-F / (R * _T[_qp]) * (_ES12 + _aS3 * _ES3));
//	_IE[_qp] = -_nE * (1 - _Porosity) * _kE * _C9[_qp] * exp(-_aE * F / (R * _T[_qp]) * (_Ecorr[_qp] - _EE));
//	_IF[_qp] = -_nF * (1 - _Porosity) * _kF * exp(-_aF * F / (R * _T[_qp] * (_Ecorr[_qp] - _EF)));
  
}

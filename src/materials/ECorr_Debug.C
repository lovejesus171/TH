//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "ECorr_Debug.h"

registerMooseObject("corrosionApp", ECorr_Debug);

InputParameters
ECorr_Debug::validParams()
{
  InputParameters params = ADMaterial::validParams();
  params.addCoupledVar("T",298.15,"T");
  params.addRequiredCoupledVar("C9","HS-");
  params.addCoupledVar("C1",0,"C1");
  params.addCoupledVar("C0",0,"C0");
  params.addCoupledVar("C3",0,"C3");
  params.addCoupledVar("C6",0,"C6");

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

  params.addParam<Real>("Tol",1E-1,"Constant");
  params.addParam<Real>("DelE",1E-4,"Constant");

  params.addParam<Real>("Area",0,"Area of film");

  params.addRequiredParam<Real>("AnodeAreaValue","Put the value for anode area");


  return params;
}

ECorr_Debug::ECorr_Debug(const InputParameters & parameters)
  : Material(parameters),
    _T(adCoupledValue("T")),
    _C9(adCoupledValue("C9")),
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


    // Declare that this material is going to have a Real
    // valued property named "diffusivity" that Kernels can use.
    _IAA(declareADProperty<Real>("IAA")),
    _ISS(declareADProperty<Real>("ISS")),
    _IEE(declareADProperty<Real>("IEE")),
    _IFF(declareADProperty<Real>("IFF")),
    _Isum(declareADProperty<Real>("Isum")),
    _Ecorr(declareADProperty<Real>("Ecorr")),
    _PreEcorr(declareADProperty<Real>("PreEcorr")),
    _rlt(declareADProperty<Real>("rlt")),

    // Retrieve/use an old value of diffusivity.
    // Note: this is _expensive_ - only do this if you REALLY need it!
    _ISS_old(getMaterialPropertyOld<Real>("ISS")),
    _IEE_old(getMaterialPropertyOld<Real>("IEE")),
    _IAA_old(getMaterialPropertyOld<Real>("IAA")),
    _IFF_old(getMaterialPropertyOld<Real>("IFF")),
    _Isum_old(getMaterialPropertyOld<Real>("Isum")),
    _Ecorr_old(getMaterialPropertyOld<Real>("Ecorr")),


    _Tol(getParam<Real>("Tol")),
    _DelE(getParam<Real>("DelE")),

    _Area(getParam<Real>("Area")),
    _AnodeAreaValue(getParam<Real>("AnodeAreaValue")),
    _AnodeArea(declareADProperty<Real>("AnodeArea"))
{
}

void
ECorr_Debug::initQpStatefulProperties()
{
//  _ISS[_qp] = 0;
//  _IEE[_qp] = 0;
//  _Isum[_qp] = 0;
//  _Ecorr[_qp] = _Ecorr_old[_qp];
  _AnodeArea[_qp] = _AnodeAreaValue;
}

void
ECorr_Debug::computeQpProperties()
{
  Real F = 96485;
  Real R = 8.314;
  Real n = 0;
  //printf("Calculating corrosion potential \n");
  //Calculate Corrosion Potential at given time and each quadruture point
          while (true)
                {
		n = n+1;
		      	//Calculate current from each reaction
  _IAA[_qp] = F * _nA * _AnodeArea[_qp] * _kA * _C6[_qp] * _C6[_qp] * exp(F /(R * _T[_qp])*(_Ecorr[_qp] - _EA)) - F * _nA * _AnodeArea[_qp] * _kBB * _C1[_qp];
  _ISS[_qp] = F *  _nS * _AnodeArea[_qp] * _kS * _C9[_qp] * _C9[_qp] * exp((1 + _aS) * F / (R * _T[_qp]) * _Ecorr[_qp]) * exp(-F / (R * _T[_qp]) * (_ES12 + _aS3 * _ES3));
  _IEE[_qp] = -F * _nE * (1 - _Porosity + _Area) * _kE * _C9[_qp] * exp(-_aE * F / (R * _T[_qp]) * (_Ecorr[_qp] - _EE));
  _IFF[_qp] = -F * _nF * (1 - _Porosity + _Area) * _kF * exp(-_aF * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EF));

      			_Isum[_qp] = _IAA[_qp] + _ISS[_qp] + _IEE[_qp] + _IFF[_qp];
		        _rlt[_qp] = (_Ecorr[_qp] - _Ecorr_old[_qp]) / _Ecorr_old[_qp];
		 if (_Isum[_qp] < -_Tol)
		  {
		//    	  printf("Corrosion potential +: %lf \n",_Ecorr[_qp]);
//      			  _PreEcorr[_qp] = _Ecorr[_qp];
			  _Ecorr[_qp] = _Ecorr[_qp] + _DelE;
		//	  _Ecorr[_qp] = _Ecorr[_qp] + (_Ecorr_old[_qp] - _Ecorr[_qp] + _DelE) * _rlt[_qp];
		  }
		else if (_Isum[_qp] > _Tol)
		  {
		//	  printf("Corrosion potential -: %lf \n", _Ecorr[_qp]);
			  _Ecorr[_qp] = _Ecorr[_qp] - _DelE;
//			  _PreEcorr[_qp] = _Ecorr[_qp];
//			  _Ecorr[_qp] = _Ecorr[_qp] + (_PreEcorr[_qp] - _Ecorr[_qp]) * _rlt[_qp];
//		
		  }
		 else if(n > 100000)
		 {
			printf("n > 100000 \n");
			 break;
		
		 }
		 else
   			break;

		}
}

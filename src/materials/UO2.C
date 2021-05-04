//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "UO2.h"

registerMooseObject("corrosionApp", UO2);

InputParameters
UO2::validParams()
{
  InputParameters params = ADMaterial::validParams();
  params.addCoupledVar("T",298.15,"T");
  params.addCoupledVar("C1",0,"CO32-");
  params.addCoupledVar("C2",0,"H2(aq)");
  params.addCoupledVar("C3",0,"H2O2");
  params.addCoupledVar("C4",0,"O2");

  params.addParam<Real>("aA", 0.96, "Constant");
  params.addParam<Real>("aB", 0.82 , "Constant");
  params.addParam<Real>("aC", 0.82, "Constant");
  params.addParam<Real>("aD", 0.5, "Constant");
  params.addParam<Real>("aE", 0.41, "Constant");
  params.addParam<Real>("aF", -0.41, "Constant");
  params.addParam<Real>("aG", -0.5, "Constant");
  params.addParam<Real>("aH", 0.5, "Constant");
  params.addParam<Real>("aI", 0.41, "Constant");
  params.addParam<Real>("aJ", -0.41, "Constant");
  params.addParam<Real>("aK", -0.5, "Constant");


  params.addParam<Real>("EA", 0.453, "Constant");
  params.addParam<Real>("EB", 0.046, "Constant");
  params.addParam<Real>("EC", 0.184, "Constant");
  params.addParam<Real>("ED", 0.049, "Constant");
  params.addParam<Real>("EE", 0.737, "Constant");
  params.addParam<Real>("EF", 0.979, "Constant");
  params.addParam<Real>("EG", 0.444, "Constant");
  params.addParam<Real>("EH", 0.049, "Constant");
  params.addParam<Real>("EI", 0.737, "Constant");
  params.addParam<Real>("EJ", 0.979, "Constant");
  params.addParam<Real>("EK", 0.444, "Constant");

  params.addParam<Real>("nA",2, "Constant");
  params.addParam<Real>("nB",2, "Constant");
  params.addParam<Real>("nC",2, "Constant");
  params.addParam<Real>("nD",2,"Constant");
  params.addParam<Real>("nE",2,"Constant");
  params.addParam<Real>("nF",2,"Constant"); 
  params.addParam<Real>("nG",4,"Constant"); 
  params.addParam<Real>("nH",2,"Constant"); 
  params.addParam<Real>("nI",2,"Constant"); 
  params.addParam<Real>("nJ",2,"Constant"); 
  params.addParam<Real>("nK",4,"Constant"); 

  params.addParam<Real>("kA", 5E-8, "Constant");
  params.addParam<Real>("kB", 1.3E-8, "Constant");
  params.addParam<Real>("kC", 1.3E-8, "Constant");
  params.addParam<Real>("kD", 3.6E-12, "Constant");
  params.addParam<Real>("kE", 7.4E-8, "Constant");
  params.addParam<Real>("kF", 1.2E-12, "Constant");
  params.addParam<Real>("kG", 1.4E-12, "Constant");
  params.addParam<Real>("kH", 1E-6, "Constant");
  params.addParam<Real>("kI", 7E-6, "Constant");
  params.addParam<Real>("kJ", 1.2E-10, "Constant");
  params.addParam<Real>("kK", 1.4E-10, "Constant");


  params.addParam<Real>("Porosity", 0.05, "Constant");
  params.addParam<Real>("NMP_fraction", 0.01, "Constant");
  params.addParam<Real>("DelH", 6E4, "Constant, J/kg -> Hmm I guess its an activation energy and unit should be J/mol");

  params.addParam<Real>("Tol",1E-1,"Constant");
  params.addParam<Real>("DelE",1E-4,"Constant");

  return params;
}

UO2::UO2(const InputParameters & parameters)
  : Material(parameters),
    _T(adCoupledValue("T")),
    _C1(adCoupledValue("C1")),
    _C2(adCoupledValue("C2")),
    _C3(adCoupledValue("C3")),
    _C4(adCoupledValue("C4")),

    _aA(getParam<Real>("aA")),
    _aB(getParam<Real>("aB")),
    _aC(getParam<Real>("aC")),
    _aD(getParam<Real>("aD")),
    _aE(getParam<Real>("aE")),
    _aF(getParam<Real>("aF")),
    _aG(getParam<Real>("aG")),
    _aH(getParam<Real>("aH")),
    _aI(getParam<Real>("aI")),
    _aJ(getParam<Real>("aJ")),
    _aK(getParam<Real>("aK")),

    _EA(getParam<Real>("EA")),
    _EB(getParam<Real>("EB")),
    _EC(getParam<Real>("EC")),
    _ED(getParam<Real>("ED")),
    _EE(getParam<Real>("EE")),
    _EF(getParam<Real>("EF")),
    _EG(getParam<Real>("EG")),
    _EH(getParam<Real>("EH")),
    _EI(getParam<Real>("EI")),
    _EJ(getParam<Real>("EJ")),
    _EK(getParam<Real>("EK")),

    _nA(getParam<Real>("nA")),
    _nB(getParam<Real>("nB")),
    _nC(getParam<Real>("nC")),
    _nD(getParam<Real>("nD")),
    _nE(getParam<Real>("nE")),
    _nF(getParam<Real>("nF")),
    _nG(getParam<Real>("nG")),
    _nH(getParam<Real>("nH")),
    _nI(getParam<Real>("nI")),
    _nJ(getParam<Real>("nJ")),
    _nK(getParam<Real>("nK")),

    _kA(getParam<Real>("kA")),
    _kB(getParam<Real>("kB")),
    _kC(getParam<Real>("kC")),
    _kD(getParam<Real>("kD")),
    _kE(getParam<Real>("kE")),
    _kF(getParam<Real>("kF")),
    _kG(getParam<Real>("kG")),
    _kH(getParam<Real>("kH")),
    _kI(getParam<Real>("kI")),
    _kJ(getParam<Real>("kJ")),
    _kK(getParam<Real>("kK")),

    _eps(getParam<Real>("Porosity")),
    _f(getParam<Real>("NMP_fraction")),


    // Declare that this material is going to have a Real
    // valued property named "diffusivity" that Kernels can use.
    _IAA(declareADProperty<Real>("IAA")),
    _IBB(declareADProperty<Real>("IBB")),
    _ICC(declareADProperty<Real>("ICC")),
    _IDD(declareADProperty<Real>("IDD")),
    _IEE(declareADProperty<Real>("IEE")),
    _IFF(declareADProperty<Real>("IFF")),
    _IGG(declareADProperty<Real>("IGG")),
    _IHH(declareADProperty<Real>("IHH")),
    _III(declareADProperty<Real>("III")),
    _IJJ(declareADProperty<Real>("IJJ")),
    _IKK(declareADProperty<Real>("IKK")),

    _Isum(declareADProperty<Real>("Isum")),
    _Ecorr(declareADProperty<Real>("Ecorr")),

    // Retrieve/use an old value of diffusivity.
    // Note: this is _expensive_ - only do this if you REALLY need it!
    _IAA_old(getMaterialPropertyOld<Real>("IAA")),
    _IBB_old(getMaterialPropertyOld<Real>("IBB")),
    _ICC_old(getMaterialPropertyOld<Real>("ICC")),
    _IDD_old(getMaterialPropertyOld<Real>("IDD")),
    _IEE_old(getMaterialPropertyOld<Real>("IEE")),
    _IFF_old(getMaterialPropertyOld<Real>("IFF")),
    _IGG_old(getMaterialPropertyOld<Real>("IGG")),
    _IHH_old(getMaterialPropertyOld<Real>("IHH")),
    _III_old(getMaterialPropertyOld<Real>("III")),
    _IJJ_old(getMaterialPropertyOld<Real>("IJJ")),
    _IKK_old(getMaterialPropertyOld<Real>("IKK")),



    _Isum_old(getMaterialPropertyOld<Real>("Isum")),
    _Ecorr_old(getMaterialPropertyOld<Real>("Ecorr")),


    _Tol(getParam<Real>("Tol")),
    _DelE(getParam<Real>("DelE"))

    {
}

void
UO2::initQpStatefulProperties()
{
  _IAA[_qp] = 0;
  _IBB[_qp] = 0;
  _ICC[_qp] = 0;
  _IDD[_qp] = 0;
  _IEE[_qp] = 0;
  _IFF[_qp] = 0;
  _IGG[_qp] = 0;
  _IHH[_qp] = 0;
  _III[_qp] = 0;
  _IJJ[_qp] = 0;
  _IKK[_qp] = 0;



  _Isum[_qp] = 0;
  _Ecorr[_qp] = _Ecorr_old[_qp];

}

void
UO2::computeQpProperties()
{
  Real F = 96485;
  Real R = 8.314;
  Real Tref = 298.15;

  //Calculate Corrosion Potential at given time and each quadruture point
          while (true)
                {
                  _Isum[_qp] = 
                  _nA * F * _eps * _kA * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * exp(_aA * F/(R * _T[_qp]) * (_Ecorr[_qp] - _EA))
		  + _nB * F * _eps * _kB * pow(_C1[_qp],0.66) * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * exp(_aB * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EB))
		  + _nC * F * _eps * _kC * pow(_C1[_qp],0.66) * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * exp(_aC * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EC))
		  + _nD * F * _eps * _kD * _C2[_qp] * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * exp(_aD * F /(R * _T[_qp]) * (_Ecorr[_qp] - _ED))
		  + _nE * F * _eps * _kE * _C3[_qp] * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * exp(_aE * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EE))
		  - _nF * F * _eps * _kF * _C3[_qp] * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * exp(-_aF * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EF))
		  - _nG * F * _eps * _kG * _C4[_qp] * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * exp(-_aG * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EG))
		  + _f * _nH * F * _eps * _kH * _C2[_qp] * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * exp(_aH * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EH))
		  + _f * _nI * F * _eps * _kI * _C3[_qp] * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * exp(_aI * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EI))
		  - _f * _nJ * F * _eps * _kJ * _C3[_qp] * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * exp(-_aJ * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EJ))
		  - _f * _nK * F * _eps * _kK * _C4[_qp] * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * exp(-_aK * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EK));

	
		  if (_Isum[_qp] < -_Tol)
                    _Ecorr[_qp] = _Ecorr[_qp] + _DelE;
                  else if (_Isum[_qp] > _Tol)
                    _Ecorr[_qp] = _Ecorr[_qp] - _DelE;
                  else
                     break;

		}
  //Calculate current from each reaction

	  _IAA[_qp] =  _nA * F * _eps * _kA * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * exp(_aA * F/(R * _T[_qp]) * (_Ecorr[_qp] - _EA));
          _IBB[_qp] = _nB * F * _eps * _kB * pow(_C1[_qp],0.66) * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * exp(_aB * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EB));
	  _ICC[_qp] = _nC * F * _eps * _kC * pow(_C1[_qp],0.66) * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * exp(_aC * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EC));
	  _IDD[_qp] = _nD * F * _eps * _kD * _C2[_qp] * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * exp(_aD * F /(R * _T[_qp]) * (_Ecorr[_qp] - _ED));
	  _IEE[_qp] =  _nE * F * _eps * _kE * _C3[_qp] * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * exp(_aE * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EE));
	  _IFF[_qp] = - _nF * F * _eps * _kF * _C3[_qp] * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * exp(-_aF * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EF));
	  _IGG[_qp] = - _nG * F * _eps * _kG * _C4[_qp] * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * exp(-_aG * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EG));
	  _IHH[_qp] = _f * _nH * F * _eps * _kH * _C2[_qp] * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * exp(_aH * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EH));
	  _III[_qp] = _f * _nI * F * _eps * _kI * _C3[_qp] * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * exp(_aI * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EI));
	  _IJJ[_qp] = - _f * _nJ * F * _eps * _kJ * _C3[_qp] * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * exp(-_aJ * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EJ));
	  _IKK[_qp] = - _f * _nK * F * _eps * _kK * _C4[_qp] * exp(_DelH/R * (1/Tref - 1/_T[_qp])) * exp(-_aK * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EK));

}

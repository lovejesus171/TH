//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "MatUO2Potential.h"

registerMooseObject("corrosionApp", MatUO2Potential);

InputParameters
MatUO2Potential::validParams()
{
  InputParameters params = Material::validParams();
  params.addCoupledVar("T",298.15,"T");
  params.addCoupledVar("C1",0,"CO32-");
  params.addCoupledVar("C2",0,"H2(aq)");
  params.addCoupledVar("C3",0,"H2O2");
  params.addCoupledVar("C4",0,"O2");

  params.addRequiredParam<MaterialPropertyName>("aA","Constant");
  params.addRequiredParam<MaterialPropertyName>("aB","Constant");
  params.addRequiredParam<MaterialPropertyName>("aC","Constant");
  params.addRequiredParam<MaterialPropertyName>("aD","Constant");
  params.addRequiredParam<MaterialPropertyName>("aE","Constant");
  params.addRequiredParam<MaterialPropertyName>("aF","Constant");
  params.addRequiredParam<MaterialPropertyName>("aG","Constant");
  params.addRequiredParam<MaterialPropertyName>("aH","Constant");
  params.addRequiredParam<MaterialPropertyName>("aI","Constant");
  params.addRequiredParam<MaterialPropertyName>("aJ","Constant");
  params.addRequiredParam<MaterialPropertyName>("aK","Constant");


  params.addRequiredParam<MaterialPropertyName>("EA","Constant");
  params.addRequiredParam<MaterialPropertyName>("EB","Constant");
  params.addRequiredParam<MaterialPropertyName>("EC","Constant");
  params.addRequiredParam<MaterialPropertyName>("ED","Constant");
  params.addRequiredParam<MaterialPropertyName>("EE","Constant");
  params.addRequiredParam<MaterialPropertyName>("EF","Constant");
  params.addRequiredParam<MaterialPropertyName>("EG","Constant");
  params.addRequiredParam<MaterialPropertyName>("EH","Constant");
  params.addRequiredParam<MaterialPropertyName>("EI","Constant");
  params.addRequiredParam<MaterialPropertyName>("EJ","Constant");
  params.addRequiredParam<MaterialPropertyName>("EK","Constant");

  params.addRequiredParam<MaterialPropertyName>("nA","Constant");
  params.addRequiredParam<MaterialPropertyName>("nB","Constant");
  params.addRequiredParam<MaterialPropertyName>("nC","Constant");
  params.addRequiredParam<MaterialPropertyName>("nD","Constant");
  params.addRequiredParam<MaterialPropertyName>("nE","Constant");
  params.addRequiredParam<MaterialPropertyName>("nF","Constant"); 
  params.addRequiredParam<MaterialPropertyName>("nG","Constant"); 
  params.addRequiredParam<MaterialPropertyName>("nH","Constant"); 
  params.addRequiredParam<MaterialPropertyName>("nI","Constant"); 
  params.addRequiredParam<MaterialPropertyName>("nJ","Constant"); 
  params.addRequiredParam<MaterialPropertyName>("nK","Constant"); 

  params.addRequiredParam<MaterialPropertyName>("kA","Constant");
  params.addRequiredParam<MaterialPropertyName>("kB","Constant");
  params.addRequiredParam<MaterialPropertyName>("kC","Constant");
  params.addRequiredParam<MaterialPropertyName>("kD","Constant");
  params.addRequiredParam<MaterialPropertyName>("kE","Constant");
  params.addRequiredParam<MaterialPropertyName>("kF","Constant");
  params.addRequiredParam<MaterialPropertyName>("kG","Constant");
  params.addRequiredParam<MaterialPropertyName>("kH","Constant");
  params.addRequiredParam<MaterialPropertyName>("kI","Constant");
  params.addRequiredParam<MaterialPropertyName>("kJ","Constant");
  params.addRequiredParam<MaterialPropertyName>("kK","Constant");


  params.addRequiredParam<MaterialPropertyName>("Porosity","Constant");
  params.addRequiredParam<MaterialPropertyName>("NMP_fraction","Constant");
  params.addRequiredParam<MaterialPropertyName>("DelH","Constant");

  params.addParam<Real>("Tol",1E-1,"Constant");
  params.addParam<Real>("DelE",1E-4,"Constant");

  return params;
}

MatUO2Potential::MatUO2Potential(const InputParameters & parameters)
  : Material(parameters),
    _T(coupledValue("T")),
    _C1(coupledValue("C1")),
    _C2(coupledValue("C2")),
    _C3(coupledValue("C3")),
    _C4(coupledValue("C4")),

    _aA(getMaterialProperty<Real>("aA")),
    _aB(getMaterialProperty<Real>("aB")),
    _aC(getMaterialProperty<Real>("aC")),
    _aD(getMaterialProperty<Real>("aD")),
    _aE(getMaterialProperty<Real>("aE")),
    _aF(getMaterialProperty<Real>("aF")),
    _aG(getMaterialProperty<Real>("aG")),
    _aH(getMaterialProperty<Real>("aH")),
    _aI(getMaterialProperty<Real>("aI")),
    _aJ(getMaterialProperty<Real>("aJ")),
    _aK(getMaterialProperty<Real>("aK")),

    _EA(getMaterialProperty<Real>("EA")),
    _EB(getMaterialProperty<Real>("EB")),
    _EC(getMaterialProperty<Real>("EC")),
    _ED(getMaterialProperty<Real>("ED")),
    _EE(getMaterialProperty<Real>("EE")),
    _EF(getMaterialProperty<Real>("EF")),
    _EG(getMaterialProperty<Real>("EG")),
    _EH(getMaterialProperty<Real>("EH")),
    _EI(getMaterialProperty<Real>("EI")),
    _EJ(getMaterialProperty<Real>("EJ")),
    _EK(getMaterialProperty<Real>("EK")),

    _nA(getMaterialProperty<Real>("nA")),
    _nB(getMaterialProperty<Real>("nB")),
    _nC(getMaterialProperty<Real>("nC")),
    _nD(getMaterialProperty<Real>("nD")),
    _nE(getMaterialProperty<Real>("nE")),
    _nF(getMaterialProperty<Real>("nF")),
    _nG(getMaterialProperty<Real>("nG")),
    _nH(getMaterialProperty<Real>("nH")),
    _nI(getMaterialProperty<Real>("nI")),
    _nJ(getMaterialProperty<Real>("nJ")),
    _nK(getMaterialProperty<Real>("nK")),

    _kA(getMaterialProperty<Real>("kA")),
    _kB(getMaterialProperty<Real>("kB")),
    _kC(getMaterialProperty<Real>("kC")),
    _kD(getMaterialProperty<Real>("kD")),
    _kE(getMaterialProperty<Real>("kE")),
    _kF(getMaterialProperty<Real>("kF")),
    _kG(getMaterialProperty<Real>("kG")),
    _kH(getMaterialProperty<Real>("kH")),
    _kI(getMaterialProperty<Real>("kI")),
    _kJ(getMaterialProperty<Real>("kJ")),
    _kK(getMaterialProperty<Real>("kK")),

    _eps(getMaterialProperty<Real>("Porosity")),
    _f(getMaterialProperty<Real>("NMP_fraction")),
    _DelH(getMaterialProperty<Real>("DelH")),

    // Declare that this material is going to have a Real
    // valued property named "diffusivity" that Kernels can use.
    _IAA(declareProperty<Real>("IAA")),
    _IBB(declareProperty<Real>("IBB")),
    _ICC(declareProperty<Real>("ICC")),
    _IDD(declareProperty<Real>("IDD")),
    _IEE(declareProperty<Real>("IEE")),
    _IFF(declareProperty<Real>("IFF")),
    _IGG(declareProperty<Real>("IGG")),
    _IHH(declareProperty<Real>("IHH")),
    _III(declareProperty<Real>("III")),
    _IJJ(declareProperty<Real>("IJJ")),
    _IKK(declareProperty<Real>("IKK")),

    _Isum(declareProperty<Real>("Isum")),
    _Ecorr(declareProperty<Real>("Ecorr")),

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
MatUO2Potential::initQpStatefulProperties()
{
  Real F = 96485;
  Real R = 8.314;
  Real Tref = 298.15;
  Real Count = 0;


//  printf("This the material initial calculation \n");
          while (true)
                {
          Count = Count + 1;
	  _IAA[_qp] = (1 - _f[_qp]) * _nA[_qp] * F * _eps[_qp] * _kA[_qp] * exp(_DelH[_qp]/R * (1/Tref - 1/_T[_qp])) * exp(_aA[_qp] * F/(R * _T[_qp]) * (_Ecorr[_qp] - _EA[_qp]));
    _IBB[_qp] = (1 - _f[_qp]) * _nB[_qp] * F * _eps[_qp] * _kB[_qp] * pow(_C1[_qp],0.66) * exp(_DelH[_qp]/R * (1/Tref - 1/_T[_qp])) * exp(_aB[_qp] * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EB[_qp]));
	  _ICC[_qp] = (1 - _f[_qp]) * _nC[_qp] * F * _eps[_qp] * _kC[_qp] * pow(_C1[_qp],0.66) * exp(_DelH[_qp]/R * (1/Tref - 1/_T[_qp])) * exp(_aC[_qp] * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EC[_qp]));
	  _IDD[_qp] = (1 - _f[_qp]) * _nD[_qp] * F * _eps[_qp] * _kD[_qp] * _C2[_qp] * exp(_DelH[_qp]/R * (1/Tref - 1/_T[_qp])) * exp(_aD[_qp] * F /(R * _T[_qp]) * (_Ecorr[_qp] - _ED[_qp]));
	  _IEE[_qp] = (1 - _f[_qp]) * _nE[_qp] * F * _eps[_qp] * _kE[_qp] * _C3[_qp] * exp(_DelH[_qp]/R * (1/Tref - 1/_T[_qp])) * exp(_aE[_qp] * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EE[_qp]));
	  _IFF[_qp] = - (1 - _f[_qp]) * _nF[_qp] * F * _eps[_qp] * _kF[_qp] * _C3[_qp] * exp(_DelH[_qp]/R * (1/Tref - 1/_T[_qp])) * exp(_aF[_qp] * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EF[_qp]));
	  _IGG[_qp] = - (1 - _f[_qp]) *_nG[_qp] * F * _eps[_qp] * _kG[_qp] * _C4[_qp] * exp(_DelH[_qp]/R * (1/Tref - 1/_T[_qp])) * exp(_aG[_qp] * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EG[_qp]));
	  _IHH[_qp] = _f[_qp] * _nH[_qp] * F * _eps[_qp] * _kH[_qp] * _C2[_qp] * exp(_DelH[_qp]/R * (1/Tref - 1/_T[_qp])) * exp(_aH[_qp] * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EH[_qp]));
	  _III[_qp] = _f[_qp] * _nI[_qp] * F * _eps[_qp] * _kI[_qp] * _C3[_qp] * exp(_DelH[_qp]/R * (1/Tref - 1/_T[_qp])) * exp(_aI[_qp] * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EI[_qp]));
	  _IJJ[_qp] = - _f[_qp] * _nJ[_qp] * F * _eps[_qp] * _kJ[_qp] * _C3[_qp] * exp(_DelH[_qp]/R * (1/Tref - 1/_T[_qp])) * exp(_aJ[_qp] * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EJ[_qp]));
	  _IKK[_qp] = - _f[_qp] * _nK[_qp] * F * _eps[_qp] * _kK[_qp] * _C4[_qp] * exp(_DelH[_qp]/R * (1/Tref - 1/_T[_qp])) * exp(_aK[_qp] * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EK[_qp]));

                  _Isum[_qp] = _IAA[_qp] + _IBB[_qp] + _ICC[_qp] + _IDD[_qp] + _IEE[_qp] + _IFF[_qp] + _IGG[_qp] + _IHH[_qp] + _III[_qp] + _IJJ[_qp] + _IKK[_qp];
	          if (Count > 100000)
			  break;
		  else if (_Isum[_qp] < -_Tol)
                    _Ecorr[_qp] = _Ecorr[_qp] + _DelE;
                  else if (_Isum[_qp] > _Tol)
                    _Ecorr[_qp] = _Ecorr[_qp] - _DelE;
                  else
                     break;

		}

}

void
MatUO2Potential::computeQpProperties()
{
  Real F = 96485;
  Real R = 8.314;
  Real Tref = 298.15;
  Real Count2 = 0;
          while (true)
                {
          Count2 = Count2 + 1;
    _IAA[_qp] = (1 - _f[_qp]) * _nA[_qp] * F * _eps[_qp] * _kA[_qp] * exp(_DelH[_qp]/R * (1/Tref - 1/_T[_qp])) * exp(_aA[_qp] * F/(R * _T[_qp]) * (_Ecorr[_qp] - _EA[_qp]));
    _IBB[_qp] = (1 - _f[_qp]) * _nB[_qp] * F * _eps[_qp] * _kB[_qp] * pow(_C1[_qp],0.66) * exp(_DelH[_qp]/R * (1/Tref - 1/_T[_qp])) * exp(_aB[_qp] * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EB[_qp]));
	  _ICC[_qp] = (1 - _f[_qp]) * _nC[_qp] * F * _eps[_qp] * _kC[_qp] * pow(_C1[_qp],0.66) * exp(_DelH[_qp]/R * (1/Tref - 1/_T[_qp])) * exp(_aC[_qp] * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EC[_qp]));
	  _IDD[_qp] = (1 - _f[_qp]) * _nD[_qp] * F * _eps[_qp] * _kD[_qp] * _C2[_qp] * exp(_DelH[_qp]/R * (1/Tref - 1/_T[_qp])) * exp(_aD[_qp] * F /(R * _T[_qp]) * (_Ecorr[_qp] - _ED[_qp]));
	  _IEE[_qp] = (1 - _f[_qp]) * _nE[_qp] * F * _eps[_qp] * _kE[_qp] * _C3[_qp] * exp(_DelH[_qp]/R * (1/Tref - 1/_T[_qp])) * exp(_aE[_qp] * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EE[_qp]));
	  _IFF[_qp] = - (1 - _f[_qp]) * _nF[_qp] * F * _eps[_qp] * _kF[_qp] * _C3[_qp] * exp(_DelH[_qp]/R * (1/Tref - 1/_T[_qp])) * exp(_aF[_qp] * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EF[_qp]));
	  _IGG[_qp] = - (1 - _f[_qp]) *_nG[_qp] * F * _eps[_qp] * _kG[_qp] * _C4[_qp] * exp(_DelH[_qp]/R * (1/Tref - 1/_T[_qp])) * exp(_aG[_qp] * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EG[_qp]));
	  _IHH[_qp] = _f[_qp] * _nH[_qp] * F * _eps[_qp] * _kH[_qp] * _C2[_qp] * exp(_DelH[_qp]/R * (1/Tref - 1/_T[_qp])) * exp(_aH[_qp] * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EH[_qp]));
	  _III[_qp] = _f[_qp] * _nI[_qp] * F * _eps[_qp] * _kI[_qp] * _C3[_qp] * exp(_DelH[_qp]/R * (1/Tref - 1/_T[_qp])) * exp(_aI[_qp] * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EI[_qp]));
	  _IJJ[_qp] = - _f[_qp] * _nJ[_qp] * F * _eps[_qp] * _kJ[_qp] * _C3[_qp] * exp(_DelH[_qp]/R * (1/Tref - 1/_T[_qp])) * exp(_aJ[_qp] * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EJ[_qp]));
	  _IKK[_qp] = - _f[_qp] * _nK[_qp] * F * _eps[_qp] * _kK[_qp] * _C4[_qp] * exp(_DelH[_qp]/R * (1/Tref - 1/_T[_qp])) * exp(_aK[_qp] * F /(R * _T[_qp]) * (_Ecorr[_qp] - _EK[_qp]));

                  _Isum[_qp] = _IAA[_qp] + _IBB[_qp] + _ICC[_qp] + _IDD[_qp] + _IEE[_qp] + _IFF[_qp] + _IGG[_qp] + _IHH[_qp] + _III[_qp] + _IJJ[_qp] + _IKK[_qp];
	
		  if (Count2 > 100000)
			  break;
		  else if (_Isum[_qp] < -_Tol)
                    _Ecorr[_qp] = _Ecorr[_qp] + _DelE;
                  else if (_Isum[_qp] > _Tol)
                    _Ecorr[_qp] = _Ecorr[_qp] - _DelE;
                  else
                     break;

		}

}

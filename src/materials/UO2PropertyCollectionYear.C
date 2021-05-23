//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "UO2PropertyCollectionYear.h"

registerMooseObject("corrosionApp", UO2PropertyCollectionYear);

InputParameters
UO2PropertyCollectionYear::validParams()
{
  InputParameters params = Material::validParams();
  params.addParam<Real>("UO22p",1E-5,"Put the saturation value");
  params.addParam<Real>("UO2CO322m",1E-4,"Put the saturation value");
  params.addParam<Real>("UOH4",4E-10,"Put the saturation value");
  params.addParam<Real>("Fe2p",5E-6,"Put the saturation value");

  params.addParam<Real>("aA_value", 0.96, "Constant");
  params.addParam<Real>("aB_value", 0.82 , "Constant");
  params.addParam<Real>("aC_value", 0.82, "Constant");
  params.addParam<Real>("aD_value", 0.5, "Constant");
  params.addParam<Real>("aE_value", 0.41, "Constant");
  params.addParam<Real>("aF_value", -0.41, "Constant");
  params.addParam<Real>("aG_value", -0.5, "Constant");
  params.addParam<Real>("aH_value", 0.5, "Constant");
  params.addParam<Real>("aI_value", 0.41, "Constant");
  params.addParam<Real>("aJ_value", -0.41, "Constant");
  params.addParam<Real>("aK_value", -0.5, "Constant");


  params.addParam<Real>("EA_value", 0.453, "Constant");
  params.addParam<Real>("EB_value", 0.046, "Constant");
  params.addParam<Real>("EC_value", 0.184, "Constant");
  params.addParam<Real>("ED_value", 0.049, "Constant");
  params.addParam<Real>("EE_value", 0.737, "Constant");
  params.addParam<Real>("EF_value", 0.979, "Constant");
  params.addParam<Real>("EG_value", 0.444, "Constant");
  params.addParam<Real>("EH_value", 0.049, "Constant");
  params.addParam<Real>("EI_value", 0.737, "Constant");
  params.addParam<Real>("EJ_value", 0.979, "Constant");
  params.addParam<Real>("EK_value", 0.444, "Constant");

  params.addParam<Real>("nA_value",2, "Constant");
  params.addParam<Real>("nB_value",2, "Constant");
  params.addParam<Real>("nC_value",2, "Constant");
  params.addParam<Real>("nD_value",2,"Constant");
  params.addParam<Real>("nE_value",2,"Constant");
  params.addParam<Real>("nF_value",2,"Constant"); 
  params.addParam<Real>("nG_value",4,"Constant"); 
  params.addParam<Real>("nH_value",2,"Constant"); 
  params.addParam<Real>("nI_value",2,"Constant"); 
  params.addParam<Real>("nJ_value",2,"Constant"); 
  params.addParam<Real>("nK_value",4,"Constant"); 

  params.addParam<Real>("kA_value", 5E-8, "Constant");
  params.addParam<Real>("kB_value", 1.3E-8, "Constant");
  params.addParam<Real>("kC_value", 1.3E-8, "Constant");
  params.addParam<Real>("kD_value", 3.6E-12, "Constant");
  params.addParam<Real>("kE_value", 7.4E-8, "Constant");
  params.addParam<Real>("kF_value", 1.2E-12, "Constant");
  params.addParam<Real>("kG_value", 1.4E-12, "Constant");
  params.addParam<Real>("kH_value", 1E-6, "Constant");
  params.addParam<Real>("kI_value", 7E-6, "Constant");
  params.addParam<Real>("kJ_value", 1.2E-10, "Constant");
  params.addParam<Real>("kK_value", 1.4E-10, "Constant");
  params.addParam<Real>("kL_value", 1.9E-12, "Constant");

  params.addParam<Real>("Porosity_value", 1, "Constant");
  params.addParam<Real>("NMP_fraction_value", 0.01, "Constant");
  params.addParam<Real>("DelH_value", -6E4, "Constant, J/kg -> Hmm I guess its an activation energy and unit should be J/mol");

  params.addParam<Real>("kM_value", 1E-3, "Constant");
  params.addParam<Real>("kN_value", 1E-3, "Constant");
  params.addParam<Real>("kO_value", 1E-3, "Constant");
  params.addParam<Real>("kP_value", 1E-4, "Constant");
  params.addParam<Real>("kQ_value", 8.6E-7, "Constant");
  params.addParam<Real>("kR_value", 8.6E-7, "Constant");
  params.addParam<Real>("kS_value", 8.6E-6, "Constant");
  params.addParam<Real>("kT_value", 8.6E-6, "Constant");
  params.addParam<Real>("kU_value", 6.9E-2, "Constant");
  params.addParam<Real>("kV_value", 5.9E-1, "Constant");
  params.addParam<Real>("kW_value", 1E-2, "Constant");
  params.addParam<Real>("kX_value", 1E-3, "Constant");
  params.addParam<Real>("kY_value", 4.5E-7, "Constant");


  return params;
}

UO2PropertyCollectionYear::UO2PropertyCollectionYear(const InputParameters & parameters)
  : Material(parameters),
    _UO22pValue(getParam<Real>("UO22p")),
    _Sat_UO22p(declareProperty<Real>("Sat_UO22p")),

    _UO2CO322mValue(getParam<Real>("UO2CO322m")),
    _Sat_UO2CO322m(declareProperty<Real>("Sat_UO2CO322m")),

    _UOH4Value(getParam<Real>("UOH4")),
    _Sat_UOH4(declareProperty<Real>("Sat_UOH4")),

    _Fe2pValue(getParam<Real>("Fe2p")),
    _Sat_Fe2p(declareProperty<Real>("Sat_Fe2p")),
    
    
    _aA_value(getParam<Real>("aA_value")),
    _aA(declareProperty<Real>("aA")),
    _aB_value(getParam<Real>("aB_value")),
    _aB(declareProperty<Real>("aB")),
    _aC_value(getParam<Real>("aC_value")),
    _aC(declareProperty<Real>("aC")),
    _aD_value(getParam<Real>("aD_value")),
    _aD(declareProperty<Real>("aD")),
    _aE_value(getParam<Real>("aE_value")),
    _aE(declareProperty<Real>("aE")),
    _aF_value(getParam<Real>("aF_value")),
    _aF(declareProperty<Real>("aF")),
    _aG_value(getParam<Real>("aG_value")),
    _aG(declareProperty<Real>("aG")),
    _aH_value(getParam<Real>("aH_value")),
    _aH(declareProperty<Real>("aH")),
    _aI_value(getParam<Real>("aI_value")),
    _aI(declareProperty<Real>("aI")),
    _aJ_value(getParam<Real>("aJ_value")),
    _aJ(declareProperty<Real>("aJ")),
    _aK_value(getParam<Real>("aK_value")),
    _aK(declareProperty<Real>("aK")),
       
    _EA_value(getParam<Real>("EA_value")),
    _EA(declareProperty<Real>("EA")),
    _EB_value(getParam<Real>("EB_value")),
    _EB(declareProperty<Real>("EB")),
    _EC_value(getParam<Real>("EC_value")),
    _EC(declareProperty<Real>("EC")),
    _ED_value(getParam<Real>("ED_value")),
    _ED(declareProperty<Real>("ED")),
    _EE_value(getParam<Real>("EE_value")),
    _EE(declareProperty<Real>("EE")),
    _EF_value(getParam<Real>("EF_value")),
    _EF(declareProperty<Real>("EF")),
    _EG_value(getParam<Real>("EG_value")),
    _EG(declareProperty<Real>("EG")),
    _EH_value(getParam<Real>("EH_value")),
    _EH(declareProperty<Real>("EH")),
    _EI_value(getParam<Real>("EI_value")),
    _EI(declareProperty<Real>("EI")),
    _EJ_value(getParam<Real>("EJ_value")),
    _EJ(declareProperty<Real>("EJ")),
    _EK_value(getParam<Real>("EK_value")),
    _EK(declareProperty<Real>("EK")),
       
    _nA_value(getParam<Real>("nA_value")),
    _nA(declareProperty<Real>("nA")),
    _nB_value(getParam<Real>("nB_value")),
    _nB(declareProperty<Real>("nB")),
    _nC_value(getParam<Real>("nC_value")),
    _nC(declareProperty<Real>("nC")),
    _nD_value(getParam<Real>("nD_value")),
    _nD(declareProperty<Real>("nD")),
    _nE_value(getParam<Real>("nE_value")),
    _nE(declareProperty<Real>("nE")),
    _nF_value(getParam<Real>("nF_value")),
    _nF(declareProperty<Real>("nF")),
    _nG_value(getParam<Real>("nG_value")),
    _nG(declareProperty<Real>("nG")),
    _nH_value(getParam<Real>("nH_value")),
    _nH(declareProperty<Real>("nH")),
    _nI_value(getParam<Real>("nI_value")),
    _nI(declareProperty<Real>("nI")),
    _nJ_value(getParam<Real>("nJ_value")),
    _nJ(declareProperty<Real>("nJ")),
    _nK_value(getParam<Real>("nK_value")),
    _nK(declareProperty<Real>("nK")),
       
    _kA_value(getParam<Real>("kA_value")),
    _kA(declareProperty<Real>("kA")),
    _kB_value(getParam<Real>("kB_value")),
    _kB(declareProperty<Real>("kB")),
    _kC_value(getParam<Real>("kC_value")),
    _kC(declareProperty<Real>("kC")),
    _kD_value(getParam<Real>("kD_value")),
    _kD(declareProperty<Real>("kD")),
    _kE_value(getParam<Real>("kE_value")),
    _kE(declareProperty<Real>("kE")),
    _kF_value(getParam<Real>("kF_value")),
    _kF(declareProperty<Real>("kF")),
    _kG_value(getParam<Real>("kG_value")),
    _kG(declareProperty<Real>("kG")),
    _kH_value(getParam<Real>("kH_value")),
    _kH(declareProperty<Real>("kH")),
    _kI_value(getParam<Real>("kI_value")),
    _kI(declareProperty<Real>("kI")),
    _kJ_value(getParam<Real>("kJ_value")),
    _kJ(declareProperty<Real>("kJ")),
    _kK_value(getParam<Real>("kK_value")),
    _kK(declareProperty<Real>("kK")),
    _kL_value(getParam<Real>("kL_value")),
    _kL(declareProperty<Real>("kL")),
    
    _eps_value(getParam<Real>("Porosity_value")),
    _eps(declareProperty<Real>("eps")),
    _f_value(getParam<Real>("NMP_fraction_value")),
    _f(declareProperty<Real>("f")),
    _DelH_value(getParam<Real>("DelH_value")),
    _DelH(declareProperty<Real>("DelH")),
    
    _kM_value(getParam<Real>("kM_value")),
    _kM(declareProperty<Real>("kM")),
    _kN_value(getParam<Real>("kN_value")),
    _kN(declareProperty<Real>("kN")),
    _kO_value(getParam<Real>("kO_value")),
    _kO(declareProperty<Real>("kO")),
    _kP_value(getParam<Real>("kP_value")),
    _kP(declareProperty<Real>("kP")),
    _kQ_value(getParam<Real>("kQ_value")),
    _kQ(declareProperty<Real>("kQ")),
    _kR_value(getParam<Real>("kR_value")),
    _kR(declareProperty<Real>("kR")),
    _kS_value(getParam<Real>("kS_value")),
    _kS(declareProperty<Real>("kS")),
    _kT_value(getParam<Real>("kT_value")),
    _kT(declareProperty<Real>("kT")),
    _kU_value(getParam<Real>("kU_value")),
    _kU(declareProperty<Real>("kU")),
    _kV_value(getParam<Real>("kV_value")),
    _kV(declareProperty<Real>("kV")),
    _kW_value(getParam<Real>("kW_value")),
    _kW(declareProperty<Real>("kW")),
    _kX_value(getParam<Real>("kX_value")),
    _kX(declareProperty<Real>("kX")),
    _kY_value(getParam<Real>("kY_value")),
    _kY(declareProperty<Real>("kY"))
{
}

void
UO2PropertyCollectionYear::initQpStatefulProperties()
{
	Real time_changer = 365 * 24 * 60 * 60; //Second to year
	
	_Sat_UO22p[_qp] = _UO22pValue;
	_Sat_UO2CO322m[_qp] = _UO2CO322mValue;
	_Sat_UOH4[_qp] = _UOH4Value;
	_Sat_Fe2p[_qp] = _Fe2pValue;
	
	_aA[_qp] = _aA_value;
	_aB[_qp] = _aB_value;
	_aC[_qp] = _aC_value;
	_aD[_qp] = _aD_value;
	_aE[_qp] = _aE_value;
	_aF[_qp] = _aF_value;
	_aG[_qp] = _aG_value;
	_aH[_qp] = _aH_value;
	_aI[_qp] = _aI_value;
	_aJ[_qp] = _aJ_value;
	_aK[_qp] = _aK_value;

	
	_EA[_qp] = _EA_value;
	_EB[_qp] = _EB_value;
	_EC[_qp] = _EC_value;
	_ED[_qp] = _ED_value;
	_EE[_qp] = _EE_value;
	_EF[_qp] = _EF_value;
	_EG[_qp] = _EG_value;
	_EH[_qp] = _EH_value;
	_EI[_qp] = _EI_value;
	_EJ[_qp] = _EJ_value;
	_EK[_qp] = _EK_value;

	
	_nA[_qp] = _nA_value;
	_nB[_qp] = _nB_value;
	_nC[_qp] = _nC_value;
	_nD[_qp] = _nD_value;
	_nE[_qp] = _nE_value;
	_nF[_qp] = _nF_value;
	_nG[_qp] = _nG_value;
	_nH[_qp] = _nH_value;
	_nI[_qp] = _nI_value;
	_nJ[_qp] = _nJ_value;
	_nK[_qp] = _nK_value;

	
	_kA[_qp] = _kA_value * time_changer;
	_kB[_qp] = _kB_value * time_changer;
	_kC[_qp] = _kC_value * time_changer;
	_kD[_qp] = _kD_value * time_changer;
	_kE[_qp] = _kE_value * time_changer;
	_kF[_qp] = _kF_value * time_changer;
	_kG[_qp] = _kG_value * time_changer;
	_kH[_qp] = _kH_value * time_changer;
	_kI[_qp] = _kI_value * time_changer;
	_kJ[_qp] = _kJ_value * time_changer;
	_kK[_qp] = _kK_value * time_changer;
	_kL[_qp] = _kL_value * time_changer;
	
	_eps[_qp] = _eps_value;
	_f[_qp] = _f_value;
	_DelH[_qp] = _DelH_value;
	
	_kM[_qp] = _kM_value * time_changer;
	_kN[_qp] = _kN_value * time_changer;
	_kO[_qp] = _kO_value * time_changer;
	_kP[_qp] = _kP_value * time_changer;
	_kQ[_qp] = _kQ_value * time_changer;
	_kR[_qp] = _kR_value * time_changer;
	_kS[_qp] = _kS_value * time_changer;
	_kT[_qp] = _kT_value * time_changer;
	_kU[_qp] = _kU_value * time_changer;
	_kV[_qp] = _kV_value * time_changer;
	_kW[_qp] = _kW_value * time_changer;
	_kX[_qp] = _kX_value * time_changer;
	_kY[_qp] = _kY_value * time_changer;
}

void
UO2PropertyCollectionYear::computeQpProperties()
{
	Real time_changer = 365 *24 * 60 * 60;
  _Sat_UO22p[_qp] = _UO22pValue;
  _Sat_UO2CO322m[_qp] = _UO2CO322mValue;
  _Sat_UOH4[_qp] = _UOH4Value;
  _Sat_Fe2p[_qp] = _Fe2pValue;

	
	_aA[_qp] = _aA_value;
	_aB[_qp] = _aB_value;
	_aC[_qp] = _aC_value;
	_aD[_qp] = _aD_value;
	_aE[_qp] = _aE_value;
	_aF[_qp] = _aF_value;
	_aG[_qp] = _aG_value;
	_aH[_qp] = _aH_value;
	_aI[_qp] = _aI_value;
	_aJ[_qp] = _aJ_value;
	_aK[_qp] = _aK_value;

	
	_EA[_qp] = _EA_value;
	_EB[_qp] = _EB_value;
	_EC[_qp] = _EC_value;
	_ED[_qp] = _ED_value;
	_EE[_qp] = _EE_value;
	_EF[_qp] = _EF_value;
	_EG[_qp] = _EG_value;
	_EH[_qp] = _EH_value;
	_EI[_qp] = _EI_value;
	_EJ[_qp] = _EJ_value;
	_EK[_qp] = _EK_value;

	
	_nA[_qp] = _nA_value;
	_nB[_qp] = _nB_value;
	_nC[_qp] = _nC_value;
	_nD[_qp] = _nD_value;
	_nE[_qp] = _nE_value;
	_nF[_qp] = _nF_value;
	_nG[_qp] = _nG_value;
	_nH[_qp] = _nH_value;
	_nI[_qp] = _nI_value;
	_nJ[_qp] = _nJ_value;
	_nK[_qp] = _nK_value;

	
	_kA[_qp] = _kA_value * time_changer;
	_kB[_qp] = _kB_value * time_changer;
	_kC[_qp] = _kC_value * time_changer;
	_kD[_qp] = _kD_value * time_changer;
	_kE[_qp] = _kE_value * time_changer;
	_kF[_qp] = _kF_value * time_changer;
	_kG[_qp] = _kG_value * time_changer;
	_kH[_qp] = _kH_value * time_changer;
	_kI[_qp] = _kI_value * time_changer;
	_kJ[_qp] = _kJ_value * time_changer;
	_kK[_qp] = _kK_value * time_changer;
	_kL[_qp] = _kL_value * time_changer;
	
	_eps[_qp] = _eps_value;
	_f[_qp] = _f_value;
	_DelH[_qp] = _DelH_value;
	
	_kM[_qp] = _kM_value * time_changer;
	_kN[_qp] = _kN_value * time_changer;
	_kO[_qp] = _kO_value * time_changer;
	_kP[_qp] = _kP_value * time_changer;
	_kQ[_qp] = _kQ_value * time_changer;
	_kR[_qp] = _kR_value * time_changer;
	_kS[_qp] = _kS_value * time_changer;
	_kT[_qp] = _kT_value * time_changer;
	_kU[_qp] = _kU_value * time_changer;
	_kV[_qp] = _kV_value * time_changer;
	_kW[_qp] = _kW_value * time_changer;
	_kX[_qp] = _kX_value * time_changer;
	_kY[_qp] = _kY_value * time_changer;
}

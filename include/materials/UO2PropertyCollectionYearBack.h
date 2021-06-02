//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "Material.h"

/**
 * Stateful material class that defines a few properties.
 */
class UO2PropertyCollectionYearBack : public Material
{
public:
  static InputParameters validParams();

  UO2PropertyCollectionYearBack(const InputParameters & parameters);

protected:
  virtual void initQpStatefulProperties();
  virtual void computeQpProperties();

private:


  Real _UO22pValue;
  MaterialProperty<Real> & _Sat_UO22p;
  Real _UO2CO322mValue;
  MaterialProperty<Real> & _Sat_UO2CO322m;
  Real _UOH4Value;
  MaterialProperty<Real> & _Sat_UOH4;
  Real _Fe2pValue;
  MaterialProperty<Real> & _Sat_Fe2p;

  Real _aA_value;
  MaterialProperty<Real> & _aA;
  Real _aB_value;
  MaterialProperty<Real> & _aB;
  Real _aC_value;
  MaterialProperty<Real> & _aC;
  Real _aD_value;
  MaterialProperty<Real> & _aD;
  Real _aE_value;
  MaterialProperty<Real> & _aE;
  Real _aF_value;
  MaterialProperty<Real> & _aF;
  Real _aG_value;
  MaterialProperty<Real> & _aG;
  Real _aH_value;
  MaterialProperty<Real> & _aH;
  Real _aI_value;
  MaterialProperty<Real> & _aI;
  Real _aJ_value;
  MaterialProperty<Real> & _aJ;
  Real _aK_value;
  MaterialProperty<Real> & _aK;
          
  Real _EA_value;
  MaterialProperty<Real> & _EA;
  Real _EB_value;
  MaterialProperty<Real> & _EB;
  Real _EC_value;
  MaterialProperty<Real> & _EC;
  Real _ED_value;
  MaterialProperty<Real> & _ED;
  Real _EE_value;
  MaterialProperty<Real> & _EE;
  Real _EF_value;
  MaterialProperty<Real> & _EF;
  Real _EG_value;
  MaterialProperty<Real> & _EG;
  Real _EH_value;
  MaterialProperty<Real> & _EH;
  Real _EI_value;
  MaterialProperty<Real> & _EI;
  Real _EJ_value;
  MaterialProperty<Real> & _EJ;
  Real _EK_value;
  MaterialProperty<Real> & _EK;
          
  Real _nA_value;
  MaterialProperty<Real> & _nA;
  Real _nB_value;
  MaterialProperty<Real> & _nB;
  Real _nC_value;
  MaterialProperty<Real> & _nC;
  Real _nD_value;
  MaterialProperty<Real> & _nD;
  Real _nE_value;
  MaterialProperty<Real> & _nE;
  Real _nF_value;
  MaterialProperty<Real> & _nF;
  Real _nG_value;
  MaterialProperty<Real> & _nG;
  Real _nH_value;
  MaterialProperty<Real> & _nH;
  Real _nI_value;
  MaterialProperty<Real> & _nI;
  Real _nJ_value;
  MaterialProperty<Real> & _nJ;
  Real _nK_value;
  MaterialProperty<Real> & _nK;
          
  Real _kA_value;
  MaterialProperty<Real> & _kA;
  Real _kB_value;
  MaterialProperty<Real> & _kB;
  Real _kC_value;
  MaterialProperty<Real> & _kC;
  Real _kD_value;
  MaterialProperty<Real> & _kD;
  Real _kE_value;
  MaterialProperty<Real> & _kE;
  Real _kF_value;
  MaterialProperty<Real> & _kF;
  Real _kG_value;
  MaterialProperty<Real> & _kG;
  Real _kH_value;
  MaterialProperty<Real> & _kH;
  Real _kI_value;
  MaterialProperty<Real> & _kI;
  Real _kJ_value;
  MaterialProperty<Real> & _kJ;
  Real _kK_value;
  MaterialProperty<Real> & _kK;
  Real _kL_value;
  MaterialProperty<Real> & _kL;
          

  
  Real _eps_value;
  MaterialProperty<Real> & _eps;
  Real _f_value;
  MaterialProperty<Real> & _f;
  Real _DelH_value;
  MaterialProperty<Real> & _DelH;
  
  Real _kM_value;
  MaterialProperty<Real> & _kM;
  Real _kN_value;
  MaterialProperty<Real> & _kN;
  Real _kO_value;
  MaterialProperty<Real> & _kO;
  Real _kP_value;
  MaterialProperty<Real> & _kP;
  Real _kQ_value;
  MaterialProperty<Real> & _kQ;
  Real _kR_value;
  MaterialProperty<Real> & _kR;
  Real _kS_value;
  MaterialProperty<Real> & _kS;
  Real _kT_value;
  MaterialProperty<Real> & _kT;
  Real _kU_value;
  MaterialProperty<Real> & _kU;
  Real _kV_value;
  MaterialProperty<Real> & _kV;
  Real _kW_value;
  MaterialProperty<Real> & _kW;
  Real _kX_value;
  MaterialProperty<Real> & _kX;
  Real _kY_value;
  MaterialProperty<Real> & _kY;

  Real _kMB_value;
  MaterialProperty<Real> & _kMB;
  Real _kNB_value;
  MaterialProperty<Real> & _kNB;
  Real _kOB_value;
  MaterialProperty<Real> & _kOB;
  Real _kPB_value;
  MaterialProperty<Real> & _kPB;
  Real _kQB_value;
  MaterialProperty<Real> & _kQB;
  Real _kRB_value;
  MaterialProperty<Real> & _kRB;
  Real _kSB_value;
  MaterialProperty<Real> & _kSB;
  Real _kTB_value;
  MaterialProperty<Real> & _kTB;
  Real _kUB_value;
  MaterialProperty<Real> & _kUB;
  Real _kVB_value;
  MaterialProperty<Real> & _kVB;
  Real _kWB_value;
  MaterialProperty<Real> & _kWB;
  Real _kXB_value;
  MaterialProperty<Real> & _kXB;
  Real _kYB_value;
  MaterialProperty<Real> & _kYB;
};

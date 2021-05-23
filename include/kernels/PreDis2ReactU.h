/****************************************************************/
/*               DO NOT MODIFY THIS HEADER                      */
/* MOOSE - Multiphysics Object Oriented Simulation Environment  */
/*                                                              */
/*           (c) 2010 Battelle Energy Alliance, LLC             */
/*                   ALL RIGHTS RESERVED                        */
/*                                                              */
/*          Prepared by Battelle Energy Alliance, LLC           */
/*            Under Contract No. DE-AC07-05ID14517              */
/*            With the U. S. Department of Energy               */
/*                                                              */
/*            See COPYRIGHT for full restrictions               */
/****************************************************************/

#pragma once

#include "Kernel.h"

// Forward Declaration
class PreDis2ReactU;

template <>
InputParameters validParams<PreDis2ReactU>();

class PreDis2ReactU : public Kernel
{
public:
  PreDis2ReactU(const InputParameters & parameters);

protected:
  Real computeQpResidual() override;
  Real computeQpJacobian() override;
  Real computeQpOffDiagJacobian(unsigned int jvar) override;


  // The reaction coefficient
  const Real & _Reaction_rate;
  const Real & _Num;
  const Real & _Ea;
  const VariableValue & _T;
  const VariableValue & _v;
  unsigned int _T_id;
  unsigned int _v_id;
  const MaterialProperty<Real> & _Cs;
};

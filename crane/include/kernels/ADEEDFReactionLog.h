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

#include "ADKernel.h"

class ADEEDFReactionLog : public ADKernel
{
public:
  static InputParameters validParams();
  ADEEDFReactionLog(const InputParameters & parameters);

protected:
  virtual ADReal computeQpResidual();

  const ADMaterialProperty<Real> & _reaction_coeff;

  const ADVariableValue & _em;
  const ADVariableValue & _target;
  Real _coefficient;
};

#pragma once

#include "ADKernel.h"


/**
 * Adds contribution due to evaporation 
 **/
class SatCal : public ADKernel
{
public:
  static InputParameters validParams();

  SatCal(const InputParameters & parameters);

protected:
  virtual ADReal computeQpResidual();

  const ADVariableValue & _T;
  const ADVariableValue & _P;

  const Real _g;
  const Real _h;
  const Real _rho_w;
};


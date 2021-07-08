//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "ADIntegratedBC.h"

class ADHSEVar;

template <>
InputParameters validParams<ADHSEVar>();

/**
 * A FluxBC which is consistent with the boundary terms arising from
 * the Diffusion Kernel. The flux vector in this case is simply
 * grad(u) and the residual contribution is:
 *
 * \f$ F(u) = - \int_{\Gamma} \nabla u * \hat n * \phi d\Gamma \f$
 *
 * In contrast to e.g. VectorNeumannBC, the user does not provide a
 * specified value of the flux when using this class, instead the
 * residual contribution corresponding to the current value of grad(u)
 * is computed and accumulated into the residual vector.
 */
class ADHSEVar : public ADIntegratedBC
{
public:
  static InputParameters validParams();

  ADHSEVar(const InputParameters & parameters);

protected:
  virtual ADReal computeQpResidual();

  const Real & _F;
  const ADMaterialProperty<Real> & _eps;
  const Real & _kS;
  const Real & _aS;
  const ADVariableValue & _E;
  const Real & _R;
  const ADVariableValue & _T;
  const Real & _aS3;
  const Real & _ES12;
  const Real & _ES3;
  const Real & _Num;
  unsigned int _E_id;
  unsigned int _T_id; 

};

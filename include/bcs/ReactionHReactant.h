//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "IntegratedBC.h"

class ReactionHReactant;

template <>
InputParameters validParams<ReactionHReactant>();

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
class ReactionHReactant : public IntegratedBC
{
public:
  static InputParameters validParams();

  ReactionHReactant(const InputParameters & parameters);

protected:
  virtual Real computeQpResidual();
  virtual Real computeQpJacobian();
  virtual Real computeQpOffDiagJacobian(unsigned int jvar);

  const Real & _Num;
  const MaterialProperty<Real> & _eps;
  const MaterialProperty<Real> & _k1;
  const MaterialProperty<Real> & _DelH;
  const MaterialProperty<Real> & _Ecorr;
  const VariableValue & _T;
  const MaterialProperty<Real> & _a1;
  const MaterialProperty<Real> & _E1;
  const MaterialProperty<Real> & _f;
  unsigned _T_id; 

};

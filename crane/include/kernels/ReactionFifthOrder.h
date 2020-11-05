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

// Forward Declaration
class ReactionFifthOrder;

template <>
InputParameters validParams<ReactionFifthOrder>();

class ReactionFifthOrder : public ADKernel
{
public:
  ReactionFifthOrder(const InputParameters & parameters);

protected:
  virtual ADReal computeQpResidual() override;

  // MooseVariable & _coupled_var_A;
  // MooseVariable & _coupled_var_B;
  const VariableValue & _v;
  const VariableValue & _w;
  const VariableValue & _x;
  const VariableValue & _y;
  const VariableValue & _z;
  unsigned int _v_id;
  unsigned int _w_id;
  unsigned int _x_id;
  unsigned int _y_id;
  unsigned int _z_id;

  // The reaction coefficient
  const MaterialProperty<Real> & _reaction_coeff;
  Real _stoichiometric_coeff;

  bool _v_eq_u;
  bool _w_eq_u;
  bool _x_eq_u;
  bool _y_eq_u;
  bool _z_eq_u;
};

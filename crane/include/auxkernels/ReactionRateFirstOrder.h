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

#include "AuxKernel.h"

class ReactionRateFirstOrder;

template <>
InputParameters validParams<ReactionRateFirstOrder>();

class ReactionRateFirstOrder : public AuxKernel
{
public:
  ReactionRateFirstOrder(const InputParameters & parameters);

  virtual ~ReactionRateFirstOrder() {}
  virtual Real computeValue();

protected:


  const VariableValue & _v;
  const MaterialProperty<Real> & _reaction_coeff;
};

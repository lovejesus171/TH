//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "FilmVariable.h"

registerMooseObject("corrosionApp", FilmVariable);

template <>
InputParameters
validParams<FilmVariable>()
{
  InputParameters params = validParams<AuxKernel>();
  params.addRequiredParam<PostprocessorName>("pp","Film thickness postprocessor");

  return params;
}

FilmVariable::FilmVariable(const InputParameters & parameters)
  : AuxKernel(parameters),
   _pp(getPostprocessorValue("pp")),
   _current_elem(_assembly.elem())
{
}

/**
 * Auxiliary Kernels override computeValue() instead of computeQpResidual().  Aux Variables
 * are calculated either one per elemenet or one per node depending on whether we declare
 * them as "Elemental (Constant Monomial)" or "Nodal (First Lagrange)".  No changes to the
 * source are necessary to switch from one type or the other.
 */
Real
FilmVariable::computeValue()
{
	Real coordx = _current_elem->centroid()(0);
	return coordx - _pp;
}

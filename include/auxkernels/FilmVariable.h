//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "AuxKernel.h"
#include "Assembly.h" //Assembly
#include "MooseVariableFE.h" //_current_elem


// Forward Declarations
class FilmVariable;

template <>
InputParameters validParams<FilmVariable>();

/**
 * Coupled auxiliary value
 */
class FilmVariable : public AuxKernel
{
public:
  /**
   * Factory constructor, takes parameters so that all derived classes can be built using the same
   * constructor.
   */
  FilmVariable(const InputParameters & parameters);

protected:
  virtual Real computeValue() override;

    const Elem * const & _current_elem;
    const PostprocessorValue & _pp;

};


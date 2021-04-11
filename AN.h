//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "GeneralPostprocessor.h"

class AN;

template <>
InputParameters validParams<AN>();

/**
 * Computes the difference between two postprocessors
 *
 * result = value1 - value2
 */
class AN : public GeneralPostprocessor
{
public:
  static InputParameters validParams();

  AN(const InputParameters & parameters);

  virtual void initialize() override;
  virtual void execute() override;
  virtual PostprocessorValue getValue() override;

protected:
  const PostprocessorValue & _C6;
  const PostprocessorValue & _C9;
  const PostprocessorValue & _C1;
  const PostprocessorValue & _T;
  const PostprocessorValue & _Ecorr;

  const Real & _Porosity;

  const Real & _nA;
  const Real & _kA;
  const Real & _kB;
  const Real & _EA;

  const Real & _nS;
  const Real & _kS;
  const Real & _aS;
  const Real & _aS3;
  const Real & _ES12;
  const Real & _ES3;


};


//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html
#include "corrosionTestApp.h"
#include "corrosionApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "MooseSyntax.h"
#include "ModulesApp.h"

InputParameters
corrosionTestApp::validParams()
{
  InputParameters params = corrosionApp::validParams();
  return params;
}

corrosionTestApp::corrosionTestApp(InputParameters parameters) : MooseApp(parameters)
{
  corrosionTestApp::registerAll(
      _factory, _action_factory, _syntax, getParam<bool>("allow_test_objects"));
}

corrosionTestApp::~corrosionTestApp() {}

void
corrosionTestApp::registerAll(Factory & f, ActionFactory & af, Syntax & s, bool use_test_objs)
{
  corrosionApp::registerAll(f, af, s);
  if (use_test_objs)
  {
    Registry::registerObjectsTo(f, {"corrosionTestApp"});
    Registry::registerActionsTo(af, {"corrosionTestApp"});
  }
}

void
corrosionTestApp::registerApps()
{
  registerApp(corrosionApp);
  registerApp(corrosionTestApp);
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
// External entry point for dynamic application loading
extern "C" void
corrosionTestApp__registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  corrosionTestApp::registerAll(f, af, s);
}
extern "C" void
corrosionTestApp__registerApps()
{
  corrosionTestApp::registerApps();
}

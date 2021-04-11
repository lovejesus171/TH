#include "corrosionApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "ModulesApp.h"
#include "MooseSyntax.h"
#include "CraneApp.h"

InputParameters
corrosionApp::validParams()
{
  InputParameters params = MooseApp::validParams();

  // Do not use legacy DirichletBC, that is, set DirichletBC default for preset = true
  params.set<bool>("use_legacy_dirichlet_bc") = false;
  params.set<bool>("use_legacy_material_output") - false;

  return params;
}

corrosionApp::corrosionApp(InputParameters parameters) : MooseApp(parameters)
{
  corrosionApp::registerAll(_factory, _action_factory, _syntax);
}

corrosionApp::~corrosionApp() {}

void
corrosionApp::registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  ModulesApp::registerAll(f, af, s);
  CraneApp::registerAll(f, af, s); 
  Registry::registerObjectsTo(f, {"corrosionApp"});
  Registry::registerActionsTo(af, {"corrosionApp"});

  /* register custom execute flags, action syntax, etc. here */
}

void
corrosionApp::registerApps()
{
  registerApp(corrosionApp);
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
extern "C" void
corrosionApp__registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  corrosionApp::registerAll(f, af, s);
}
extern "C" void
corrosionApp__registerApps()
{
  corrosionApp::registerApps();
}

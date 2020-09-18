#include "ReactionFourthOrder.h"

// MOOSE includes
#include "MooseVariable.h"

registerMooseObject("CraneApp", ReactionFourthOrder);

template <>
InputParameters
validParams<ReactionFourthOrder>()
{
  InputParameters params = ADKernel::validParams();
  params.addRequiredCoupledVar("v", "The first variable that is reacting.");
  params.addRequiredCoupledVar("w", "The second variable that is reacting.");
  params.addRequiredCoupledVar("x", "The third variable that is reacting.");
  params.addRequiredCoupledVar("y", "The fourth variable that is reacting.");
  params.addRequiredParam<std::string>("reaction", "The full reaction equation.");
  params.addRequiredParam<Real>("coefficient", "The stoichiometric coeffient.");
  params.addParam<bool>("_v_eq_u", false, "Whether or not v and u are the same variable.");
  params.addParam<bool>("_w_eq_u", false, "Whether or not w and u are the same variable.");
  params.addParam<bool>("_x_eq_u", false, "Whether or not x and u are the same variable.");
  params.addParam<bool>("_y_eq_u", false, "Whether or not y and u are the same variable.");
  params.addParam<std::string>(
      "number",
      "",
      "The reaction number. Optional, just for material property naming purposes. If a single "
      "reaction has multiple different rate coefficients (frequently the case when multiple "
      "species are lumped together to simplify a reaction network), this will prevent the same "
      "material property from being declared multiple times.");
  return params;
}

ReactionFourthOrder::ReactionFourthOrder(const InputParameters & parameters)
  : ADKernel(parameters),
    _v(coupledValue("v")),
    _w(coupledValue("w")),
    _x(coupledValue("x")),
    _y(coupledValue("y")),
    _v_id(coupled("v")),
    _w_id(coupled("w")),
    _x_id(coupled("x")),
    _y_id(coupled("y")),
    _reaction_coeff(getMaterialProperty<Real>("k" + getParam<std::string>("number") + "_" +
                                              getParam<std::string>("reaction"))),
    _stoichiometric_coeff(getParam<Real>("coefficient")),
    _v_eq_u(getParam<bool>("_v_eq_u")),
    _w_eq_u(getParam<bool>("_w_eq_u")),
    _x_eq_u(getParam<bool>("_x_eq_u")),
    _y_eq_u(getParam<bool>("_y_eq_u"))
{
}

ADReal
ReactionFourthOrder::computeQpResidual()
{
  return -_test[_i][_qp] * _stoichiometric_coeff * _reaction_coeff[_qp] * _v[_qp] * _w[_qp] *
         _x[_qp]*_y[_qp];
}


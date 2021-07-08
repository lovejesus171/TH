//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "SulfideFilm.h"
#include "algorithm"

registerMooseObject("MooseApp", SulfideFilm);

InputParameters
SulfideFilm::validParams()
{
  InputParameters params = ActivateElementsUserObjectBase::validParams();
  params.addRequiredCoupledVar("CoupledVar","Cu2S");
  params.addRequiredParam<Real>("activate_value", "The value above which to activate the element");
  
  params.addParam<MooseEnum>("activate_type",
                             MooseEnum("below equal above", "above"),
                             "Activate element when below or above the activate_value");
  return params;
}

SulfideFilm::SulfideFilm(const InputParameters & parameters)
  : ActivateElementsUserObjectBase(parameters),
   _CoupledVar(coupledValue("CoupledVar")),
    _activate_value(
        declareRestartableData<Real>("activate_value", getParam<Real>("activate_value"))),
    _activate_type(getParam<MooseEnum>("activate_type").getEnum<ActivateType>())
{
}

bool
SulfideFilm::isElementActivated()
{
  bool is_activated = false;
  Real avg_val = 0.0;

  for (unsigned int qp = 0; qp < _qrule->n_points(); ++qp)
  {
     avg_val += _CoupledVar[qp];
  }
     avg_val /= _qrule->n_points();
//    max_val = std::max(max_val,_CoupledVar[qp]);
//    max_val += _coupled_var[qp];
//   max_val = _CoupledMat[qp];
//    std::cout << "Max: " << max_val << std::endl;
//    std::cout << "Fuck you this is the coupled variable: " << _coupuled_var[qp] << std::endl;

  switch (_activate_type)
  {
    case ActivateType::BELOW:
      is_activated = (avg_val < _activate_value);
      break;

    case ActivateType::EQUAL:
      is_activated = MooseUtils::absoluteFuzzyEqual(avg_val - _activate_value, 0.0);
      break;

    case ActivateType::ABOVE:
      is_activated = (avg_val > _activate_value);
      break;
  }

  return is_activated;
}

#include "FunctionSource.h"
#include "MooseVariable.h"
#include "Function.h"

registerMooseObject("corrosionApp",FunctionSource);

template<>
InputParameters
validParams<FunctionSource>()
{
  InputParameters params = validParams<Kernel>();
  params.addClassDescription("Compute the source term of chemical reactions.");
  params.addParam<FunctionName>("Function_Name",0,"Source term input as mol/m^3 unit with geometry dependent");

  return params;
}

FunctionSource::FunctionSource(const InputParameters & parameters)
  : Kernel(parameters),
    _S(getFunction("Function_Name"))
{
}

Real
FunctionSource::computeQpResidual()
{
//        printf("this is the function source of H2O2 \n");
	return -_test[_i][_qp] * _S.value(_t,_q_point[_qp]);
}

#include "Kernel.h"

class FunctionSource;

template <>
InputParameters validParams<FunctionSource>();

class FunctionSource : public Kernel
{
public:
 FunctionSource(const InputParameters & parameters);

protected:
 virtual Real computeQpResidual();

 const Function & _S;
};

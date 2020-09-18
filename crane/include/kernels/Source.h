#include "Kernel.h"

class Source;

template <>
InputParameters validParams<Source>();

class Source : public Kernel
{
public:
 Source(const InputParameters & parameters);

protected:
 virtual Real computeQpResidual();

 Real _S;
};

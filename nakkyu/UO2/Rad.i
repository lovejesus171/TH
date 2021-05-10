[Mesh]
  file = 'UO2.msh'
  construct_side_list_from_node_list = true
[]


[Variables]
  # Name of chemical species
  [./H2O2]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
[]


[Functions]
  [H2O2_produce]
    type = ParsedFunction
    value = '(0.99883 - 11833.90869 * x)^(-1/-0.13308)'
  []
[]

[Kernels]
# dCi/dt
  [./dH2O2_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = H2O2
  [../]



# Diffusion terms
#  [./DgradH2O2]
#    block = 'Alpha Solution'
#    type = CoefDiffusion
#    coef = 1.9E-9 #[m2/s], to be added
#    variable = H2O2
#  [../]

## Radiolysis source
# H2O2 production
  [./H2O2_Radiolysis_product]
    block = 'Alpha'
    type = FunctionSource
    variable = H2O2
    Function_Name = H2O2_produce
  [../]



[]



[Executioner]
  type = Transient
  start_time = 0 #[hr]
  end_time = 1750 #[hr]
  solve_type = 'PJFNK'
#  l_abs_tol = 1e-12
#  l_tol = 1e-7 #default = 1e-5
#  nl_abs_tol = 1e-12
  nl_rel_tol = 1e-1 #default = 1e-7
  l_max_its = 10
  nl_max_its = 30
  dtmax = 100

  automatic_scaling = true
  compute_scaling_once = false
 

  [./TimeStepper]
    type = IterationAdaptiveDT
    cutback_factor = 0.99
    dt = 1e-3
    growth_factor = 1.01
  [../]
[]

[Preconditioning]
  [./smp]
    type = SMP
    full = true
  [../]
[]

[Outputs]
  exodus = true
[]

[Mesh]
  type = GeneratedMesh
  dim = 2
  xmin = 0
  xmax = 10
  ymin = 0
  ymax = 10
  nx = 15
  ny = 15
[]

[Variables]
  # Name of chemical species
  [./A]
    order = FIRST
    initial_condition = 2
  [../]
  [./B]
    order = FIRST
    initial_condition = 1
  [../]
  [./C]
    order = FIRST
    initial_condition = 0.5
  [../]
  [./D]
    order = FIRST
    initial_condition = 0
  [../]
  [./F]
    order = FIRST
    initial_condition = 0
  [../]
[]



[Kernels]
  # dCi/dt
  [./dA_dt]
    block = 0
    type = TimeDerivative
    variable = A
  [../]
  [./dB_dt]
    block = 0
    type = TimeDerivative
    variable = B
  [../]
  [./dC_dt]
    block = 0
    type = TimeDerivative
    variable = C
  [../]
  [./dD_dt]
    block = 0
    type = TimeDerivative
    variable = D
  [../]
  [./dF_dt]
    block = 0
    type = TimeDerivative
    variable = F
  [../]
[]

[ChemicalReactions]
 [./Network]
   block = 0
   species = 'A B C D F'
   reaction_coefficient_format = 'rate'
   track_rates = True
   reactions = 'A + A + A + B -> B : 0.01
                B + C -> D : 0.015
                A + B + C -> D + F : 0.01 '
#                A + A + B + B -> D + D + D : 0.005
#                B + B + C + C -> F + F + A : 0.001
#                A + B + C + D -> F + F + F : 0.0007
 [../]
[]


[Executioner]
  type = Transient
  start_time = 0
  end_time = 1000
  dt = 0.1
  solve_type = newton
  scheme = crank-nicolson
 
  automatic_scaling = true

  petsc_options_iname = '-pc_type -pc_hypre_type'
  petsc_options_value = 'hypre boomeramg'

[./TimeStepper]
 type = IterationAdaptiveDT
 cutback_factor = 0.9
 dt = 0.1
 growth_factor = 1.1
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

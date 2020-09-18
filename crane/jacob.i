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
    initial_condition = 4.5
  [../]
  [./B]
    order = FIRST
    initial_condition = 4
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
[]

[ChemicalReactions]
 [./Network]
   block = 0
   species = 'A B'
   reaction_coefficient_format = 'rate'
   track_rates = True
   reactions = 'A + A + A + A  -> B + B  : 1E-2'
 [../]
[]


[Executioner]
  type = Transient
  start_time = 0
  end_time = 100
  solve_type = NEWTON
  dt = 0.1
#  [./TimeStepper]
#    type = IterationAdaptiveDT
#    cutback_factor = 0.9
#    dt = 0.1
#    growth_factor = .12
#  [../]
[]



[Outputs]
  exodus = true
[]

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
    initial_condition = 0
  [../]
  [./B]
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
  [./A_source]
    block = 0
    type = Source
    variable = A
    Source = 5
  [../]
  [./B_source]
    block = 0
    type = Source
    variable = B
    Source = 10
  [../]
[]



[Executioner]
  type = Transient
  start_time = 0
  end_time = 100
  solve_type = NEWTON
  dt = 10
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

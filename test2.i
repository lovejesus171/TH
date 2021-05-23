[Mesh]
  type = GeneratedMesh
  dim = 1
  xmin = 0
  xmax = 10
  nx = 10
[]

[Variables]
  # Name of chemical species
  [./A]
    order = FIRST
    initial_condition = 1
  [../]
  [./B]
    order = FIRST
    initial_condition = 1
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
  #Diffusion terms
  [./DgradA]
    block = 0
    type = CoefDiffusion
    coef = 5e-9
    variable = A
  [../]
  [./DgradB]
    block = 0
    type = CoefDiffusion
    coef = 5e-9
    variable = B
  [../]
[]



[BCs]
  [./right_chemical]
    type = NeumannBC
    variable = A
    boundary = left
    value = 0.01
  [../]
#  [./left_chemical]
#    type = NeumannBC
#    variable = A
#    boundary = left
#    value = 0.01
#  [../]
[]

[Executioner]
  type = Transient
  start_time = 0
  end_time = 50
  solve_type = 'NEWTON'
  dt = 0.1
  [./TimeStepper]
    type = IterationAdaptiveDT
    cutback_factor = 0.9
    dt = 0.1
    growth_factor = 1.2
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

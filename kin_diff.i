[Mesh]
  type = GeneratedMesh
  dim = 2
  xmin = 0
  xmax = 10
  ymin = 0
  ymax = 10
  nx = 10
  ny = 10
[]

[Variables]
  # Name of chemical species
  [./H2S]
    order = FIRST
    initial_condition = 100 #uM
  [../]
  [./H2O2]
    order = FIRST
    initial_condition = 1200 #uM
  [../]
  [./SO4]
    order = FIRST
    initial_condition = 0
  [../]
[]



[Kernels]
  # dCi/dt
  [./dA_dt]
    block = 0
    type = TimeDerivative
    variable = H2S
  [../]
  [./dB_dt]
    block = 0
    type = TimeDerivative
    variable = H2O2
  [../]
  [./dC_dt]
    block = 0
    type = TimeDerivative
    variable = SO4
  [../]
[]

[ChemicalReactions]
 [./Network]
   block = 0
   species = 'H2S SO4'
   reaction_coefficient_format = 'rate'
   track_rates = True
   reactions = 'H2S -> SO4 : 0.036' #1/min
 [../]
[]


[Executioner]
  type = Transient
  start_time = 0
  end_time = 500
  solve_type = NEWTON
  dt = 0.1
#  [./TimeStepper]
#    type = IterationAdaptiveDT
#    cutback_factor = 0.9
#    dt = 0.1
#    growth_factor = 1.3
#  [../]
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

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
    initial_condition = 1000
  [../]
  [./B]
    order = FIRST
    initial_condition = 1000
  [../]
  [./C]
    order = FIRST
    initial_condition = 1000
  [../]
  [./D]
    order = FIRST
    initial_condition = 1000
  [../]
  [./E]
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
  [./dE_dt]
    block = 0
    type = TimeDerivative
    variable = E
  [../]
[]

[ChemicalReactions]
 [./Network]
   block = 0
   species = 'A B C D E'
   reaction_coefficient_format = 'rate'
   track_rates = True
   reactions = 'A + B + C  -> E : 0.3'
 [../]
[]


[Executioner]
  type = Transient
  start_time = 0
  end_time = 10
  solve_type = NEWTON
  scheme = crank-nicolson
  dt = 0.1
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

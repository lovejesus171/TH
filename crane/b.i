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
    initial_condition = 1
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
   reactions = 'A + A + B -> C : 0.01
                B + C -> D : 0.015
                A + B + C -> D + E : 0.01
                A + A + B + B -> D + D + D  : 0.005
                A + B + C + D -> E + E + E : 0.01'
 [../]
[]


[Executioner]
  type = Transient
  start_time = 0
  end_time = 1000
  solve_type = NEWTON
  dt = 0.1
 [./TimeStepper]
   type = IterationAdaptiveDT
   cuback_factor = 0.9
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

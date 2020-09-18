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
  [./C]
    order = FIRST
    initial_condition = 3.5
  [../]
  [./D]
    order = FIRST
    initial_condition = 2.5
  [../]
  [./E]
    order = FIRST
    initial_condition = 2
  [../]
  [./F]
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
  [./dF_dt]
    block = 0
    type = TimeDerivative
    variable = F
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
    coef = 2e-9
    variable = B
  [../]
  [./DgradC]
    block = 0
    type = CoefDiffusion
    coef = 4e-9
    variable = C
  [../]
  [./DgradD]
    block = 0
    type = CoefDiffusion
    coef = 1e-9
    variable = D
  [../]
  [./DgradE]
    block = 0
    type = CoefDiffusion
    coef = 2e-9
    variable = E
  [../]
  [./DgradF]
    block = 0
    type = CoefDiffusion
    coef = 7e-9
    variable = F
  [../]
  #Source Terms
  [./Source_A]
    block = 0
    type = Source
    variable = A
    Source = 0.1
  [../]
  [./Source_B]
    block = 0
    type = Source
    variable = B
    Source = 0.3
  [../]
[]

[ChemicalReactions]
 [./Network]
   block = 0
   species = 'A B C D E F'
   reaction_coefficient_format = 'rate'
   track_rates = True
   reactions = 'A + B  -> C + D  : 0.1
                C + C + D + D -> E + F : 1E-2
                C + D + E + F -> A + B : 0.3
                B + D + E -> F : 0.005                   
                A + B + C + D -> E : 0.5'
 [../]
[]

[BCs]
  [./right]
    type = NeumannBC
    variable = B
    boundary = right
    value = 0.01
  [../]
  [./left]
    type = NeumannBC
    variable = E
    boundary = left
    value = 0.01
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

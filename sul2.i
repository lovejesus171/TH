[Mesh]
  file = 'only_copper.msh'
[]

[Variables]
  # Name of chemical species, unit: mol/m3
  [./HS-]
    order = FIRST
  [../]
  [./Cu]
    order = FIRST
  [../]
  [./Cu2S]
    order = FIRST
    initial_condition = 0
  [../]
[]

[ICs]
  [./Copper_HS-]
    type = ConstantIC
    variable = HS-
    block = 'Copper'
    value = 0
  [../]
  [./Copper_Cu]
    type = ConstantIC
    variable = Cu
    block = 'Copper'
    value = 10
  [../]
[]


[Kernels]
  # dCi/dt
  [./dHS-_Cu_dt]
    block = 'Copper'
    type = TimeDerivative
    variable = HS-
  [../]
  [./dCu_Cu_dt]
    block = 'Copper'
    type = TimeDerivative
    variable = Cu
  [../]
#Diffusion terms
  [./DgradHS-_Cu]
    block = 'Copper'
    type = CoefDiffusion
    coef = 5.87E-12
    variable = HS-
  [../]
  [./DgradCu_Cu]
    block = 'Copper'
    type = CoefDiffusion
    coef = 5.87E-12
    variable = Cu
  [../]
[]

[ChemicalReactions]
 [./Network]
   block = 'Copper'
   species = 'Cu Cu2S HS-'
   reaction_coefficient_format = 'rate'
   track_rates = True
   reactions = 'Cu + Cu + HS-  -> Cu2S  : 100000'
 [../]
[]

[BCs]
  [./Cu_bottom]
    type = NeumannBC
    variable = HS-
    boundary = Copper_bottom
    value = 0
  [../]
  [./Cu_side]
    type = NeumannBC
    variable = HS-
    boundary = Copper_sides
    value = 0
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

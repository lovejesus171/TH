[Mesh]
  file = '2D_Rotation.msh'
[]

[Variables]
  # Name of chemical species, unit: mol/m3
  [./HS-]
    order = FIRST
  [../]
[]

[ICs]
  [./Copper_HS-]
    type = ConstantIC
    variable = HS-
    block = 'solution_1'
    value = 1
  [../]
  [./Copper_Cu]
    type = ConstantIC
    variable = HS-
    block = 'solution_2'
    value = 1
  [../]
[]

[Kernels]
  # dCi/dt
  [./dHS-_dt1]
    block = 'solution_1'
    type = TimeDerivative
    variable = HS-
  [../]
  [./dHS-_dt2]
    block = 'solution_2'
    type = TimeDerivative
    variable = HS-
  [../]
#Diffusion terms
  [./DgradHS-_Cu]
    block = 'solution_1'
    type = CoefDiffusion
    coef = 1.41E-9
    variable = HS-
  [../]
  [./DgradCu_Cu]
    block = 'solution_2'
    type = CoefDiffusion
    coef = 1.41E-9
    variable = HS-
  [../]
[]

#[ChemicalReactions]
# [./Network]
#   block = 'solution_2'
#   species = 'Cu2S HS-'
#   reaction_coefficient_format = 'rate'
#   track_rates = True
#   reactions = 'HS-  -> Cu2S  : 100000'
# [../]
#[]

[BCs]
  [./Cu_top]
    type = DirichletBC
    variable = HS-
    boundary = copper_top
    value = 0
  [../]
[]

[Executioner]
  type = Transient
  start_time = 0
  end_time = 1209600
  solve_type = NEWTON
  dt = 0.1
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

[Postprocessors]
  [./Flux_of_HS-]
    block = 'solution_1'
    type = SideFluxIntegral
    variable = HS-
    diffusivity = 1.41E-9
    boundary = copper_top
  [../]
[]


[Outputs]
  exodus = true
[]

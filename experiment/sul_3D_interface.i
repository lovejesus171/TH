[Mesh]
  file = '3D_Real.msh'
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
    block = 'Solution'
    value = 1
  [../]
[]

[Kernels]
  # dCi/dt
  [./dHS-_dt1]
    block = 'Solution'
    type = TimeDerivative
    variable = HS-
  [../]
#Diffusion terms
  [./DgradHS-]
    block = 'Solution'
    type = CoefDiffusion
    coef = 1.41E-9
    variable = HS-
  [../]
[]

#[ChemicalReactions]
# [./Network]
#   block = 'Solution'
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
    boundary = Copper
    value = 0
  [../]
[]

[Executioner]
  type = Transient
  start_time = 0
  end_time = 1209600
  solve_type = NEWTON
  dtmax = 10
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
    type =ADSideFluxIntegral 
    variable = HS-
    diffusivity = 1.41E-9
    boundary = Copper
  [../]
[]


[Outputs]
  exodus = true
[]

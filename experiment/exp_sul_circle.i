[Mesh]
  file = '3D_Real_Circle_Copper.msh'
[]

[Variables]
  # Name of chemical species, unit: mol/m3
  [./HS]
    order = FIRST
  [../]
  [./Cu2S]
    order = FIRST
    initial_condition = 0
  [../]
[]

[ICs]
  [./Copper_HS]
    type = ConstantIC
    variable = HS
    block = 'Solution'
    value = 1
  [../]
[]

[Kernels]
  # dCi/dt
  [./dHS_dt1]
    block = 'Solution'
    type = TimeDerivative
    variable = HS
  [../]
  #Diffusion terms
  [./DgradHS]
    block = 'Solution'
    type = CoefDiffusion
    coef = 1.41E-9
    variable = HS
  [../]
[]

[ChemicalReactions]
 [./Network]
   block = 'Solution'
   species = 'Cu2S HS'
   track_rates = True
   reactions = 'HS  -> Cu2S  : 1E-4'
 [../]
[]

[BCs]
  [./Cu_top]
    type = DirichletBC
    variable = HS
    boundary = Copper_top
    value = 0
  [../]
[]

[Executioner]
  type = Transient
  start_time = 0
  end_time = 1209600
  solve_type = NEWTON
  dtmax = 10000
  l_abs_tol = 1e-20
  nl_abs_tol = 1e-20
  [./TimeStepper]
    type = IterationAdaptiveDT
    cutback_factor = 0.9
    dt = 1
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
  [./Flux_of_HS]
    type = SideFluxIntegral 
    variable = HS
    diffusivity = 1.41E-9
    boundary = Copper_top
  [../]
[]


[Outputs]
  exodus = true
[]

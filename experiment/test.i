[Mesh]
  file = '3D_Real_Circle_Copper.msh'
[]

[Variables]
  # Name of chemical species, unit: mol/m3
  [./HS]
    order = FIRST
    initial_condition = 1
  [../]
  [./Cu2S]
    order = FIRST
    initial_condition = 0
  [../]
[]


[Kernels]
  # dCi/dt
  [./dHS_dt1]
    type = TimeDerivative
    variable = HS
  [../]
  #Diffusion terms
  [./DgradHS]
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

#[BCs]
#  [./Cu_top]
#    type = DirichletBC
#    variable = HS
#    boundary = Copper_top
#    value = 0
#  [../]
#[]

[Executioner]
  type = Transient
  start_time = 0
  end_time = 50
  solve_type = NEWTON
  dtmax = 10
  l_abs_tol = 1e-20
  nl_abs_tol = 1e-20
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


[Outputs]
  exodus = true
[]

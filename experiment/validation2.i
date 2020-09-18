[Mesh]
  file = '2D_Solution.msh'
[]

[Variables]
  # Name of chemical species, unit: mol/m3
  [./HS-]
    order = FIRST
  [../]
  [./Cu2S]
    order = FIRST
  [../]
[]

[ICs]
  [./Copper_HS-]
    type = ConstantIC
    variable = HS-
    value = 1
  [../]
[]

[Kernels]
  # dCi/dt
  [./dHS-_dt1]
    type = TimeDerivative
    variable = HS-
  [../]
#Diffusion terms
  [./DgradHS-]
    type = CoefDiffusion
    coef = 1.387584E-4
    variable = HS-
  [../]
[]

[ChemicalReactions]
 [./Network]
   species = 'Cu2S HS-'
   reaction_coefficient_format = 'rate'
   track_rates = True
   reactions = 'HS- + HS- + HS- + HS-  -> Cu2S + Cu2S  : 1E-4'
 [../]
[]

[BCs]
  [./Cu_top]
    type = DirichletBC
    variable = HS-
    boundary = Bentonite
    value = 0
  [../]
  [./Bentonite]
    type = DirichletBC
    variable = HS-
    boundary = Rock
    value = 1
  [../]
[]

[Executioner]
  type = Transient
  start_time = 0
  end_time = 10000
  solve_type = NEWTON
#  steady_state_detection = true
#  steady_state_tolerance = 1e-9
  l_abs_tol = 1e-10
  nl_abs_tol = 1e-10
  l_max_its = 1000
  l_tol = 1e-8
#  nl_abs_step_tol = 1e-50
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

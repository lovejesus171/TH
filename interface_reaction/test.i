[Mesh]
  type = GeneratedMesh
  dim = 1
  xmin = 0
  xmax = 1
  nx = 30
[]

[Variables]
  # Name of chemical species
  [./A]
   order = FIRST
   initial_conditions = 1
  [../]
  [./B]
   order = FIRST
   initial_conditions = 1
  [../]
  [./C]
   order = FIRST
   initial_conditions = 1
  [../]
[]


[Kernels]
# dCi/dt
  [./dA_dt]
    type = TimeDerivative
    variable = A
  [../]
  [./dB_dt]
    type = TimeDerivative
    variable = B
  [../]
  [./dC_dt]
    type = TimeDerivative
    variable = C
  [../]

  [./DA]
    type = CoefDiffusion
    coef = 1e-9 
    variable = A
  [../]
  [./DB]
    type = CoefDiffusion
    coef = 1e-9 
    variable = B
  [../]
  [./DC]
    type = CoefDiffusion
    coef = 1e-9 
    variable = C
  [../]
[]

[ChemicalReactions]
 [./Network]
   block = 'Solution_domain'
   species = 'A B C'
   track_rates = False
   equation_constants = 'Ea R T_Re'
   equation_values = '0 8.314 298.15'
#   equation_variables = 'T'

   reactions = 'Cu+ + HS- -> Cu : {1E-1}'
 []
[]


[BCs]
  [./left_bc_A]
    type = DirichletBC
    boundary = left
    variable = A
    value = 0.1E3 
  [../]
  [./left_bc_B]
    type = DirichletBC
    boundary = left
    variable = B
    value = 0.1E3 
  [../]
  [./left_bc_C]
    type = DirichletBC
    boundary = left
    variable = C
    value = 0 
  [../]



  [./right_bc_A]
    type = DirichletBC
    boundary = right
    variable = A
    value = 1
  [../]
  [./right_bc_B]
    type = DirichletBC
    boundary = right
    variable = B
    value = 1 
  [../]
  [./right_bc_C]
    type = DirichletBC
    boundary = right
    variable = C
    value = 1
  [../]

[]

[Executioner]
  type = Transient
  start_time = 0 #[s]
  end_time = 100 #
  solve_type = 'PJFNK'
#  l_abs_tol = 1e-3 #1e-11 for HS- + H2O2
#  l_tol = 1e-5 #default = 1e-5
#  nl_abs_tol = 1e-2 #1e-11 for HS- + H2O2
#  l_rel_tol = 1e-1
  nl_rel_tol = 1e-4  #default = 1e-7
  l_max_its = 10
  nl_max_its = 10
  dtmax = 0.1
#  dt = 0.5

  automatic_scaling = true
  compute_scaling_once = false

#  steady_state_detection = true
#  steady_state_tolerance = 3e-6
  [./TimeStepper]
    type = IterationAdaptiveDT
    cutback_factor = 0.99
    dt = 1e-5
    growth_factor = 1.01
  [../]
  
#  [./Adaptivity]
#    refine_fraction = 0.9
#    max_h_level = 7
#    cycles_per_step = 5
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

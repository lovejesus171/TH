[Mesh]
  type = GeneratedMesh
  dim = 1
  xmin = 0
  xmax = 1E-3
  nx = 1000
[]

[Variables]
  # Name of chemical species
  [./HS-]
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./Cu2S]
   order = FIRST
   initial_condition = 0
  [../]
  [./OH-]
   order = FIRST
   initial_condition = 1E-4
  [../]
[]


[Kernels]
# dCi/dt
  [./dA_dt]
    type = TimeDerivative
    variable = HS-
  [../]
  [./dB_dt]
    type = TimeDerivative
    variable = Cu2S
  [../]
  [./dC_dt]
    type = TimeDerivative
    variable = OH-
  [../]

  [./DA]
    type = CoefDiffusion
    coef = 3600e-9 
    variable = HS-
  [../]
  [./DB]
    type = CoefDiffusion
    coef = 3600e-9 
    variable = Cu2S
  [../]
  [./DC]
    type = CoefDiffusion
    coef = 3600e-9 
    variable = OH-
  [../]
[]

#[ChemicalReactions]
# [./Network]
#   block = 'Solution_domain'
#   species = 'A B C'
#   track_rates = False
#   equation_constants = 'Ea R T_Re'
#   equation_values = '0 8.314 298.15'
#   equation_variables = 'T'

#   reactions = 'Cu+ + HS- -> Cu : {1E-1}'
# []
#[]


[BCs]
#  [./left_bc_A]
#    type = ES2
#    boundary = left
#    variable = HS-
#    Charge_number = -1
#    Kinetic = 2160000e-4
#    AlphaS = 0.5
#    Corrosion_potential = -0.90
#    R = 8.314
#    T = 298.15
#    AlphaS3 = 0.5
#    Standard_potential2 = -0.78
#    Standard_potential3 = -0.78
#  [../]

  [./left_bc_A]
    type = DirichletBC
    boundary = left
    variable = HS-
    value = 0
  [../]

 
  [./right_bc_A]
    type = DirichletBC
    boundary = right
    variable = HS-
    value = 1
  [../]
  [./right_bc_B]
    type = DirichletBC
    boundary = right
    variable = OH-
    value = 0
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
  nl_rel_tol = 1e-1  #default = 1e-7
  l_max_its = 10
  nl_max_its = 10
  dtmax = 0.1
#  dt = 0.1

  automatic_scaling = true
  compute_scaling_once = false

#  steady_state_detection = true
#  steady_state_tolerance = 3e-6
  [./TimeStepper]
    type = IterationAdaptiveDT
    cutback_factor = 0.99
    dt = 1e-3
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

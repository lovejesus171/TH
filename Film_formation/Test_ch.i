[Mesh]
  file = '2D_Sol.msh'
[]

[Variables]
  # Name of chemical species
  [./Cu]
   block = 'Solution_domain'
   order = FIRST
  [../]
  [./Cu+]
   block = 'Solution_domain'
   order = FIRST
  [../]
  [./HS-]
   block = 'Solution_domain'
   order =FIRST
  [../]
  [./phi]
    block = 'Solution_domain'
    order = FIRST
    initial_condition = 0
  [../]
[]

[ICs]
  [./Solution_block_Cu]
    type = ConstantIC
    block = 'Solution_domain'
    variable = Cu
    value = 0
  [../]
  [./Solution_block_Cu+]
    type = ConstantIC
    block = 'Solution_domain'
    variable = Cu+
    value = 0
  [../]
 [./Solution_block_HS-]
    type = ConstantIC
    block = 'Solution_domain'
    variable = HS-
    value = 0
  [../]

[]


[Kernels]
# dCi/dt
  [./dCu_dt]
    block = 'Solution_domain'
    type = TimeDerivative
    variable = Cu
  [../]
  [./dCu+_dt]
    block = 'Solution_domain'
    type = TimeDerivative
    variable = Cu+
  [../]
  [./dHS-_dt]
    block = 'Solution_domain'
    type = TimeDerivative
    variable = HS-
  [../]

  [./DgradCu]
    block = 'Solution_domain'
    type = CoefDiffusion
    coef = 1e-9 
    variable = Cu
  [../]
  [./DgradCu+]
    block = 'Solution_domain'
    type = CoefDiffusion
    coef = 1e-9
    variable = Cu+
  [../]
 
  [./DgradHS-_C]
    block = 'Solution_domain'
    type = CoefDiffusion
    coef = 1e-9
    variable = HS-
  [../]

  [./Cal_Potential_dist]
    block = 'Solution_domain'
    type = SEP2
    variable = phi
    CS1 = Cu+
    CS2 = HS-
    Charge1 = 1
    Charge2 = -1
  [../]


  [./Migration_HS-]
    block = 'Solution_domain'
    type = NernstPlanck
    T = 298.15
    variable = HS-
    Potential = phi
    Charge_coef = -1
    Diffusion_coef = 1E-9
  [../]
  [./Migration_Cu+]
    block = 'Solution_domain'
    type = NernstPlanck
    T = 298.15
    variable = Cu+
    Potential = phi
    Charge_coef = 1
    Diffusion_coef = 1E-9    
  [../]
[]

[ChemicalReactions]
 [./Network]
   block = 'Solution_domain'
   species = 'Cu Cu+ HS-'
   track_rates = False
   equation_constants = 'Ea R T_Re'
   equation_values = '0 8.314 298.15'
#   equation_variables = 'T'

   reactions = 'Cu+ + HS- -> Cu : {1E-1}'
 []
[]


[BCs]
  [./left_bc]
    type = DirichletBC
    boundary = left
    variable = Cu+
    value = 1
  [../]
  [./right_bc]
    type = DirichletBC
    boundary = right
    variable = HS-
    value = 1
  [../]

[]

[Executioner]
  type = Transient
  start_time = 0 #[s]
  end_time = 86400 #
  solve_type = 'PJFNK'
#  l_abs_tol = 1e-3 #1e-11 for HS- + H2O2
#  l_tol = 1e-5 #default = 1e-5
#  nl_abs_tol = 1e-2 #1e-11 for HS- + H2O2
  nl_rel_tol = 1e-1  #default = 1e-7
  l_max_its = 10
  nl_max_its = 10
#  dtmax = 10
#  dt = 0.5

  automatic_scaling = true
  compute_scaling_once = false

#  steady_state_detection = true
#  steady_state_tolerance = 3e-6
  [./TimeStepper]
    type = IterationAdaptiveDT
    cutback_factor = 0.99
    dt = 1
    growth_factor = 1.01
  [../]
  
#  [./Adaptivity]
#    refine_fraction = 0.3
#    max_h_level = 7
#    cycles_per_step = 2
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

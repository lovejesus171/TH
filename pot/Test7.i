[Mesh]
  type = GeneratedMesh 
  dim = 1
  xmin = 0
  xmax = 1E-3
  nx = 200
[]


[Variables]
  # Name of chemical species
  [./Cu+]
   order = FIRST
   initial_condition = 0
  [../]
  [./HS-]
   order = FIRST
   initial_condition = 0
  [../]
  [./CuHS]
   order = FIRST
   initial_condition = 0
  [../]
  [./Cu2S]
   order = FIRST
   initial_condition = 0
  [../]
  [./phi]
   order = FIRST
   initial_condition = 0
  [../]
[]


#[ICs]
# [./Solution_block_HS-]
#    type = ConstantIC
#    block = 'Solution_domain'
#    variable = HS-
#    value = 0
#  [../]
#[]


[Kernels]
# dCi/dt
  [./dCu+_dt]
    type = TimeDerivative
    variable = Cu+
  [../]
  [./dCuHS_dt]
    type = TimeDerivative
    variable = CuHS
  [../]
  [./dCu2S_dt]
    type = TimeDerivative
    variable = Cu2S
  [../]
  [./dHS-_dt]
    type = TimeDerivative
    variable = HS-
  [../]
  [./dphi_dt]
    type = TimeDerivative
    variable = phi
  [../]


# D*dC/dx
  [./DgradCu+]
    type = CoefDiffusion
    coef = 1e-9
    variable = Cu+
  [../]
  [./DgradCuHS]
    type = CoefDiffusion
    coef = 0
    variable = CuHS
  [../]
  [./DgradCu2S]
    type = CoefDiffusion
    coef = 0
    variable = Cu2S
  [../]
  [./DgradHS-]
    type = CoefDiffusion
    coef = 1e-9
    variable = HS-
  [../]

# sum of charge = per * grad * grad * electrolyte_potential
  [./Cal_Potential_dist]
    type = SEF2
    variable = phi
    CS1 = Cu+
    CS2 = HS-
    Charge1 = 1
    Charge2 = -1
  [../]

# migration of cations and anions
  [./Migration_HS-]
    type = NernstPlanck
    T = 298.15
    variable = HS-
    Potential = phi
    Charge_coef = -1
    Diffusion_coef = 1E-9
  [../]
  [./Migration_Cu+]
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
   species = 'Cu+ CuHS Cu2S HS-'
   track_rates = False
   equation_constants = 'Ea R T_Re'
   equation_values = '0 8.314 298.15'
   equation_variables = 'T'

   reactions = 'Cu+ + HS- -> CuHS : {1E1}
                CuHS + HS- -> Cu2S : {1E1}
'
 []
[]


[BCs]
  [./left_bc_Cu+]
    type = SurfacePBC
    boundary = left
    variable = Cu+
    Reactant1 = HS-
    Saturation = 1
    Diffusion_coef = 1e-9
    Tortuosity = 1
    Faraday_constant = 1
    Charge_number = 1
    Porosity = 1
  [../]
  [./left_bc_HS-]
    type = SurfaceBC
    boundary = left
    variable = HS-
    Saturation = 1
    Diffusion_coef = -1e9
    Tortuosity = 1
    Faraday_constant = 1
    Charge_number = 1
    Porosity = 1
  [../]
#  [./FL]
#   type = NeumannBC
#   boundary = left
#   variable = HS-
#   value = 1e-9
#  [../]

  [./right_bc_HS-]
    type = DirichletBC
    boundary = right
    variable = HS-
    value = 1
  [../]
[]

[Executioner]
  type = Transient
  start_time = 0 #[s]
  end_time = 3600 #
  solve_type = 'NEWTON'
#  l_abs_tol = 1e-3 #1e-11 for HS- + H2O2
#  l_tol = 1e-5 #default = 1e-5
#  nl_abs_tol = 1e-2 #1e-11 for HS- + H2O2
  nl_rel_tol = 1e-2  #default = 1e-7
  l_max_its = 10
  nl_max_its = 10
  dtmax = 10
#  dt = 0.5

  automatic_scaling = true
  compute_scaling_once = false

  steady_state_detection = true
  steady_state_tolerance = 1e-5
  [./TimeStepper]
    type = IterationAdaptiveDT
    cutback_factor = 0.99
    dt = 0.1
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

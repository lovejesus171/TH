[Mesh]
  file = '1D_Ion_exchange_COMSOL.msh'
[]

[Variables]
  # Name of chemical species
  [./A]
   block = 'S1 S2 M1 M2'
   order = FIRST
  [../]
  [./B]
   block = 'S1 S2 M1 M2'
   order = FIRST
  [../]
  [./C]
   block = 'S1 S2 M1 M2'
   order = FIRST
  [../]
  [./phi]
   block = 'S1 S2 M1 M2'
   order = FIRST
  [../]
  [./fixed_space_charge]
   block = 'S1 S2 M1 M2'
   order = FIRST
  [../]
[]

[Functions]
  [./IC_phi]
   type = ParsedFunction
   value = x/(3*1E-4)*0.1
  [../]

[]

[ICs]
  [./ICA]
   block = 'S1 S2 M1 M2'
    type = ConstantIC
    variable = A
    value = 0.1E3
  [../]
  [./ICB]
   block = 'S1 S2 M1 M2'
    type = ConstantIC
    variable = B
    value = 0.1E3
  [../]
  [./ICC]
   block = 'S1 S2 M1 M2'
    type = ConstantIC
    variable = C
    value = 0.1E3
  [../]
  [./ICphi]
   block = 'S1 S2 M1 M2'
    type = FunctionIC
    variable = phi
    function = IC_phi #unit: V
  [../]

  [./IC_membrane_charge_1]
   block = 'S1 S2'
    type = ConstantIC
    variable = fixed_space_charge
    value = 0
  [../]

  [./IC_membrane_charge_2]
   block = 'M1 M2'
    type = ConstantIC
    variable = fixed_space_charge
    value = 1E3 #unit: mol/m3
  [../]

[]


[Kernels]
# dCi/dt
  [./dA_dt]
    block = 'S1 S2 M1 M2'
    type = TimeDerivative
    variable = A
  [../]
  [./dB_dt]
    block = 'S1 S2 M1 M2'
    type = TimeDerivative
    variable = B
  [../]
  [./dC_dt]
    block = 'S1 S2 M1 M2'
    type = TimeDerivative
    variable = C
  [../]
  [./dphi_dt]
    block = 'S1 S2 M1 M2'
    type = TimeDerivative
    variable = phi
  [../]
  [./dfC_dt]
    block = 'S1 S2 M1 M2'
    type = TimeDerivative
    variable = fixed_space_charge
  [../]
  

  [./DA]
    block = 'S1 S2 M1 M2'
    type = CoefDiffusion
    coef = 1e-9 
    variable = A
  [../]
  [./DB]
    block = 'S1 S2 M1 M2'
    type = CoefDiffusion
    coef = 1e-9 
    variable = B
  [../]
  [./DC]
    block = 'S1 S2 M1 M2'
    type = CoefDiffusion
    coef = 1e-9 
    variable = C
  [../]
  [./Dfixed_space_charge]
    block = 'S1 S2 M1 M2'
    type = CoefDiffusion
    coef = 0
    variable = fixed_space_charge
  [../]


  [./Cal_Potential_dist]
    block = 'S1 S2 M1 M2'
    type = Per4
    variable = phi
    CS1 = A
    CS2 = B
    CS3 = C
    CS4 = fixed_space_charge
    Charge1 = 1
    Charge2 = -1
    Charge3 = -1
    Charge4 = -1
    Permissivity = 1E-12
   [../]


  [./Migration_A]
    block = 'S1 S2 M1 M2'
    type = NernstPlanck
    T = 298.15
    variable = A
    Potential = phi
    Charge_coef = 1
    Diffusion_coef = 1E-9
  [../]
  [./Migration_B]
    block = 'S1 S2 M1 M2'
    type = NernstPlanck
    T = 298.15
    variable = B
    Potential = phi
    Charge_coef = -1
    Diffusion_coef = 1E-9    
  [../]
  [./Migration_C]
    block = 'S1 S2 M1 M2'
    type = NernstPlanck
    T = 298.15
    variable = C
    Potential = phi
    Charge_coef = -1
    Diffusion_coef = 1E-9    
  [../]
#  [./Migration_fixed_space_charge]
#    block = 'S1 S2 M1 M2'
#    type = NernstPlanck
#    T = 298.15
#    variable = fixed_space_charge
#    Potential = phi
#    Charge_coef = -1
#    Diffusion_coef = 0
#    Permittivity = 0 #unit: F/m = C/V/m 
#  [../]


[]

#[ChemicalReactions]
# [./Network]
#   block = 'Solution_domain'
#   species = 'Cu Cu+ HS-'
#   track_rates = False
#   equation_constants = 'Ea R T_Re'
#   equation_values = '0 8.314 298.15'
#   equation_variables = 'T'

#   reactions = 'Cu+ + HS- -> Cu : {1E-1}'
# []
#[]


[BCs]
  [./left_bc_phi]
    type = DirichletBC
    boundary = left
    variable = phi
    value = 0 #unit: V
  [../]
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






  [./right_bc_phi]
    type = DirichletBC
    boundary = right
    variable = phi
    value = 0.1 #unit: V
  [../]
  [./right_bc_A]
    type = DirichletBC
    boundary = right
    variable = A
    value = 0.1E3 
  [../]
  [./right_bc_B]
    type = DirichletBC
    boundary = right
    variable = B
    value = 0 
  [../]
  [./right_bc_C]
    type = DirichletBC
    boundary = right
    variable = C
    value = 0.1E3 
  [../]

[]

[Executioner]
  type = Transient
  start_time = 0 #[s]
  end_time = 86400 #
  solve_type = 'PJFNK'
#  l_abs_tol = 1e-3 #1e-11 for HS- + H2O2
#  l_tol = 1e-5 #default = 1e-5
#  nl_abs_tol = 1e-11 #1e-11 for HS- + H2O2
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
    dt = 1e-3
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

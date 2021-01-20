[Mesh]
  file = '1D_Cu_Sol.msh'
[]

[Variables]
  # Name of chemical species
  [./Cu]
   block = 'Copper_domain Film_domain Solution_domain '
   order = FIRST
  [../]
  [./CuHS-]
   block = 'Copper_domain Film_domain Solution_domain '
   order = FIRST
  [../]
  [./HS-]
   block = 'Copper_domain Film_domain Solution_domain'
   order =FIRST
  [../]
  [./Cu2S]
    block = 'Copper_domain Film_domain Solution_domain'
    order = FIRST
  [../]
[]

[Functions]
  [./IC_linear]
    type = ParsedFunction
    value = erf(100*(x-149e-6)/1e-6)
#    value = 1*(x-149e-6)/1e-6
  [../]
  [./IC_erf_Cu]
    type = ParsedFunction
    value = 8.96e6*erf(100*(x-149e-6)/1e-6)
  [../]
[]

[ICs]
  [./Copper_block_Cu]
    type = ConstantIC
    block = 'Copper_domain'
    variable = Cu
    value = 8.96e6 #[g/m3]
  [../]
  [./Copper_block_CuHS-]
    type = ConstantIC
    block = 'Copper_domain'
    variable = CuHS-
    value = 0 #[g/m3]
  [../]
  [./Copper_block_Cu2S]
    type = ConstantIC
    block = 'Copper_domain'
    variable = Cu2S
    value = 0
  [../]
  [./Copper_block_HS-]
    type = ConstantIC
    block = 'Copper_domain'
    variable = HS-
    value = 0
  [../]


  [./Film_block_Cu]
    block = 'Film_domain'
    type = FunctionIC
    variable = Cu
    function = IC_erf_Cu
  [../]
  [./Film_block_CuHS-]
    type = ConstantIC
    block = 'Film_domain'
    variable = CuHS-
    value = 0
  [../]


  [./Film_block_Cu2S]
    type = ConstantIC
    block = 'Film_domain'
    variable = Cu2S
    value = 0
  [../]
  [./Film_block_HS-]
    type = FunctionIC
    block = 'Film_domain'
    variable = HS-
    function = IC_linear
  [../]


  [./Solution_block_Cu]
    type = ConstantIC
    block = 'Solution_domain'
    variable = Cu
    value = 0
  [../]
  [./Solution_block_CuHS-]
    type = ConstantIC
    block = 'Solution_domain'
    variable = CuHS-
    value = 0
  [../]
  [./Solution_block_Cu2S]
    type = ConstantIC
    block = 'Solution_domain'
    variable = Cu2S
    value = 0
  [../]
  [./Solution_block_HS-]
    type = ConstantIC
    block = 'Solution_domain'
    variable = HS-
    value = 1
  [../]

[]


[Kernels]
# dCi/dt
  [./dCu_dt]
    block = 'Copper_domain Film_domain Solution_domain'
    type = TimeDerivative
    variable = Cu
  [../]
  [./dCuHS-_dt]
    block = 'Copper_domain Film_domain Solution_domain'
    type = TimeDerivative
    variable = CuHS-
  [../]
  [./dCu2S_dt]
    block = 'Copper_domain Film_domain Solution_domain'
    type = TimeDerivative
    variable = Cu2S
  [../]
  [./dHS-_dt]
    block = 'Copper_domain Film_domain Solution_domain'
    type = TimeDerivative
    variable = HS-
  [../]

  [./DgradCu]
    block = 'Copper_domain Film_domain Solution_domain'
    type = CoefDiffusion
    coef = 0 
    variable = Cu
  [../]
  [./DgradCu2S]
    block = 'Copper_domain Film_domain Solution_domain'
    type = CoefDiffusion
    coef = 0
    variable = Cu2S
  [../]
  [./DgradCuHS-]
    block = 'Copper_domain Film_domain Solution_domain'
    type = CoefDiffusion
    coef = 0
    variable = CuHS-
  [../]


  [./DgradHS-_C]
    block = 'Copper_domain'
    type = CoefDiffusion
    coef = 3600e-13
    variable = HS-
  [../]
  [./DgradHS-_F]
    block = 'Film_domain'
    type = CoefDiffusion
    coef = 3600e-11
    variable = HS-
  [../]
  [./DgradHS-_S]
    block = 'Solution_domain'
    type = CoefDiffusion
    coef = 3600e-10
    variable = HS-
  [../]
[]

[ChemicalReactions]
 [./Network]
   block = 'Copper_domain Film_domain Solution_domain'
   species = 'Cu CuHS- HS- Cu2S'
   track_rates = False
   equation_constants = 'Ea R T_Re'
   equation_values = '0 8.314 298.15'
#   equation_variables = 'T'

   reactions = 'Cu + HS- -> CuHS- : {1E-5}
                Cu + CuHS- -> Cu2S : {1E-5}
                  
                
'
 []
[]


[Executioner]
  type = Transient
  start_time = 0 #[hr]
  end_time = 20 #[hr]
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
  [./TimeStepper]
    type = IterationAdaptiveDT
    cutback_factor = 0.9
    dt = 1e-3
    growth_factor = 1.1
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

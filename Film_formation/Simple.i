[Mesh]
  file = 'Oxide_film.msh'
[]

[Variables]
  # Name of chemical species
  [./Cu]
   block = 'Copper_domain Film_domain Solution_domain '
   order = FIRST
  [../]
  [./O2]
   block = 'Copper_domain Film_domain Solution_domain'
   order =FIRST
  [../]
  [./Cu2O]
    block = 'Copper_domain Film_domain Solution_domain'
    order = FIRST
  [../]
[]

[ICs]
  [./Copper_block_Cu]
    type = ConstantIC
    block = 'Copper_domain'
    variable = Cu
    value = 10
  [../]
  [./Copper_block_Cu2O]
    type = ConstantIC
    block = 'Copper_domain'
    variable = Cu2O
    value = 0
  [../]
  [./Copper_block_O2]
    type = ConstantIC
    block = 'Copper_domain'
    variable = O2
    value = 0
  [../]


  [./Film_block_Cu]
    type = ConstantIC
    block = 'Film_domain'
    variable = Cu
    value = 0
  [../]
  [./Film_block_Cu2O]
    type = ConstantIC
    block = 'Film_domain'
    variable = Cu2O
    value = 10
  [../]
  [./Film_block_O2]
    type = ConstantIC
    block = 'Film_domain'
    variable = O2
    value = 0
  [../]


  [./Solution_block_Cu]
    type = ConstantIC
    block = 'Solution_domain'
    variable = Cu
    value = 0
  [../]
  [./Solution_block_Cu2O]
    type = ConstantIC
    block = 'Solution_domain'
    variable = Cu2O
    value = 0
  [../]
  [./Solution_block_O2]
    type = ConstantIC
    block = 'Solution_domain'
    variable = O2
    value = 10
  [../]

[]


[Kernels]
# dCi/dt
  [./dCu_dt]
    block = 'Copper_domain Film_domain Solution_domain'
    type = TimeDerivative
    variable = Cu
  [../]
  [./dCu2O_dt]
    block = 'Copper_domain Film_domain Solution_domain'
    type = TimeDerivative
    variable = Cu2O
  [../]
  [./dO2_dt]
    block = 'Copper_domain Film_domain Solution_domain'
    type = TimeDerivative
    variable = O2
  [../]

  [./DgradCu]
    block = 'Copper_domain Film_domain Solution_domain'
    type = CoefDiffusion
    coef = 0 
    variable = Cu
  [../]
  [./DgradCu2O]
    block = 'Copper_domain Film_domain Solution_domain'
    type = CoefDiffusion
    coef = 0
    variable = Cu
  [../]
  [./DgradO2]
    block = 'Copper_domain Film_domain Solution_domain'
    type = CoefDiffusion
    coef = 2e-9
    variable = O2
  [../]
[]

[ChemicalReactions]
 [./Network]
   block = 'Copper_domain Film_domain Solution_domain'
   species = 'Cu O2 Cu2O'
   track_rates = False

   equation_constants = 'Ea R T_Re'
   equation_values = '0 8.314 298.15'
#   equation_variable = 'T'

   reactions = 'Cu + Cu + Cu + Cu + O2 -> Cu2O + Cu2O : {1E1}
'
 [../]
[]


[Executioner]
  type = Transient
  start_time = 0 #[s]
  end_time = 1000 #[s]
  solve_type = 'PJFNK'
#  l_abs_tol = 1e-3 #1e-11 for HS- + H2O2
#  l_tol = 1e-5 #default = 1e-5
#  nl_abs_tol = 1e-5 #1e-11 for HS- + H2O2
  nl_rel_tol = 1e-2  #default = 1e-7
  l_max_its = 10
  nl_max_its = 10
#  dtmax = 10
  dt= 0.025

  automatic_scaling = true
  compute_scaling_once = true
#  [./TimeStepper]
#    type = IterationAdaptiveDT
#    cutback_factor = 0.9
#    dt = 0.025
#    growth_factor = 1.1
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

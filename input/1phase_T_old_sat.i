# Unsaturated Darcy-Richards flow without using an Action

[Mesh]
  file = 'KRS+_4parts_old.msh'
[]

[Variables]
  [./temperature]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[Kernels]
  [./dT_dt]
    type = HeatConductionTimeDerivative
    variable = temperature
    block = 'bentonite backfill hostrock'
  [../]
  [./Heat_cond]
    type = HeatConduction
    variable = temperature
    block = 'bentonite backfill hostrock'
  [../]
[]

[ICs]
# Temperature
   [./IC_T]
    type = ConstantIC
    variable = temperature
    value = 298.15
    block = 'bentonite backfill'
   [../]
   [./IC_T_hostrock]
    type = FunctionIC
    variable = temperature
    function = underground_temp
    block = 'hostrock'
   [../]
[]

[BCs]
# Temperature
  [./BC_T_top]
    type = DirichletBC
    variable = temperature
    value = '296.65'
    boundary = 'top'
  [../]
  [./BC_T_bottom]
    type = DirichletBC
    variable = temperature
    value = '299.65'
    boundary = 'bottom'
  [../]
 
# Heat Flux
  [./BC_HeatFlux]
    type = FunctionNeumannBC
    variable = temperature
    boundary = 'spent_fuel spent_fuel_top spent_fuel_bottom'
    function = Decay_fn
  [../]
[]

[Functions]
  [./underground_temp]
     type = ParsedFunction
     value = '283.15 - 0.03 * y'
  [../]
  [./Decay_fn]
     type = ParsedFunction
     vars = 'P0 r h yts'
     vals = '26830 0.51 4.83 31536000'
     value = 'P0 * yts * ((t + 30)^-0.758) / (2 * pi * r * h + 2 * pi * r * r)'
  [../]
[]

[Materials]
# Heat transfer
  [./Heat_conduction_bentonite]
    type = HeatConductionMaterial
    block = 'bentonite'
    specific_heat = 966
    thermal_conductivity = 37843200
  [../] 
  [./Heat_conduction_backfill]
    type = HeatConductionMaterial
    block = 'backfill'
    specific_heat = 981
    thermal_conductivity = 67770864
  [../] 
  [./Heat_conduction_hostrock]
    type = HeatConductionMaterial
    block = 'hostrock'
    specific_heat = 820
    thermal_conductivity = 99811440
  [../] 
 
  [./Density_bentonite]
    type = GenericConstantMaterial
    prop_names = density
    prop_values = 2740
    block = 'bentonite'
  [../]
  [./Density_backfill]
    type = GenericConstantMaterial
    prop_names = density
    prop_values = 2680
    block = 'backfill'
  [../]
  [./Density_hostrock]
    type = GenericConstantMaterial
    prop_names = density
    prop_values = 2650
    block = 'hostrock'
  [../]
[]

[Preconditioning]
  active = basic
  [./basic]
    type = SMP
    full = true
    petsc_options = '-ksp_diagonal_scale -ksp_diagonal_scale_fix'
    petsc_options_iname = '-pc_type -sub_pc_type -sub_pc_factor_shift_type -pc_asm_overlap'
    petsc_options_value = ' asm      lu           NONZERO                   2'
  [../]
  [./preferred_but_might_not_be_installed]
    type = SMP
    full = true
    petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
    petsc_options_value = ' lu       mumps'
  [../]
[]

[Executioner]
  type = Transient
  solve_type = NEWTON
  end_time = 1000
#  nl_abs_tol = 1E-5
  nl_rel_tol = 1E-3
  [./TimeStepper]
    type = IterationAdaptiveDT
    cutback_factor = 0.88
    dt = 0.001
    growth_factor = 1.12
  [../]
[]

[Outputs]
  exodus = true
[]

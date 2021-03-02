[Mesh]
  file = 'KRS+.msh'
[]

[GlobalParams]
  PorousFlowDictator = dictator
[]

[Variables]
  [./porepressure]
  [../]
  [./H2O]
    order = FIRST
    family = LAGRANGE
  [../]
  [./Temperature]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[ICs]
# Initial condition of Pressure 
  [./IC_P_hostrock]
    type = FunctionIC
    variable = porepressure
    function = hydro_static
    block = 'hostrock'
  [../]
  [./IC_P_bentonite_backfill]
    type = ConstantIC
    variable = porepressure
    value = 1.01E5
    block = 'bentonite backfill'
  [../]
  
# Initial condition of Saturation
  [./IC_H2O_Hostrock]
    type = ConstantIC
    variable = H2O
    value = 0.999
    block = 'hostrock'
  [../]
  [./IC_H2O_Bentonite]
    type = ConstantIC
    variable = H2O
    value = 0.59
    block = 'bentonite'
  [../]
  [./IC_H2O_Backfill]
    type = ConstantIC
    variable = H2O
    value = 0.59
    block = 'backfill'
  [../]
  [./IC_H2O_Interface]
    type = ConstantIC
    variable = H2O
    value = 0.8
    boundary = 'interface'
  [../]

# Inital conditions of Temperature
  [./IC_T_Hostrock]
    type = FunctionIC
    variable = Temperature
    function = underground_temp
    block = 'hostrock'
  [../]
  [./IC_T]
    type = ConstantIC
    variable = Temperature
    value = 298.15
    block = 'bentonite backfill'
  [../]
[]

[PorousFlowBasicTHM]
  porepressure = porepressure
  coupling_type = Hydro
  gravity = '0 0 -9.81'
  fp = water
[]

[BCs]
# Boundary Condition about pressure & H2O
  [./BC_pressure]
    type = FunctionDirichletBC
    variable = porepressure
    function = hydro_static
    boundary = 'surface'
  [../]
  [./BC_H2O]
    type = DirichletBC
    variable = H2O
    value = 1
    boundary = 'surface'
  [../]

# Boundary Condition about Heat Flux
  [./BC_Temp_top]
    type = DirichletBC
    variable = Temperature
    value = '301.65' # [K]
    boundary = 'top'
  [../]
  [./BC_Temp_bottom]
    type = DirichletBC
    variable = Temperature
    value = '304.65' # [K]
    boundary = 'bottom'
  [../]
  [./BC_Heat_flux]
    type = FunctionNeumannBC
    variable = Temperature
    boundary = 'spent_fuel'
    function = Decay_fn
  [../]

[]

[Modules]
  [./FluidProperties]
    [./water]
      type = SimpleFluidProperties
      bulk_modulus = 2.1E9
      viscosity = 1E-8  # 8.9E-4/(365 * 24 * 3600)
      density0 = 1000
    [../]
  [../]
[]

[UserObjects]
  [./PorousFlow]
    type = PorousFlowDictator
    porous_flow_vars = 'porepressure'
    number_fluid_phases = 1
    number_fluid_components = 1
  [../]
  [./Suction_pressure_bentonite]
     type = PorousFlowCapillaryPressureVG
     alpha = 2.6E-7
     m = 0.2941
     block = 'bentonite'
  [../]
  [./Suction_pressure_backfill]
     type = PorousFlowCapillaryPressureVG
     alpha = 3.3E-7
     m = 0.5
     block = 'backfill'
  [../]
  [./Suction_pressure_hostrock]
     type = PorousFlowCapillaryPressureVG
     alpha = 5E-7
     m = 0.6
     block = 'hostrock'
  [../]
[]

[Functions]
  [./hydro_static]
     type = ParsedFunction
     value = '-1000 * 9.81 * y'
  [../]
  [./underground_temp]
     type = ParsedFunction
     value = '288.15 - 0.03 * y'
  [../]
  [./Decay_fn]
     type = ParsedFunction
     vars = 'P0 yts r h'
     vals = '26830 31536000 0.61 4.83'
     value = 'P0 * yts * ((t + 30)^-0.758) / (2 * pi * r * h + 2 * pi * r * r)'
  [../]
[]

[Materials]
# Material properties about Pressure
  [./porosity]
    type = PorousFlowPorosity
    porosity_zero = '0.4 0.41 0.01'
    block = 'bentonite backfill hostrock'
  [../]
  [./biot_modulus_bentonite]
    type = PorousFlowConstantBiotModulus
    biot_coefficient = '1'
    block = 'bentonite'
  [../]
  [./biot_modulus_backfill]
    type = PorousFlowConstantBiotModulus
    biot_coefficient = '1'
    block = 'backfill'
  [../]
  [./biot_modulus_hostrock]
    type = PorousFlowConstantBiotModulus
    biot_coefficient = '1'
    block = 'hostrock'
  [../]
  [./Permeability_hostrock]
    type = PorousFlowPermeabilityConst
    block = 'hostrock'
    permeability = '1E-18 0 0   0 1E-18 0   0 0 1E-18'
  [../]
  [./Permeability_bentonite]
    type = PorousFlowPermeabilityConst
    block = 'bentonite'
    permeability = '1.5E-20 0 0   0 1.5E-20 0   0 0 1.5E-20'
  [../]
  [./Permeability_backfill]
    type = PorousFlowPermeabilityConst
    block = 'backfill'
    permeability = '1.6E-19 0 0   0 1.6E-19 0   0 0 1.6E-19'
  [../]
# Material properties about Darcy Flow
  [./darcy_velcity_qp_bentonite]
    type = PorousFlowDarcyVelocityMaterial
    gravity = '0 0 -9.81'
    block = 'bentonite'
  [../]
  [./darcy_velcity_qp_backfill]
    type = PorousFlowDarcyVelocityMaterial
    gravity = '0 0 -9.81'
    block = 'backfill'
  [../]
  [./darcy_velcity_qp_hostrock]
    type = PorousFlowDarcyVelocityMaterial
    gravity = '0 0 -9.81'
    block = 'hostrock'
  [../]

# Heat Transfer within Material
  [./Thermal_conductivity_bentonite]
    type = ParsedMaterial
    f_name = thermal_conductivity
    args = 'H2O'
    function = '(0.72 + (0.48 * H2O)) * 365 * 24 * 3600'
    block = 'bentonite'
  [../]
  [./Thermal_conductivity_dt_bentonite]
    type = DerivativeParsedMaterial
    f_name = thermal_conductivity_dT
    args = 'H2O'
    function = '0'
    block = 'bentonite'
  [../]
  [./Specific_heat_bentonite]
    type = ParsedMaterial
    f_name = specific_heat
    args = 'H2O'
    function = '966'
    block = 'bentonite'
  [../]
  [./Specific_heat_dt_bentonite]
    type = DerivativeParsedMaterial
    f_name = specific_heat_dT
    args = 'H2O'
    function = '0'
    block = 'bentonite'
  [../]
  [./Density_bentonite]
    type = GenericConstantMaterial
    prop_names = density
    prop_values = 2740
    block = 'bentonite'
  [../]
  [./Thermal_conductivity_backfill]
    type = ParsedMaterial
    f_name = thermal_conductivity
    args = 'H2O'
    function = '(1.09 + (1.059 * H2O)) * 365 * 24 * 3600'
    block = 'backfill'
  [../]
  [./Thermal_conductivity_dt_backfill]
    type = DerivativeParsedMaterial
    f_name = thermal_conductivity_dT
    args = 'H2O'
    function = '0'
    block = 'backfill'
  [../]
  [./Specific_heat_backfill]
    type = ParsedMaterial
    f_name = specific_heat
    args = 'H2O'
    function = '981'
    block = 'backfill'
  [../]
  [./Specific_heat_dt_backfill]
    type = DerivativeParsedMaterial
    f_name = specific_heat_dT
    args = 'H2O'
    function = '0'
    block = 'backfill'
  [../]
  [./Density_backfill]
    type = GenericConstantMaterial
    prop_names = density
    prop_values = 2680
    block = 'backfill'
  [../]
  [./Thermal_conductivity_hostrock]
    type = ParsedMaterial
    f_name = thermal_conductivity
    args = 'H2O'
    function = '(2.853 + (0.312 * H2O)) * 365 * 24 * 3600'
    block = 'hostrock'
  [../]
  [./Thermal_conductivity_dt_hostrock]
    type = DerivativeParsedMaterial
    f_name = thermal_conductivity_dT
    args = 'H2O'
    function = '0'
    block = 'hostrock'
  [../]
  [./Specific_heat_hostrock]
    type = ParsedMaterial
    f_name = specific_heat
    args = 'H2O'
    function = '820'
    block = 'hostrock'
  [../]
  [./Specific_heat_dt_hostrock]
    type = DerivativeParsedMaterial
    f_name = specific_heat_dT
    args = 'H2O'
    function = '0'
    block = 'hostrock'
  [../]
  [./Density_hostrock]
    type = GenericConstantMaterial
    prop_names = density
    prop_values = 2650
    block = 'hostrock'
  [../]
[]

[Kernels]
# Heat Flux
  [./Heat_cond]
    type = HeatConduction
    variable = Temperature
    block = 'bentonite backfill hostrock'
  [../]
  [./dHeat_cond_dt]
    type = HeatConductionTimeDerivative
    variable = Temperature
    block = 'bentonite backfill hostrock'
  [../]
# Darcy Flow for H2O
  [./Darcy_water_hostrock]
    type = PorousFlowBasicAdvection
    variable = H2O
    block = 'hostrock bentonite backfill'
  [../]
  [./dH2O_dt]
    type = TimeDerivative
    variable = H2O
    block = 'hostrock bentonite backfill'
  [../]
  [./Diff_H2O_hostrock]
    type = CoefDiffusion
    coef = 9.5E-3
    variable = H2O
    block = 'hostrock'
  [../]
  [./Diff_H2O_bentonite]
    type = CoefDiffusion
    coef = 9.5E-3
    variable = H2O
    block = 'bentonite'
  [../]
  [./Diff_H2O_backfill]
    type = CoefDiffusion
    coef = 9.5E-3
    variable = H2O
    block = 'backfill'
  [../]
[]

[Preconditioning]
  active = basic
  [./basic]
    type = SMP
    full = true
    petsc_options = '-ksp_diagonal_scale -ksp_diagonal_scale_fix'
    petsc_options_iname = '-ps_type -sub_pc_type -sub_pc_factor_shift_type -pc_asm_overlap'
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
  solve_type = Newton
  end_time = 1000
  l_abs_tol = 1e-15
  nl_abs_tol = 1e-15
   [./TimeStepper]
     type = IterationAdaptiveDT
     cutback_factor = 0.8
     dt = 0.001
     growth_factor =1.2
   [../]
[]

[Outputs]
  exodus = true
[]

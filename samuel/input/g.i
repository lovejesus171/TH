# Unsaturated Darcy-Richards flow without using an Action

[Mesh]
  file = 'KRS+_4parts.msh'
[]

[UserObjects]
  [./dictator]
    type = PorousFlowDictator
    porous_flow_vars = 'pp'
    number_fluid_phases = 1
    number_fluid_components = 1
  [../]
  [./pc_bentonite]
    type = PorousFlowCapillaryPressureVG
    alpha = 3.85E6 #[Pa]
    m = 0.2941 #[Unitless]
    block = bentonite
  [../]
  [./pc_backfill]
    type = PorousFlowCapillaryPressureVG
    alpha = 3.03E6 #[Pa]
    m = 0.5 #[Unitless]
    block = backfill
  [../]
  [./pc_hostrock]
    type = PorousFlowCapillaryPressureVG
    alpha = 2E6 #[Pa]
    m = 0.6 #[Unitless]
    block = hostrock
  [../]
[]

[GlobalParams]
  PorousFlowDictator = dictator
[]

[Variables]
  [./pp]
    order = FIRST
    family = LAGRANGE
  [../]
  [./temperature]
    order = FIRST
    family = LAGRANGE
  [../]
  [./O2]
    order = FIRST
    family = LAGRANGE
  [../]
  [./HS-]
    order = FIRST
    family = LAGRANGE
  [../]
#  [./sat]
#    order = FIRST
#    family = LAGRANGE
#  [../]
[]

[Kernels]
# Pressure
  [./dP_dt]
    type = PorousFlowMassTimeDerivative
    variable = pp
    block = 'bentonite backfill hostrock'
  [../]
  [./flux_P]
    type = PorousFlowAdvectiveFlux
    variable = pp
    gravity = '0 0 9.81'
    block = 'bentonite backfill hostrock'
  [../]

# Heat Transfer
  [./Heat_cond]
    type = HeatConduction
    variable = temperature
    block = 'bentonite backfill hostrock'
  [../]
  [./flux_Q]
    type = HeatConductionTimeDerivative
    variable = temperature
    block = 'bentonite backfill hostrock'
  [../]

# Saturation
#  [./dsat_dt]
#    type = TimeDerivative
#    variable = sat
#    block = 'bentonite backfill hostrock'
#  [../]
#  [./sat_flow]
#     type = PorousFlowBasicAdvection
#    variable = sat
#    block = 'bentonite backfill hostrock'
#  [../]
#  [./Sat]
#    type = ParsedAux
#    args = 'pp'
#    function = '0.41 / (4.804 * 1E6) * pp + 0.5814'
#    variable = sat
#  [../]
#  [./sat]
#    type = Sat
#    P = pp
#    variable = sat
#    block = 'bentonite backfill hostrock'
#  [../]

# Chemical
  [./dO2_dt]
    type = TimeDerivative
    variable = O2
    block = 'bentonite backfill hostrock'
  [../]
  [./Diff_O2]
    type = CoefDiffusion
    variable = O2
    coef = 2.14E-3
    block = 'bentonite backfill'
  [../]
  [./dHS-_dt]
    type = TimeDerivative
    variable = HS-
    block = 'bentonite backfill hostrock'
  [../]
  [./Diff_HS-_bentonite]
    type = CoefDiffusion
    variable = HS-
    coef = 2.523E-5
    block = 'bentonite'
  [../]
  [./Diff_HS-_backfill]
    type = CoefDiffusion
    variable = HS-
    coef = 2.523E-5
    block = 'backfill'
  [../]
[]

[AuxVariables]
  [./sat]
    family = MONOMIAL
    order = CONSTANT
  [../]
[]

[AuxKernels]
  [./Sat]
    type = PorousFlowPropertyAux
    variable = sat
    property = saturation
  [../]
[]
 

[ICs]
# Pressure
  [./IC_P]
    type = ConstantIC
    variable = pp
    value = 1.01E5 #[Pa]
    block = 'bentonite backfill'
  [../]
  [./IC_P_hostrock]
    type = FunctionIC
    variable = pp
    function = hydro_static
    block = 'hostrock'
  [../]

# Temperature
  [./IC_T]
    type = ConstantIC
    variable = temperature
    value = 298.15
    block = 'bentonite backfill'
  [../]
  [./IC_hostrock]
    type = FunctionIC
    variable = temperature
    function = underground_temp
    block = 'hostrock'
  [../]

# Saturation
#  [./IC_Sat_bentonite]
#    type = ConstantIC
#    variable = sat
#    value = 0.59
#    block = 'bentonite'
#  [../]
#  [./IC_Sat_backfill]
#    type = ConstantIC
#    variable = sat
#    value = 0.59
#    block = 'backfill'
#  [../]
#  [./IC_Sat_hostrock]
#    type = ConstantIC
#    variable = sat
#    value = 0.99
#    block = 'hostrock'
#  [../]
#  [./IC_Sat_interface]
#    type = ConstantIC
#    variable = sat
#    value = 0.8
#    boundary = 'bentonite_surface backfill_surface'
#  [../]  

# Chemical Species
  [./IC_O2_bentonite]
    type = ConstantIC
    variable = O2
    value = 5.4  #moles/m3
    block = 'bentonite'
  [../]
  [./IC_O2_backfill]
    type = ConstantIC
    variable = O2
    value = 5.4  #moles/m3
    block = 'backfill'
  [../]
  [./IC_HS-_bentonite]
    type = ConstantIC
    variable = HS-
    value = 0.02585  #moles/m3
    boundary = 'bentonite_surface'
  [../]
  [./IC_HS-_backfill]
    type = ConstantIC
    variable = HS-
    value = 0.02585  #moles/m3
    boundary = 'backfill_surface'
  [../]
[]

[BCs]
# Pressure
  [./BC_P]
    type = FunctionDirichletBC
    variable = pp
    function = hydro_static
    boundary = 'surface'
  [../]

# Temperature
  [BC_T_top]
    type = DirichletBC
    variable = temperature
    value = '301.65'
    boundary = 'top'
  [../]
  [BC_T_bottom]
    type = DirichletBC
    variable = temperature
    value = '304.65'
    boundary = 'bottom'
  [../]

# Heat Flux
  [./BC_HeatFlux]
    type = FunctionNeumannBC
    variable = temperature
    boundary = 'spent_fuel spent_fuel_top spent_fuel_bottom'
    function = Decay_fn
  [../]

# Chemical Species
  [./BC_O2_canister]
    type = DirichletBC
    variable = O2
    value = 0
    boundary = 'spent_fuel spent_fuel_top spent_fuel_bottom'
  [../]
  [./BC_HS-_canister]
    type = DirichletBC
    variable = HS-
    value = 0
    boundary = 'spent_fuel spent_fuel_top spent_fuel_bottom'
  [../]
  [./BC_HS-_bentonite]
    type = DirichletBC
    variable = HS-
    value = 0.02585
    boundary = 'bentonite_surface'
  [../]
  [./BC_HS-_backfill]
    type = DirichletBC
    variable = HS-
    value = 0.02585
    boundary = 'backfill_surface'
  [../]
[]

[Functions]
  [./hydro_static]
     type = ParsedFunction
     value = '-1000 * 9.81 * y' #[Pa] positive
  [../]
  [./underground_temp]
     type = ParsedFunction
     value = '288.15 - 0.03 * y'
  [../]
  [./Decay_fn]
     type = ParsedFunction
     vars = 'P0 r h yts'
     vals = '26830 0.515 4.78 31536000'
     value = 'P0 * yts * ((t + 30)^-0.758) / (2 * pi * r * h + 2 * pi * r * r)'
  [../]
[]

[Modules]
  [./FluidProperties]
    [./the_simple_fluid]
      type = SimpleFluidProperties
      bulk_modulus = 2.1E9 #[Pa]
      viscosity = 1.2811E-10 #1E-3/(365*24*3600) [Pas]
      density0 = 1000.0
    [../]
  [../]
[]

[Materials]
  [./porosity_bentonite]
    type = PorousFlowPorosity
    porosity_zero = '0.41'
    block = 'bentonite'
  [../]
  [./porosity_backfill]
    type = PorousFlowPorosity
    porosity_zero = '0.4'
    block = 'backfill'
  [../]
  [./porosity_hostrock]
    type = PorousFlowPorosity
    porosity_zero = '0.01'
    block = 'hostrock'
  [../]
  [./permeability_bentonite]
    type = PorousFlowPermeabilityConst
    block = bentonite
    permeability = '5.7E-21 0 0   0 5.7E-21 0   0 0 55.7E-21'
  [../]
  [./permeability_backfill]
    type = PorousFlowPermeabilityConst
    block = backfill
    permeability = '6.08E-20 0 0   0 6.08E-20 0   0 0 6.08E-20'
  [../]
  [./permeability_hostrock]
    type = PorousFlowPermeabilityConst
    block = hostrock
    permeability = '9.7E-19 0 0   0 9.7E-19 0   0 0 9.7E-19'
  [../]
  [./saturation_calculator_bentonite]
    type = PorousFlow1PhaseP
    porepressure = pp
    capillary_pressure = pc_bentonite
    block = bentonite
  [../]
  [./saturation_calculator_backfill]
    type = PorousFlow1PhaseP
    porepressure = pp
    capillary_pressure = pc_backfill
    block = backfill
  [../]
  [./saturation_calculator_hostrock]
    type = PorousFlow1PhaseP
    porepressure = pp
    capillary_pressure = pc_hostrock
    block = hostrock
  [../]
  [./temperature_bentonite]
    type = PorousFlowTemperature
    block = bentonite
  [../]
  [./temperature_backfill]
    type = PorousFlowTemperature
    block = backfill
  [../]
  [./temperature_hostrock]
    type = PorousFlowTemperature
    block = hostrock
  [../]
  [./massfrac_bentonite]
    type = PorousFlowMassFraction
    block = bentonite
  [../]
  [./massfrac_backfill]
    type = PorousFlowMassFraction
    block = backfill
  [../]
  [./massfrac_hostrock]
    type = PorousFlowMassFraction
    block = hostrock
  [../]
  [./simple_fluid_bentonite]
    type = PorousFlowSingleComponentFluid
    fp = the_simple_fluid
    phase = 0
    block = bentonite
  [../]
  [./simple_fluid_backfill]
    type = PorousFlowSingleComponentFluid
    fp = the_simple_fluid
    phase = 0
    block = backfill
  [../]
  [./simple_fluid_hostrock]
    type = PorousFlowSingleComponentFluid
    fp = the_simple_fluid
    phase = 0
    block = hostrock
  [../]
  [./relperm_bentonite]
    type = PorousFlowRelativePermeabilityCorey
    n = 1.9
    s_res = 0.59
    sum_s_res = 0.59
    phase = 0
    block = bentonite
  [../]
  [./relperm_backfill]
    type = PorousFlowRelativePermeabilityCorey
    n = 1.9
    s_res = 0.59
    sum_s_res = 0.59
    phase = 0
    block = backfill
  [../]
  [./relperm_hostrock]
    type = PorousFlowRelativePermeabilityCorey
    n = 3
    s_res = 0.01
    sum_s_res = 0.01
    phase = 0
    block = hostrock
  [../]
  [./darcy_velocity_bentonite]
    type = PorousFlowDarcyVelocityMaterial
    gravity = '0 0 -9.81'
    block = bentonite
  [../]
  [./darcy_velocity_backfill]
    type = PorousFlowDarcyVelocityMaterial
    gravity = '0 0 -9.81'
    block = backfill
  [../]
  [./darcy_velocity_hostrock]
    type = PorousFlowDarcyVelocityMaterial
    gravity = '0 0 -9.81'
    block = hostrock
  [../]

# Heat transfer
  [./Thermal_conductivity_bentonite]
    type = ParsedMaterial
    f_name = thermal_conductivity
    args = 'pp'
    function = '(0.72 + (0.48 * 0.41 / (4.804 * 1E6) * pp + 0.5814)) * 365 * 24 * 3600'
    block = 'bentonite'
  [../]
  [./Thermal_conductivity_dt_bentonite]
    type = DerivativeParsedMaterial
    f_name = thermal_conductivity_dT
    args = 'pp'
    function = '0'
    block = 'bentonite'
  [../]
  [./Specific_heat_bentonite]
    type = ParsedMaterial
    f_name = specific_heat
    args = 'pp'
    function = '966'
    block = 'bentonite'
  [../]
  [./Specific_heat_dt_bentonite]
    type = ParsedMaterial
    f_name = specific_heat_dT
    args = 'pp'
    function = '0'
    block = 'bentonite'
  [../]
  [./Thermal_conductivity_backfill]
    type = ParsedMaterial
    f_name = thermal_conductivity
    args = 'pp'
    function = '(1.09 + (1.059 * 0.41 / (4.804 * 1E6) * pp + 0.5814)) * 365 * 24 * 3600'
    block = 'backfill'
  [../]
  [./Thermal_conductivity_dt_backfill]
    type = DerivativeParsedMaterial
    f_name = thermal_conductivity_dT
    args = 'pp'
    function = '0'
    block = 'backfill'
  [../]
  [./Specific_heat_backfill]
    type = ParsedMaterial
    f_name = specific_heat
    args = 'pp'
    function = '981'
    block = 'backfill'
  [../]
  [./Specific_heat_dt_backfill]
    type = ParsedMaterial
    f_name = specific_heat_dT
    args = 'pp'
    function = '0'
    block = 'backfill'
  [../]
  [./Thermal_conductivity_hostrock]
    type = ParsedMaterial
    f_name = thermal_conductivity
    args = 'pp'
    function = '(2.853 + (0.312 * 0.41 / (4.804 * 1E6) * pp + 0.5814)) * 365 * 24 * 3600'
    block = 'hostrock'
  [../]
  [./Thermal_conductivity_dt_hostrock]
    type = DerivativeParsedMaterial
    f_name = thermal_conductivity_dT
    args = 'pp'
    function = '0'
    block = 'hostrock'
  [../]
  [./Specific_heat_hostrock]
    type = ParsedMaterial
    f_name = specific_heat
    args = 'pp'
    function = '820'
    block = 'hostrock'
  [../]
  [./Specific_heat_dt_hostrock]
    type = ParsedMaterial
    f_name = specific_heat_dT
    args = 'pp'
    function = '0'
    block = 'hostrock'
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

[Postprocessors]
# Oxygen corrosion depth
  [./Consumed_O2_surface_mol_per_yr]
    type = ADSideFluxIntegral
    variable = O2
    boundary = spent_fuel
    diffusivity = 5.36E-3
  [../]
  [./Total_O2_surface]
    type = TotalVariableValue
    value = Consumed_O2_surface_mol_per_yr
    execute_on = 'initial timestep_end'
  [../]
  [./Consumed_O2_top_mol_per_yr]
    type = ADSideFluxIntegral
    variable = O2
    boundary = spent_fuel_top
    diffusivity = 5.36E-3
  [../]
  [./Total_O2_top]
    type = TotalVariableValue
    value = Consumed_O2_top_mol_per_yr
    execute_on = 'initial timestep_end'
  [../]
  [./Consumed_O2_bottom_mol_per_yr]
    type = ADSideFluxIntegral
    variable = O2
    boundary = spent_fuel_bottom
    diffusivity = 5.36E-3
  [../]
  [./Total_O2_bottom]
    type = TotalVariableValue
    value = Consumed_O2_bottom_mol_per_yr
    execute_on = 'initial timestep_end'
  [../]

# Sulfide corrosion depth
  [./Consumed_HS-_surface_mol_per_yr]
    type = ADSideFluxIntegral
    variable = HS-
    boundary = spent_fuel
    diffusivity = 6.3072E-5
  [../]
  [./Total_HS-_surface]
    type = TotalVariableValue
    value = Consumed_HS-_surface_mol_per_yr
    execute_on = 'initial timestep_end'
  [../]
  [./Consumed_HS-_top_mol_per_yr]
    type = ADSideFluxIntegral
    variable = HS-
    boundary = spent_fuel_top
    diffusivity = 6.3072E-5
  [../]
  [./Total_HS-_top]
    type = TotalVariableValue
    value = Consumed_HS-_top_mol_per_yr
    execute_on = 'initial timestep_end'
  [../]
  [./Consumed_HS-_bottom_mol_per_yr]
    type = ADSideFluxIntegral
    variable = HS-
    boundary = spent_fuel_bottom
    diffusivity = 6.3072E-5
  [../]
  [./Total_HS-_bottom]
    type = TotalVariableValue
    value = Consumed_HS-_bottom_mol_per_yr
    execute_on = 'initial timestep_end'
  [../]
[]

[Executioner]
  type = Transient
  solve_type = NEWTON
  end_time = 1E3
#  nl_abs_tol = 1E-7
  nl_rel_tol = 1E-2
  [./TimeStepper]
    type = IterationAdaptiveDT
    cutback_factor = 0.88
    dt = 0.001
    growth_factor = 1.12
  [../]
[]

[Outputs]
  exodus = true
  csv = true
[]

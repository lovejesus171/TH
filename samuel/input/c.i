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
    alpha = 2.6E-7 #[Pa]
    m = 0.2941 #[Unitless]
    sat_lr = 0.01
    block = bentonite
  [../]
  [./pc_backfill]
    type = PorousFlowCapillaryPressureVG
    alpha = 3.3E-7 #[Pa]
    m = 0.5 #[Unitless]
    sat_lr = 0.01
    block = backfill
  [../]
  [./pc_hostrock]
    type = PorousFlowCapillaryPressureVG
    alpha = 5E-7 #[Pa]
    m = 0.6 #[Unitless]
    sat_lr = 0.01
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
#  [./O2]
#    order = FIRST
#    family = LAGRANGE
#  [../]
#  [./HS-]
#    order = FIRST
#    family = LAGRANGE
#  [../]
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
#  [./Sat]
#    type = SatCal
#    T = temperature
#    P = pp
#    variable = sat
#    block = 'bentonite backfill hostrock'
#  [../]

# Chemical
#  [./dO2_dt]
#    type = TimeDerivative
#    variable = O2
#    block = 'bentonite backfill hostrock'
#  [../]
#  [./Diff_O2]
#    type = CoefDiffusion
#    variable = O2
#    coef = 9.44E-7
#    block = 'bentonite backfill'
#  [../]
#  [./dHS-_dt]
#    type = TimeDerivative
#    variable = HS-
#    block = 'bentonite backfill hostrock'
#  [../]
#  [./Diff_HS-_bentonite]
#    type = CoefDiffusion
#    variable = HS-
#    coef = 7.8E-12
#    block = 'bentonite'
#  [../]
#  [./Diff_HS-_backfill]
#    type = CoefDiffusion
#    variable = HS-
#    coef = 7.8E-13
#    block = 'backfill'
#  [../]
[]

[AuxVariables]
  [./sat]
    family = MONOMIAL
    order = CONSTANT
  [../]
[]

[AuxKernels]
   [./sautration]
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

# Chemical Species
#  [./IC_O2_bentonite]
#    type = ConstantIC
#    variable = O2
#    value = 5.4  #moles/m3
#    block = 'bentonite'
#  [../]
#  [./IC_O2_backfill]
#    type = ConstantIC
#    variable = O2
#    value = 5.4  #moles/m3
#    block = 'backfill'
#  [../]
#  [./IC_HS-_bentonite]
#    type = ConstantIC
#    variable = HS-
#    value = 0.02585  #moles/m3
#    boundary = 'bentonite_surface'
#  [../]
#  [./IC_HS-_backfill]
#    type = ConstantIC
#    variable = HS-
#    value = 0.02585  #moles/m3
#    boundary = 'backfill_surface'
#  [../]
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
#  [./BC_O2_canister]
#    type = DirichletBC
#    variable = O2
#    value = 0
#    boundary = 'spent_fuel spent_fuel_top spent_fuel_bottom'
#  [../]
#  [./BC_HS-_canister]
#    type = DirichletBC
#    variable = HS-
#    value = 0
#    boundary = 'spent_fuel spent_fuel_top spent_fuel_bottom'
#  [../]
#  [./BC_HS-_bentonite]
#    type = DirichletBC
#    variable = HS-
#    value = 0.02585
#    boundary = 'bentonite_surface'
#  [../]
#  [./BC_HS-_backfill]
#    type = DirichletBC
#    variable = HS-
#    value = 0.02585
#    boundary = 'backfill_surface'
#  [../]
[]

[Functions]
  [./hydro_static]
     type = ParsedFunction
     value = '-1000 * 9.81 * y' #[Pa] positive
  [../]
  [./underground_temp]
     type = ParsedFunction
     value = '288.15-0.03*y'
  [../]
  [./Decay_fn]
     type = ParsedFunction
     vars = 'P0 r h'
     vals = '26830 0.515 4.78'
     value = 'P0 * ((t / (365*24*3600) + 30)^-0.758) / (2 * pi * r * h + 2 * pi * r * r)'
  [../]
[]

[Modules]
  [./FluidProperties]
    [./the_simple_fluid]
      type = SimpleFluidProperties
      bulk_modulus = 2.1E9 #[Pa]
      viscosity = 1E-3 #1E-3/(365*24*3600) [Pas]
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
    permeability = '1.5E-20 0 0   0 1.5E-20 0   0 0 1.5E-20'
  [../]
  [./permeability_backfill]
    type = PorousFlowPermeabilityConst
    block = backfill
    permeability = '1.6E-19 0 0   0 1.6E-19 0   0 0 1.6E-19'
  [../]
  [./permeability_hostrock]
    type = PorousFlowPermeabilityConst
    block = hostrock
    permeability = '1E-18 0 0   0 1E-18 0   0 0 1E-18'
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
    s_res = 0.41
    sum_s_res = 0.41
    phase = 0
    block = bentonite
  [../]
  [./relperm_backfill]
    type = PorousFlowRelativePermeabilityCorey
    n = 1.9
    s_res = 0.41
    sum_s_res = 0.41
    phase = 0
    block = backfill
  [../]
  [./relperm_hostrock]
    type = PorousFlowRelativePermeabilityCorey
    n = 3
    s_res = 0.99
    sum_s_res = 0.99
    phase = 0
    block = hostrock
  [../]

# Heat transfer
  [./Thermal_conductivity_bentonite]
    type = ParsedMaterial
    f_name = thermal_conductivity
    args = 'pp'
    function = '0.72 + (0.48 * ((1-0.59)/(4.905E6-0.101E6)*pp+0.59))'
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
    function = '1.09 + (1.059 * ((1-0.59)/(4.905E6-0.101E6)*pp+0.59))'
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
    function = '2.853 + 0.312'
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

[Executioner]
  type = Transient
  solve_type = Newton
  end_time = 3.15E9
  nl_abs_tol = 1E-7
#  nl_rel_tol = 1E-2
  [./TimeStepper]
    type = IterationAdaptiveDT
    cutback_factor = 0.9
    dt = 31536
    growth_factor = 1.2
  [../]
[]

[Outputs]
  exodus = true
[]

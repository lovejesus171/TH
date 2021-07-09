# Unsaturated Darcy-Richards flow without using an Action

[Mesh]
  file = 'KRS+_4parts_old_light.msh'
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
    block = bentonite
  [../]
  [./pc_backfill]
    type = PorousFlowCapillaryPressureVG
    alpha = 3.3E-7 #[Pa]
    m = 0.5 #[Unitless]
    block = backfill
  [../]
  [./pc_hostrock]
    type = PorousFlowCapillaryPressureVG
    alpha = 5E-7 #[Pa]
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
  [./O2]
    order = FIRST
    family = LAGRANGE
  [../]
  [./HS-]
    order = FIRST
    family = LAGRANGE
  [../]
  
  [./Cu2O]
    order = FIRST
    family = LAGRANGE
  [../]
  [./CuS2]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[Kernels]
# Pressure
  [./dPwater_dt]
    type = PorousFlowMassTimeDerivative
    variable = pp
    block = 'bentonite backfill hostrock'
  [../]
  [./flux_Pwater]
    type = PorousFlowAdvectiveFlux
    variable = pp
    gravity = '0 0 0'
    block = 'bentonite backfill hostrock'
  [../]

# Chemical spcies
  [./dO2_dt]
    type = PrimaryTimeDerivative
    variable = O2
  [../] 
  [./Conv_O2]
    type = PorousFlowBasicAdvection
    variable = O2
    block = 'bentonite backfill hostrock'
  [../]
  [./Diff_O2]
    type = PorousFlowDiffusion
    variable = O2
  [../]

  [./dHS-_dt]
    type = PrimaryTimeDerivative
    variable = HS-
  [../] 
  [./Conv_HS-]
    type = PorousFlowBasicAdvection
    variable = HS-
    block = 'bentonite backfill hostrock'
  [../]
  [./Diff_HS-]
    type = PorousFlowDiffusion
    variable = HS-
  [../]

  [./dCu2O_dt]
    type = PrimaryTimeDerivative
    variable = Cu2O
  [../]
  [./diff_Cu2O]
    type = CoefDiffusion
    coef = 0
    variable = Cu2O
  [../]
  [./dCuS2_dt]
    type = PrimaryTimeDerivative
    variable = CuS2
  [../]
  [./diff_CuS2]
    type = CoefDiffusion
    coef = 0
    variable = CuS2
  [../]
[]

[AuxVariables]
  [./swater]
    family = MONOMIAL
    order = CONSTANT
  [../]
  [./effective_pressure]
    family = MONOMIAL
    order = CONSTANT
  [../]
[]

[AuxKernels]
  [./swater]
    type = PorousFlowPropertyAux
    variable = swater
    property = saturation
  [../]

  [./effective_pressure_bentonite]
    type = ParsedAux
    args = 'swater'
    function = '(4.905E6 - 1.01E5) / 0.41 * swater - 6902973.171'
    variable = effective_pressure
    block = 'bentonite'
  [../]
  [./effective_pressure_backfill]
    type = ParsedAux
    args = 'swater'
    function = '(4.905E6 - 1.01E5) / 0.41 * swater - 6902973.171'
    variable = effective_pressure
    block = 'backfill'
  [../]
  [./effective_pressure_hostrock]
    type = ParsedAux
    args = 'swater'
    function = '(4.905E6 - 1.01E5) / 0.41 * swater - 6902973.171'
    variable = effective_pressure
    block = 'hostrock'
  [../]
[]

[ICs]
# Pressure
  [./IC_P_bentonite]
    type = ConstantIC
    variable = pp
    value = -12002599.86 #[Pa]
    block = 'bentonite'
  [../]
  [./IC_P_backfill]
    type = ConstantIC
    variable = pp
    value = -4146909.322 #[Pa]
    block = 'backfill'
  [../]
  [./IC_P_bentonite_surface]
    type = ConstantIC
    variable = pp
    value = -4207287.175 #[Pa]
    boundary = 'bentonite_surface'
  [../]
  [./IC_P_backfill_surface]
    type = ConstantIC
    variable = pp
    value = -2272727.273 #[Pa]
    boundary = 'backfill_surface'
  [../]
  [./IC_P_hostrock]
    type = ConstantIC
    variable = pp
    value = -3337.783216
    block = 'hostrock'
  [../]

# Chemical species
  [./IC_O2_bentonite]
    type = ConstantIC
    variable = O2
    value = 1.68 #[mol/m3]
    block = 'bentonite'
  [../]
  [./IC_O2_backfill]
    type = ConstantIC
    variable = O2
    value = 1.68 #[mol/m3]
    block = 'backfill'
  [../]
  [./IC_HS-_hostrock]
    type = ConstantIC
    variable = HS-
    value = 0.0907 #[mol/m3]
    block = 'hostrock'
  [../]
  [./IC_HS-_interface]
    type = ConstantIC
    variable = HS-
    value = 0.0907 #[mol/m3]
    boundary = 'bentonite_surface backfill_surface'
  [../]
[]

[BCs]
# Pressure
  [./BC_P]
    type = DirichletBC
    variable = pp
    value = -3338
    boundary = 'top bottom'
  [../]

# Chemical species
  [./BC_O2_canister]
    type = DirichletBC
    variable = O2
    boundary = 'spent_fuel spent_fuel_top spent_fuel_bottom'
    value = 0
  [../]
  [./BC_O2_interface]
    type = NeumannBC
    variable = O2
    boundary = 'bentonite_surface backfill_surface'
    value = 0
  [../]
  [./BC_HS-_canister]
    type = DirichletBC
    variable = HS-
    boundary = 'spent_fuel spent_fuel_top spent_fuel_bottom'
    value = 0
  [../]
  [./BC_HS-_interface]
    type = DirichletBC
    variable = HS-
    boundary = 'bentonite_surface backfill_surface'
    value = 0.0907
  [../]
  [./BC_HS-_boundary]
    type = DirichletBC
    variable = HS-
    boundary = 'top bottom'
    value = 0.0907
  [../]

# Film formation BC
  [./BC_Cu2O]
    type = ChemFluxBC
    variable = Cu2O
    Reactant1 = O2
    Num = 2
    boundary = 'spent_fuel spent_fuel_top spent_fuel_bottom'
  [../]
  [./BC_CuS2]
    type = ChemFluxBC
    variable = CuS2
    Reactant1 = HS-
    Num = 2
    boundary = 'spent_fuel spent_fuel_top spent_fuel_bottom'
  [../]
[]

[Functions]
  [./hydro_static]
     type = ParsedFunction
     value = '-1000 * 9.81 * y' #[Pa] positive
  [../]
[]

[Modules]
  [./FluidProperties]
    [./the_simple_fluid]
      type = SimpleFluidProperties
      viscosity = 3.171E-11 #[Pas]
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
    permeability = '1.6E-19 0 0   0 1.6E-19 0   0 0 1.9E-19'
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
    block = 'bentonite backfill hostrock'
  [../]
  [./massfrac_bentonite]
    type = PorousFlowMassFraction
    block = 'bentonite backfill hostrock'
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
    phase = 0
    block = bentonite
  [../]
  [./relperm_backfill]
    type = PorousFlowRelativePermeabilityCorey
    n = 1.9
    phase = 0
    block = backfill
  [../]
  [./relperm_hostrock]
    type = PorousFlowRelativePermeabilityCorey
    n = 3
    phase = 0
    block = hostrock
  [../]
  [./darcy_velocity_bentonite]
    type = PorousFlowDarcyVelocityMaterial
    gravity = '0 0 0'
    block = 'bentonite backfill hostrock'
  [../]

# Chemical species
  [./Mass_transfer_bentonite]
    type = GenericConstantMaterial
    prop_names = 'diffusivity tortuosity porosity conductivity'
    prop_values = '2.46E-4 0.67 0.41 4.7'
    block = 'bentonite'
  [../]
  [./Mass_transfer_backfill]
    type = GenericConstantMaterial
    prop_names = 'diffusivity tortuosity porosity conductivity'
    prop_values = '2.46E-3 0.67 0.4 4.7'
    block = 'backfill'
  [../]
  [./Mass_transfer_hostrock]
    type = GenericConstantMaterial
    prop_names = 'diffusivity tortuosity porosity conductivity'
    prop_values = '2.46E-3 0.8 0.01 4.7'
    block = 'hostrock'
  [../]
[]

[Postprocessors]
  [./Total_O2_bentonite]
    type = ElementIntegralVariablePostprocessor
    block = 'bentonite'
    variable = O2
   [../]
   [./Total_O2_backfill]
     type = ElementIntegralVariablePostprocessor
     block = 'backfill'
     variable = O2
    [../]
   [./Total_O2_hostrock]
     type = ElementIntegralVariablePostprocessor
     block = 'hostrock'
     variable = O2
    [../]
   [./Total_Cu2O]
     type = ElementIntegralVariablePostprocessor
     block = 'hostrock backfill bentonite'
     variable = Cu2O
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
  end_time = 1E7
#  nl_abs_tol = 1E-7
  nl_rel_tol = 1E-3
  [./TimeStepper]
    type = IterationAdaptiveDT
    cutback_factor = 0.8
    dt = 0.01
    growth_factor = 1.2
  [../]
[]

[Outputs]
  exodus = true
  csv = true
[]

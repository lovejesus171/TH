# Unsaturated Darcy-Richards flow without using an Action

[Mesh]
  file = 'KRS+_4parts_old.msh'
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
[]

[Kernels]
# Pressure
  [./dPwater_dt]
    type = PorousFlowMassTimeDerivative
    variable = pp
    fluid_component = 0
    block = 'bentonite backfill hostrock'
  [../]
  [./flux_Pwater]
    type = PorousFlowAdvectiveFlux
    variable = pp
    fluid_component = 0
    gravity = '0 -9.81 0'
    block = 'bentonite backfill hostrock'
  [../]

# Chemical spcies
  [./dO2_dt]
    type = PrimaryTimeDerivative
    variable = O2
  [../] 
  [./Diff_O2]
    type = PorousFlowDiffusion
    variable = O2
  [../]

  [./dHS-_dt]
    type = PrimaryTimeDerivative
    variable = HS-
  [../]
  [./Diff_HS-]
    type = PorousFlowDiffusion
    variable = HS- 
  [../]
[]

[AuxVariables]
  [./swater]
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
[]

[ICs]
# Pressure
  [./IC_P_bentonite]
    type = ConstantIC
    variable = pp
    value = -12002600 #[Pa]
    block = 'bentonite'
  [../]
  [./IC_P_backfill]
    type = ConstantIC
    variable = pp
    value = -4146910 #[Pa]
    block = 'backfill'
  [../]
  [./IC_P_bentonite_surface]
    type = ConstantIC
    variable = pp
    value = -4207287 #[Pa]
    boundary = 'bentonite_surface'
  [../]
  [./IC_P_backfill_surface]
    type = ConstantIC
    variable = pp
    value = -2272727 #[Pa]
    boundary = 'backfill_surface'
  [../]
  [./IC_P_hostrock]
    type = ConstantIC
    variable = pp
    value = -33783
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
    value = 1.933 #[mol/m3]
    block = 'backfill'
  [../]
  [./IC_HS-_hostrock]
    type = ConstantIC
    variable = HS-
    value = 0.003 #[mol/m3]
    block = 'hostrock'
  [../]
  [./IC_HS-_interface]
    type = ConstantIC
    variable = HS-
    value = 0.003 #[mol/m3]
    boundary = 'bentonite_surface backfill_surface'
  [../]
[]

[BCs]
# Pressure
  [./BC_P]
    type = DirichletBC
    variable = pp
    value = '-33783'
    boundary = 'top bottom'
  [../]

# Chemical species
  [./BC_O2_canister]
    type = DirichletBC
    variable = O2
    boundary = 'spent_fuel spent_fuel_top spent_fuel_bottom'
    value = 0
  [../]

  [./BC_HS-_canister]
    type = DirichletBC
    variable = HS-
    boundary = 'spent_fuel spent_fuel_top spent_fuel_bottom'
    value = 0
  [../]
#  [./BC_HS-_interface]
#    type = DirichletBC
#    variable = HS-
#    boundary = 'bentonite_surface backfill_surface'
#    value = 0.003
#  [../]
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
    gravity = '0 -9.81 0'
    block = 'bentonite backfill hostrock'
  [../]

  [./diff_bentonite]
    type = PorousFlowDiffusivityConst
    diffusion_coeff = '2.46E-4'
    tortuosity = 0.67
    block = bentonite
  [../]
  [./diff_backfill]
    type = PorousFlowDiffusivityConst
    diffusion_coeff = '2.46E-3'
    tortuosity = 0.67
    block = backfill
  [../]
  [./diff_hostrock]
    type = PorousFlowDiffusivityConst
    diffusion_coeff = '2.46E-3'
    tortuosity = 0.8
    block = hostrock
  [../]

# Chemical species
  [./Mass_transfer_bentonite]
    type = GenericConstantMaterial
    prop_names = 'diffusivity tortuosity porosity'
    prop_values = '2.46E-4 0.67 0.41'
    block = 'bentonite'
  [../]
  [./Mass_transfer_backfill]
    type = GenericConstantMaterial
    prop_names = 'diffusivity tortuosity porosity'
    prop_values = '2.46E-3 0.67 0.4'
    block = 'backfill'
  [../]
  [./Mass_transfer_hostrock]
    type = GenericConstantMaterial
    prop_names = 'diffusivity tortuosity porosity'
    prop_values = '2.46E-3 0.8 0.01'
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

#[Postprocessors]
#  [./Consumed_O2_surface]
#    type = ADSideFluxIntegral
#    variable = O2
#    boundary = spent_fuel
#    diffusivity = 4.73
#  [../]
#  [./Total_O2_suface]
#    type = TotalVariableValue
#    value = Consumed_O2_surface
#    execute_on = 'initial timestep_end'
#  [../]
#  [./Consumed_O2_top]
#    type = ADSideFluxIntegral
#    variable = O2
#    boundary = spent_fuel
#    diffusivity = 4.73
#  [../]
#  [./Total_O2_top]
#    type = TotalVariableValue
#    value = Consumed_O2_top
#    execute_on = 'initial timestep_end'
#  [../]
#  [./Consumed_O2_bottom]
#    type = ADSideFluxIntegral
#    variable = O2
#    boundary = spent_fuel
#    diffusivity = 4.73
#  [../]
#  [./Total_O2_bottom]
#    type = TotalVariableValue
#    value = Consumed_O2_bottom
#    execute_on = 'initial timestep_end'
#  [../]

#  [./Consumed_HS-_surface]
#    type = ADSideFluxIntegral
#    variable = HS-
#    boundary = spent_fuel
#    diffusivity = 4.73
#  [../]
#  [./Total_HS-_suface]
#    type = TotalVariableValue
#    value = Consumed_HS-_surface
#    execute_on = 'initial timestep_end'
#  [../]
#  [./Consumed_HS-_top]
#    type = ADSideFluxIntegral
#    variable = HS-
#    boundary = spent_fuel
#    diffusivity = 4.73
#  [../]
#  [./Total_HS-_top]
#    type = TotalVariableValue
#    value = Consumed_HS-_top
#    execute_on = 'initial timestep_end'
#  [../]
#  [./Consumed_HS-_bottom]
#    type = ADSideFluxIntegral
#    variable = HS-
#    boundary = spent_fuel
#    diffusivity = 4.73
#  [../]
#  [./Total_HS-_bottom]
#    type = TotalVariableValue
#    value = Consumed_HS-_bottom
#    execute_on = 'initial timestep_end'
#  [../]
#[]

[Executioner]
  type = Transient
  solve_type = NEWTON
  end_time = 1E7
#  nl_abs_tol = 1E-7
  nl_rel_tol = 1E-3
  [./TimeStepper]
    type = IterationAdaptiveDT
    cutback_factor = 0.88
    dt = 0.01
    growth_factor = 1.2
  [../]
[]

[Outputs]
  exodus = true
  csv = true
[]

# Unsaturated Darcy-Richards flow without using an Action
# Initial condition: CSM 4-1a

[Mesh]
  file = 'KRS+_4parts_new_light.msh'
  construct_side_list_from_node_list = true
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
  [./Fe2+]
    order = FIRST
    family = LAGRANGE
  [../]
  [./gypsum]
    order = FIRST
    family = LAGRANGE
  [../]
  [./SO4_2-]
    order = FIRST
    family = LAGRANGE
  [../]
  [./FeS]
    order = FIRST
    family = LAGRANGE
  [../]
  [./ABS]
    order = FIRST
    family = LAGRANGE
  [../]
  [./SRB1]
    order = FIRST
    family = LAGRANGE
  [../]
  [./SRB2]
    order = FIRST
    family = LAGRANGE
  [../]
  [./CH3CO2H]
    order = FIRST
    family = LAGRANGE
  [../]
  [./organic]
    order = FIRST
    family = LAGRANGE
  [../]
  
  [./Cu2O]
    order = FIRST
    family = LAGRANGE
  [../]
  [./Cu2S]
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
    type = O2TimeDerivative
    variable = O2
  [../] 
  [./Conv_O2]
    type = PorousFlowBasicAdvection
    variable = O2
  [../]
  [./Diff_O2]
    type = TwoPhaseDiffusion
    variable = O2
    Diffusion_coeff_aq = 5.36112 # m2/yr
    Diffusion_coeff_gas = 56134.08 # m2/yr
  [../]

  [./dHS-_dt]
    type = AqPhaseTimeDerivative
    variable = HS-
  [../] 
  [./Conv_HS-]
    type = PorousFlowBasicAdvection
    variable = HS-
  [../]
  [./Diff_HS-]
    type = AqPhaseDiffusion
    variable = HS-
    Diffusion_coeff_aq = 1.5768 # m2/yr
  [../]

  [./dFe2+_dt]
    type = AqPhaseTimeDerivative
    variable = Fe2+
  [../] 
  [./Conv_Fe2+]
    type = PorousFlowBasicAdvection
    variable = Fe2+
  [../]
  [./Diff_Fe2+]
    type = AqPhaseDiffusion
    variable = Fe2+
    Diffusion_coeff_aq = 1.5768 # m2/yr
  [../]

  [./dSO4_2-_dt]
    type = AqPhaseTimeDerivative
    variable = SO4_2-
  [../] 
  [./Conv_SO4_2-]
    type = PorousFlowBasicAdvection
    variable = SO4_2-
  [../]
  [./Diff_SO4_2-]
    type = AqPhaseDiffusion
    variable = SO4_2-
    Diffusion_coeff_aq = 3.1536 # m2/yr
  [../]

  [./dCH3CO2H_dt]
    type = AqPhaseTimeDerivative
    variable = CH3CO2H
  [../] 
  [./Conv_CH3CO2H]
    type = PorousFlowBasicAdvection
    variable = CH3CO2H
  [../]
  [./Diff_CH3CO2H]
    type = AqPhaseDiffusion
    variable = CH3CO2H
    Diffusion_coeff_aq = 3.1536 # m2/yr
  [../]

  [./dCu2O_dt]
    type = TimeDerivative
    variable = Cu2O
  [../]
  [./diff_Cu2O]
    type = CoefDiffusion
    coef = 0.5e-20
    variable = Cu2O
  [../]
  [./dCu2S_dt]
    type = TimeDerivative
    variable = Cu2S
  [../]
  [./diff_CuS2]
    type = CoefDiffusion
    coef = 0.5e-20
    variable = Cu2S
  [../]
  [./dgypsum_dt]
    type = TimeDerivative
    variable = gypsum
  [../]
  [./dFeS_dt]
    type = TimeDerivative
    variable = FeS
  [../]
  [./dorganic_dt]
    type = TimeDerivative
    variable = organic
  [../]
  [./dSRB1_dt]
    type = TimeDerivative
    variable = SRB1
  [../]
  [./dSRB2_dt]
    type = TimeDerivative
    variable = SRB2
  [../]
  [./dABS_dt]
    type = TimeDerivative
    variable = ABS
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
[]

#[ChemicalReactions]
#  [./Network]
#    species = 'O2 Fe2+ gypsum SO4_2- HS- FeS CU2O CU2S ABS'
#    track_rates = True
  
#    equation_variables = 'SRB1 SRB2 swater'

#    reactions = 'Fe2+ + HS- -> FeS         : 31536000
#                O2 -> ABS                 : 6.93792e-4 * swater * 0.438
#                gypsum -> SO4_2-          : 252.288
#                organic -> CH3CO2H        : 6.93792e-3
#                SO4_2- + CH3CO2H -> HS-   : 409.968 * SRB1
#                SO4_2- -> HS-             : 179.7552 * SRB2
#                Cu2O + HS- -> Cu2S        : 6.275664E7'

#    block = 'bentonite hostrock backfill'
#  [../]
#[]

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
    value = 0.000361 #[mol/m3]
    block = 'bentonite'
  [../]
  [./IC_O2_backfill]
    type = ConstantIC
    variable = O2
    value = 0.000213 #[mol/m3]
    block = 'backfill'
  [../]
  [./IC_Fe2+_backfill]
    type = ConstantIC
    variable = Fe2+
    value = 1E-5 # mol/m3
    block = 'hostrock'
  [../]

  [./IC_HS-_hostrock]
    type = ConstantIC
    variable = HS-
    value = 1E-5 # mol/m3
    block = 'hostrock'
  [../]

  [./IC_SO4_2-_bentonite]
    type = ConstantIC
    variable = SO4_2-
    value = 0.01546 # mol/m3
    block = 'bentonite'
  [../]
  [./IC_SO4_2-_backfill]
    type = ConstantIC
    variable = SO4_2-
    value = 0.0142 # mol/m3
    block = 'backfill'
  [../]
  [./IC_SO4_2-_hostrock]
    type = ConstantIC
    variable = SO4_2-
    value = 0.0094 # mol/m3
    block = 'hostrock'
  [../]

  [./IC_gypsum_bentonite]
    type = ConstantIC
    variable = gypsum
    value = 0.0365 # mol/m3
    block = 'bentonite'
  [../]
  [./IC_gypsum_backfill]
    type = ConstantIC
    variable = gypsum
    value = 0.19 # mol/m3
    block = 'backfill'
  [../]

  [./IC_organic_bentonite]
    type = ConstantIC
    variable = organic
    value = 0.0105 # mol/m3
    block = 'bentonite'
  [../]
  [./IC_organic_backfill]
    type = ConstantIC
    variable = organic
    value = 0.00573 # mol/m3
    block = 'backfill'
  [../]

  [./IC_SRB1_bentonite]
    type = ConstantIC
    variable = SRB1
    value = 9E-8 # mol/m3
    block = 'bentonite'
  [../]
  [./IC_SRB1_backfill]
    type = ConstantIC
    variable = SRB1
    value = 1E-6 # mol/m3
    block = 'backfill'
  [../]
  [./IC_SRB1_hostrock]
    type = ConstantIC
    variable = SRB1
    value = 3E-8 # mol/m3
    block = 'hostrock'
  [../]

  [./IC_SRB2_bentonite]
    type = ConstantIC
    variable = SRB2
    value = 9E-8 # mol/m3
    block = 'bentonite'
  [../]
  [./IC_SRB2_backfill]
    type = ConstantIC
    variable = SRB2
    value = 1E-6 # mol/m3
    block = 'backfill'
  [../]
  [./IC_SRB2_hostrock]
    type = ConstantIC
    variable = SRB2
    value = 3E-8 # mol/m3
    block = 'hostrock'
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

#Chemical species
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

  [./BC_Fe2+_hostrock]
    type = DirichletBC
    variable = Fe2+
    boundary = 'top bottom'
    value = 1E-5
  [../]
  [./BC_HS-_hostrock]
    type = DirichletBC
    variable = HS-
    boundary = 'top bottom'
    value = 1E-5
  [../]
  [./BC_SO4_2-_canister]
    type = DirichletBC
    variable = SO4_2-
    boundary = 'top bottom'
    value = 0.0094
  [../]

# Chemical species accumulation
  [./BC_O2_accumulation]
    type = ChemFluxBC
    variable = Cu2O
    Reactant1 = O2
    Num = 4
    Diffusion_coeff = 5.36112
    boundary = 'spent_fuel spent_fuel_top spent_fuel_bottom'
  [../]
  [./BC_HS-_accumulation]
    type = ChemFluxBC
    variable = Cu2S
    Reactant1 = HS-
    Num = 2
    Diffusion_coeff = 1.5768
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
    prop_names = 'tortuosity porosity van_genuchten_coeff van_genuchten_parameter'
    prop_values = '0.67 0.41 0.2941 3.8462E6'
    block = 'bentonite'
  [../]
  [./Mass_transfer_backfill]
    type = GenericConstantMaterial
    prop_names = 'tortuosity porosity van_genuchten_coeff van_genuchten_parameter'
    prop_values = '0.67 0.4 0.5 3.03E6'
    block = 'backfill'
  [../]
  [./Mass_transfer_hostrock]
    type = GenericConstantMaterial
    prop_names = 'tortuosity porosity van_genuchten_coeff van_genuchten_parameter'
    prop_values = '0.8 0.01 0.6 2E6'
    block = 'hostrock'
  [../]
[]

[Postprocessors]
# Total amount of O2 
  [./O2_bentonite]
    type = ElementIntegralVariablePostprocessor
    block = 'bentonite'
    variable = O2
  [../]
  [./O2_backfill]
     type = ElementIntegralVariablePostprocessor
     block = 'backfill'
     variable = O2
  [../]
  [./O2_hostrock]
     type = ElementIntegralVariablePostprocessor
     block = 'hostrock'
     variable = O2
  [../]
  [./O2_total]
     type = ElementIntegralVariablePostprocessor
     block = 'bentonite backfill hostrock'
     variable = O2
  [../]

# Total amount of HS- 
  [./Total_HS-_bentonite]
    type = ElementIntegralVariablePostprocessor
    block = 'bentonite'
    variable = HS-
  [../]
  [./Total_HS-_backfill]
     type = ElementIntegralVariablePostprocessor
     block = 'backfill'
     variable = HS-
  [../]
  [./Total_HS-_hostrock]
     type = ElementIntegralVariablePostprocessor
     block = 'hostrock'
     variable = HS-
  [../]
  [./Total_HS-_total]
     type = ElementIntegralVariablePostprocessor
     block = 'bentonite backfill hostrock'
     variable = HS-
  [../]
 
  [./O2_side]
    type = SideFluxIntegral
    boundary = 'spent_fuel'
    variable = O2
    diffusivity = 1.4727 # m2/yr 
  [../]
  [./O2_total_side]
    type = TotalVariableValue
    value = O2_side
  [../]
  [./O2_top]
    type = SideFluxIntegral
    boundary = 'spent_fuel_top'
    variable = O2
    diffusivity = 1.4727 # m2/yr 
  [../]
  [./O2_total_top]
    type = TotalVariableValue
    value = O2_top
  [../]
  [./O2_bottom]
    type = SideFluxIntegral
    boundary = 'spent_fuel_bottom'
    variable = O2
    diffusivity = 1.4727 # m2/yr 
  [../]
  [./O2_total_bottom]
    type = TotalVariableValue
    value = O2_bottom
  [../]

  [./HS-_side]
    type = SideFluxIntegral
    boundary = 'spent_fuel'
    variable = HS-
    diffusivity = 0.4331 # m2/yr 
  [../]
  [./HS-_total_side]
    type = TotalVariableValue
    value = HS-_side
  [../]
  [./HS-_top]
    type = SideFluxIntegral
    boundary = 'spent_fuel_top'
    variable = HS-
    diffusivity = 0.4331 # m2/yr 
  [../]
  [./HS-_total_top]
    type = TotalVariableValue
    value = HS-_top
  [../]
  [./HS-_bottom]
    type = SideFluxIntegral
    boundary = 'spent_fuel_bottom'
    variable = HS-
    diffusivity = 0.4331 # m2/yr 
  [../]
  [./HS-_total_bottom]
    type = TotalVariableValue
    value = HS-_bottom
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
#  nl_rel_tol = 1E
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

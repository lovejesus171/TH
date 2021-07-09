# Unsaturated Darcy-Richards flow without using an Action
# Initial condition: CSM 4-1a

[Mesh]
  file = 'KRS+_4parts_new_light_light.msh'
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
#    type = PrimaryTimeDerivative
    variable = O2
  [../] 
  [./Conv_O2]
    type = PorousFlowBasicAdvection
    variable = O2
  [../]
  [./Diff_O2]
#    type = PorousFlowDiffusion
    type = TwoPhaseDiffusion
    variable = O2
#    Diffusion_coeff = 0.0536112
    Diffusion_coeff_aq = 0.0536112 # m2/yr
    Diffusion_coeff_gas = 561.3408 # m2/yr
  [../]

  [./dHS-_dt]
    type = AqPhaseTimeDerivative
#    type = PrimaryTimeDerivative
    variable = HS-
  [../] 
  [./Conv_HS-]
    type = PorousFlowBasicAdvection
    variable = HS-
  [../]
  [./Diff_HS-]
    type = AqPhaseDiffusion
#    type = PorousFlowDiffusion
    variable = HS-
    Diffusion_coeff_aq = 0.015768 # m2/yr
  [../]

  [./dFe2+_dt]
    type = AqPhaseTimeDerivative
#    type = PrimaryTimeDerivative
    variable = Fe2+
  [../] 
  [./Conv_Fe2+]
    type = PorousFlowBasicAdvection
    variable = Fe2+
  [../]
  [./Diff_Fe2+]
    type = AqPhaseDiffusion
#    type = PorousFlowDiffusion
    variable = Fe2+
    Diffusion_coeff_aq = 0.015768 # m2/yr
  [../]

  [./dSO4_2-_dt]
    type = AqPhaseTimeDerivative
#    type = PrimaryTimeDerivative
    variable = SO4_2-
  [../] 
  [./Conv_SO4_2-]
    type = PorousFlowBasicAdvection
    variable = SO4_2-
  [../]
  [./Diff_SO4_2-]
    type = AqPhaseDiffusion
#    type = PorousFlowDiffusion
    variable = SO4_2-
    Diffusion_coeff_aq = 0.031536 # m2/yr
  [../]

  [./dCH3CO2H_dt]
    type = AqPhaseTimeDerivative
#    type = PrimaryTimeDerivative
    variable = CH3CO2H
  [../] 
  [./Conv_CH3CO2H]
    type = PorousFlowBasicAdvection
    variable = CH3CO2H
  [../]
  [./Diff_CH3CO2H]
    type = AqPhaseDiffusion
#    type = PorousFlowDiffusion
    variable = CH3CO2H
    Diffusion_coeff_aq = 0.031536 # m2/yr
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
  [./diff_gypsum]
    type = CoefDiffusion
    coef = 0.5e-20
    variable = gypsum
  [../]

  [./dFeS_dt]
    type = TimeDerivative
    variable = FeS
  [../]
  [./diff_FeS]
    type = CoefDiffusion
    coef = 0.5e-20
    variable = FeS
  [../]

  [./dorganic_dt]
    type = TimeDerivative
    variable = organic
  [../]
  [./diff_organic]
    type = CoefDiffusion
    coef = 0.5e-20
    variable = organic
  [../]

  [./dSRB1_dt]
    type = TimeDerivative
    variable = SRB1
  [../]
  [./diff_SRB1]
    type = CoefDiffusion
    coef = 0.5e-20
    variable = SRB1
  [../]

  [./dSRB2_dt]
    type = TimeDerivative
    variable = SRB2
  [../]
  [./diff_SRB2]
    type = CoefDiffusion
    coef = 0.5e-20
    variable = SRB2
  [../]

  [./dABS_dt]
    type = TimeDerivative
    variable = ABS
  [../]
  [./diff_ABS]
    type = CoefDiffusion
    coef = 0.5e-20
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

[ChemicalReactions]
  [./Network]
    species = 'O2 Fe2+ gypsum SO4_2- HS- FeS ABS'
    track_rates = True
 
    equation_variables = 'SRB1 SRB2 swater porosity'

    reactions = 'Fe2+ + HS- -> FeS         : 31536
                 O2 -> ABS                 : 6.93792e-3 * swater * porosity
                 gypsum -> SO4_2-          : 252.288
                 organic -> CH3CO2H        : 6.93792e-3
                 SO4_2- + CH3CO2H -> HS-   : 409.968 * SRB1
                 SO4_2- -> HS-             : 179.7552 * SRB2'

    block = 'bentonite hostrock backfill'
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
    value = 0.361 #[mol/m3]
    block = 'bentonite'
  [../]
  [./IC_O2_backfill]
    type = ConstantIC
    variable = O2
    value = 0.213 #[mol/m3]
    block = 'backfill'
  [../]
  [./IC_Fe2+_backfill]
    type = ConstantIC
    variable = Fe2+
    value = 1E-2 # mol/m3
    block = 'hostrock'
  [../]

  [./IC_HS-_hostrock]
    type = ConstantIC
    variable = HS-
    value = 1E-2 # mol/m3
    block = 'hostrock'
  [../]

  [./IC_SO4_2-_bentonite]
    type = ConstantIC
    variable = SO4_2-
    value = 15.46 # mol/m3
    block = 'bentonite'
  [../]
  [./IC_SO4_2-_backfill]
    type = ConstantIC
    variable = SO4_2-
    value = 14.2 # mol/m3
    block = 'backfill'
  [../]
  [./IC_SO4_2-_hostrock]
    type = ConstantIC
    variable = SO4_2-
    value = 9.4 # mol/m3
    block = 'hostrock'
  [../]

  [./IC_gypsum_bentonite]
    type = ConstantIC
    variable = gypsum
    value = 36.5 # mol/m3
    block = 'bentonite'
  [../]
  [./IC_gypsum_backfill]
    type = ConstantIC
    variable = gypsum
    value = 190 # mol/m3
    block = 'backfill'
  [../]

  [./IC_organic_bentonite]
    type = ConstantIC
    variable = organic
    value = 10.5 # mol/m3
    block = 'bentonite'
  [../]
  [./IC_organic_backfill]
    type = ConstantIC
    variable = organic
    value = 5.73 # mol/m3
    block = 'backfill'
  [../]

  [./IC_SRB1_bentonite]
    type = ConstantIC
    variable = SRB1
    value = 9E-5 # mol/m3
    block = 'bentonite'
  [../]
  [./IC_SRB1_backfill]
    type = ConstantIC
    variable = SRB1
    value = 1E-3 # mol/m3
    block = 'backfill'
  [../]
  [./IC_SRB1_hostrock]
    type = ConstantIC
    variable = SRB1
    value = 3E-5 # mol/m3
    block = 'hostrock'
  [../]

  [./IC_SRB2_bentonite]
    type = ConstantIC
    variable = SRB2
    value = 9E-5 # mol/m3
    block = 'bentonite'
  [../]
  [./IC_SRB2_backfill]
    type = ConstantIC
    variable = SRB2
    value = 1E-3 # mol/m3
    block = 'backfill'
  [../]
  [./IC_SRB2_hostrock]
    type = ConstantIC
    variable = SRB2
    value = 3E-5 # mol/m3
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
    value = 1E-2
  [../]
  [./BC_HS-_hostrock]
    type = DirichletBC
    variable = HS-
    boundary = 'top bottom'
    value = 1E-2
  [../]
  [./BC_SO4_2-_canister]
    type = DirichletBC
    variable = SO4_2-
    boundary = 'top bottom'
    value = 9.4
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
    prop_values = '0.1 0.05 0.2941 3.8462E6'
    block = 'bentonite'
  [../]
  [./Mass_transfer_backfill]
    type = GenericConstantMaterial
    prop_names = 'tortuosity porosity van_genuchten_coeff van_genuchten_parameter'
    prop_values = '0.1 0.22 0.5 3.03E6'
    block = 'backfill'
  [../]
  [./Mass_transfer_hostrock]
    type = GenericConstantMaterial
    prop_names = 'tortuosity porosity van_genuchten_coeff van_genuchten_parameter'
    prop_values = '0.1 0.003 0.6 2E6'
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
    type = SideDiffusiveFluxIntegral
    boundary = 'spent_fuel'
    variable = O2
    diffusivity = 0.0014727 # m2/yr 
  [../]
  [./O2_total_side]
    type = TotalVariableValue
    value = O2_side
  [../]
  [./O2_top]
    type = SideDiffusiveFluxIntegral
    boundary = 'spent_fuel_top'
    variable = O2
    diffusivity = 0.0014727 # m2/yr 
  [../]
  [./O2_total_top]
    type = TotalVariableValue
    value = O2_top
  [../]
  [./O2_bottom]
    type = SideDiffusiveFluxIntegral
    boundary = 'spent_fuel_bottom'
    variable = O2
    diffusivity = 0.0014727 # m2/yr 
  [../]
  [./O2_total_bottom]
    type = TotalVariableValue
    value = O2_bottom
  [../]

  [./HS-_side]
    type = SideDiffusiveFluxIntegral
    boundary = 'spent_fuel'
    variable = HS-
    diffusivity = 0.0004331 # m2/yr 
  [../]
  [./HS-_total_side]
    type = TotalVariableValue
    value = HS-_side
  [../]
  [./HS-_top]
    type = SideDiffusiveFluxIntegral
    boundary = 'spent_fuel_top'
    variable = HS-
    diffusivity = 0.0004331 # m2/yr 
  [../]
  [./HS-_total_top]
    type = TotalVariableValue
    value = HS-_top
  [../]
  [./HS-_bottom]
    type = SideDiffusiveFluxIntegral
    boundary = 'spent_fuel_bottom'
    variable = HS-
    diffusivity = 0.0004331 # m2/yr 
  [../]
  [./HS-_total_bottom]
    type = TotalVariableValue
    value = HS-_bottom
  [../]

  [./Fe2+_total]
     type = ElementIntegralVariablePostprocessor
     block = 'bentonite backfill hostrock'
     variable = Fe2+
  [../]

  [./FeS_total]
     type = ElementIntegralVariablePostprocessor
     block = 'bentonite backfill hostrock'
     variable = FeS
  [../]

  [./gypsum_total]
     type = ElementIntegralVariablePostprocessor
     block = 'bentonite backfill hostrock'
     variable = gypsum
  [../]

  [./SO4_2-_total]
     type = ElementIntegralVariablePostprocessor
     block = 'bentonite backfill hostrock'
     variable = SO4_2-
  [../]

  [./organic_total]
     type = ElementIntegralVariablePostprocessor
     block = 'bentonite backfill hostrock'
     variable = organic
  [../]

  [./CH3CO2H_total]
     type = ElementIntegralVariablePostprocessor
     block = 'bentonite backfill hostrock'
     variable = CH3CO2H
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
    cutback_factor = 0.9
    dt = 0.000001
    growth_factor = 1.1
  [../]
[]

[Outputs]
  exodus = true
[]

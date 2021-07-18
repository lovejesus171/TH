# Unsaturated Darcy-Richards flow without using an Action

[Mesh]
  file = 'KRS+_4parts_new_light_light.msh'
  construct_side_list_from_node_list = true
[]

[UserObjects]
  [./dictator]
    type = PorousFlowDictator
    porous_flow_vars = 'pp T'
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
  [./T]
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
  [./SO4_2-]
    order = FIRST
    family = LAGRANGE
  [../]
  [./Fe2+]
    order = FIRST
    family = LAGRANGE
  [../]
  [./Cu2+]
    order = FIRST
    family = LAGRANGE
  [../]
  [./CuCl2-]
    order = FIRST
    family = LAGRANGE
  [../]
  [./H2S]
    order = FIRST
    family = LAGRANGE
  [../]
  [./Cl-]
    order = FIRST
    family = LAGRANGE
  [../]
  [./FeS]
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
  [./O2consum]
    order = FIRST
    family = LAGRANGE
  [../]
  [./ABS]
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
  [./gypsum]
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
 
# Heat Transfer
  [./dT_dt]
    type = PorousFlowEnergyTimeDerivative
    variable = T
    block = 'bentonite backfill hostrock'
  [../]
  [./Heat_advection]
    type = PorousFlowHeatAdvection
    variable = T
    gravity = '0 0 0'
    block = 'bentonite backfill hostrock'
  [../]
  [./Heat_conduction]
    type = PorousFlowHeatConduction
    variable = T
    block = 'bentonite backfill hostrock'
  [../]

# Chemical species
  [./dO2_dt]
    type = TwoPhaseTimeDerivative
    variable = O2
  [../]
  [./Adve_O2]
    type = PorousFlowBasicAdvection
    variable = O2
  [../]
  [./Diff_O2]
    type = TwoPhaseDiffusion
    variable = O2
    D_aq = RD_O2_aq
    D_gas = RD_O2_gas
    EA_aq = REA_O2_aq
    EA_gas = REA_O2_gas
    T = T
  [../]

  [./dHS-_dt]
    type = AqPhaseTimeDerivative
    variable = HS-
  [../]
  [./Adve_HS-]
    type = PorousFlowBasicAdvection
    variable = HS-
  [../]
  [./Diff_HS-]
    type = AqPhaseDiffusion
    variable = HS-
    D_aq = RD_HS_aq
    EA_aq = REA_HS_aq
    T = T
  [../]

  [./dFe2+_dt]
    type = AqPhaseTimeDerivative
    variable = Fe2+
  [../]
  [./Adve_Fe2+]
    type = PorousFlowBasicAdvection
    variable = Fe2+
  [../]
  [./Diff_Fe2+]
    type = AqPhaseDiffusion
    variable = Fe2+
    D_aq = RD_Fe2_aq
    EA_aq = REA_Fe2_aq
    T = T
  [../]

  [./dSO4_2-_dt]
    type = AqPhaseTimeDerivative
    variable = SO4_2-
  [../]
  [./Adve_SO4_2-]
    type = PorousFlowBasicAdvection
    variable = SO4_2-
  [../]
  [./Diff_SO4_2-]
    type = AqPhaseDiffusion
    variable = SO4_2-
    D_aq = RD_SO4_2_aq
    EA_aq = REA_SO4_2_aq
    T = T
  [../]

  [./dCu2+_dt]
    type = AqPhaseTimeDerivative
    variable = Cu2+
  [../]
  [./Adve_Cu2+]
    type = PorousFlowBasicAdvection
    variable = Cu2+
  [../]
  [./Diff_Cu2+]
    type = AqPhaseDiffusion
    variable = Cu2+
    D_aq = RD_Cu2_aq
    EA_aq = REA_Cu2_aq
    T = T
  [../]

  [./dCl-_dt]
    type = AqPhaseTimeDerivative
    variable = Cl-
  [../]
  [./Adve_Cl-]
    type = PorousFlowBasicAdvection
    variable = Cl-
  [../]
  [./Diff_Cl-]
    type = AqPhaseDiffusion
    variable = Cl-
    D_aq = RD_Cl_aq
    EA_aq = REA_Cl_aq
    T = T
  [../]

  [./dCuCl2-_dt]
    type = AqPhaseTimeDerivative
    variable = CuCl2-
  [../]
  [./Adve_CuCl2-]
    type = PorousFlowBasicAdvection
    variable = CuCl2-
  [../]
  [./Diff_CuCl2-]
    type = AqPhaseDiffusion
    variable = CuCl2-
    D_aq = RD_CuCl2_aq
    EA_aq = REA_CuCl2_aq
    T = T
  [../]

  [./dH2S_dt]
    type = GasPhaseTimeDerivative
    variable = H2S
  [../]
  [./Adve_H2S]
    type = PorousFlowBasicAdvection
    variable = H2S
  [../]
  [./Diff_H2S]
    type = GasPhaseDiffusion
    variable = H2S
    D_gas = RD_H2S_gas
    EA_gas = REA_H2S_gas
    T = T
  [../]

  [./dgypsum_dt]
    type = PrimaryTimeDerivative
    variable = gypsum
  [../]
  [./Diff_gypsum]
    type = CoefDiffusion
    variable = gypsum
    coef = 0.5e-20
  [../]

# Chemical species accumulation

  [./dFeS_dt]
    type = PrimaryTimeDerivative
    variable = FeS
  [../]
  [./Diff_FeS]
    type = CoefDiffusion
    coef = 0.5e-20
    variable = FeS
  [../]

  [./dABS_dt]
    type = PrimaryTimeDerivative
    variable = ABS
  [../]
  [./Diff_ABS]
    type = CoefDiffusion
    coef = 0.5e-20
    variable = ABS
  [../]

  [./dSRB1_dt]
    type = PrimaryTimeDerivative
    variable = SRB1
  [../]
  [./dSRB2_dt]
    type = PrimaryTimeDerivative
    variable = SRB2
  [../]
  [./dCH3CO2H_dt]
    type = PrimaryTimeDerivative
    variable = CH3CO2H
  [../]
  [./dCu2O_dt]
    type = PrimaryTimeDerivative
    variable = Cu2O
  [../]
  [./dCu2S_dt]
    type = PrimaryTimeDerivative
    variable = Cu2S
  [../]
  [./dorganic_dt]
    type = PrimaryTimeDerivative
    variable = organic
  [../]
  [./dO2consum_dt]
    type = PrimaryTimeDerivative
    variable = O2consum
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
[]

#[ChemicalReactions]
#  [./Network]
#    species = 'O2 Fe2+ gypsum SO4_2- HS- FeS ABS'
#    track_rates = True

#    equation_variables = 'SRB1 SRB2 swater porosity O2consum'

#    reactions = 'Fe2+ + HS- -> FeS          : 3.15E7 * swater * porosity
#                 O2 -> ABS                  : 6.94e-3 * swater * porosity * O2consum
#                 organic -> CH3CO2H         : 6.94e-4 * swater * porosity
#                 gypsum -> SO4_2-           : 252 * swater * porosity
#                 SO4_2- + CH3CO2H -> HS-    : 410 * SRB1 * swater * porosity'

#    block = 'bentonite hostrock backfill'
#  [../]
#[]

[ICs]
# Temperature
   [./IC_T]
    type = ConstantIC
    variable = T
    value = 298.15
    block = 'bentonite backfill'
   [../]
   [./IC_T_hostrock]
    type = FunctionIC
    variable = T
    function = underground_temp
    block = 'hostrock'
   [../]

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
    value = 0.361 # mol/m3
    block = 'bentonite'
  [../]
  [./IC_O2_backfill]
    type = ConstantIC
    variable = O2
    value = 0.213 # mol/m3
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
    value = 0.0907 # mol/m3
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
 
  [./IC_O2consum]
    type = ConstantIC
    variable = O2consum
    value = 1 # mol/m3
    block = 'bentonite backfill hostrock'
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

# Temperature
  [./BC_T_top]
    type = DirichletBC
    variable = T
    value = '296.65'
    boundary = 'top'
  [../]
  [./BC_T_bottom]
    type = DirichletBC
    variable = T
    value = '299.65'
    boundary = 'bottom'
  [../]
 
# Heat Flux
  [./BC_HeatFlux]
    type = FunctionNeumannBC
    variable = T
    boundary = 'spent_fuel spent_fuel_top spent_fuel_bottom'
    function = Decay_fn
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

  [./BC_HS-_boundary]
    type = DirichletBC
    variable = HS-
    boundary = 'top bottom'
    value = 0.0907
  [../]
  [./BC_SO4_2-_boundary]
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
    Diffusion_coeff = Diffusivity_O2
    Num = 4
    boundary = 'spent_fuel spent_fuel_top spent_fuel_bottom'
  [../]
  [./BC_HS-_accumulation]
    type = ChemFluxBC
    variable = Cu2S
    Reactant1 = HS-
    Diffusion_coeff = Diffusivity_HS
    Num = 2
    boundary = 'spent_fuel spent_fuel_top spent_fuel_bottom'
  [../]
[]

[Functions]
  [./hydro_static]
     type = ParsedFunction
     value = '-1000 * 9.81 * y' #[Pa] positive
  [../]
  [./underground_temp]
     type = ParsedFunction
     value = '283.15 - 0.03 * y'
  [../]
  [./Decay_fn]
     type = ParsedFunction
     vars = 'P0 r h yts'
     vals = '26830 0.51 4.83 31536000'
     value = 'P0 * yts * ((t + 40)^-0.758) / (2 * pi * r * h + 2 * pi * r * r)'
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
    temperature = T
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

# Heat transfer
  [./Thermal_conductivity_bentonite]
    type = PorousFlowThermalConductivityIdeal
    dry_thermal_conductivity = '2.271E7 0 0  0 2.271E7 0  0 0 2.271E7'
    wet_thermal_conductivity = '3.785E7 0 0  0 3.785E7 0  0 0 3.785E7'
    block = 'bentonite'
  [../]
  [./Internal_energy_bentonite]
    type = PorousFlowMatrixInternalEnergy
    specific_heat_capacity = 966
    density = 2740
    block = 'bentonite'
  [../]

  [./Thermal_conductivity_backfill]
    type = PorousFlowThermalConductivityIdeal
    dry_thermal_conductivity = '3.44E7 0 0  0 3.44E7 0  0 0 3.44E7'
    wet_thermal_conductivity = '6.78E7 0 0  0 6.78E7 0  0 0 6.78E7'
    block = 'backfill'
  [../]
  [./Internal_energy_backfill]
    type = PorousFlowMatrixInternalEnergy
    specific_heat_capacity = 981
    density = 2680
    block = 'backfill'
  [../]

  [./Thermal_conductivity_hostrock]
    type = PorousFlowThermalConductivityIdeal
    dry_thermal_conductivity = '9E7 0 0  0 9E7 0  0 0 9E7'
    wet_thermal_conductivity = '1E8 0 0  0 1E8 0  0 0 1E8'
    block = 'hostrock'
  [../]
  [./Internal_energy_hostrock]
    type = PorousFlowMatrixInternalEnergy
    specific_heat_capacity = 820
    density = 2650
    block = 'hostrock'
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

  [./Diffusion_coeff]
    type = DiffusionProperty
    T = T
    P = pp
    block = 'bentonite backfill hostrock'
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
  [./O2_side]
    type = SideDiffusiveFluxIntegral
    boundary = 'spent_fuel'
    variable = O2
    diffusivity = Diffusivity_O2
  [../]
  [./O2_total_side]
    type = TotalVariableValue
    value = O2_side
  [../]
  [./O2_top]
    type = SideDiffusiveFluxIntegral
    boundary = 'spent_fuel_top'
    variable = O2
    diffusivity = Diffusivity_O2
  [../]
  [./O2_total_top]
    type = TotalVariableValue
    value = O2_top
  [../]
  [./O2_bottom]
    type = SideDiffusiveFluxIntegral
    boundary = 'spent_fuel_bottom'
    variable = O2
    diffusivity = Diffusivity_O2
  [../]
  [./O2_total_bottom]
    type = TotalVariableValue
    value = O2_bottom
  [../]

  [./HS-_side]
    type = SideDiffusiveFluxIntegral
    boundary = 'spent_fuel'
    variable = HS-
    diffusivity = Diffusivity_HS
  [../]
  [./HS-_total_side]
    type = TotalVariableValue
    value = HS-_side
  [../]
  [./HS-_top]
    type = SideDiffusiveFluxIntegral
    boundary = 'spent_fuel_top'
    variable = HS-
    diffusivity = Diffusivity_HS
  [../]
  [./HS-_total_top]
    type = TotalVariableValue
    value = HS-_top
  [../]
  [./HS-_bottom]
    type = SideDiffusiveFluxIntegral
    boundary = 'spent_fuel_bottom'
    variable = HS-
    diffusivity = Diffusivity_HS
  [../]
  [./HS-_total_bottom]
    type = TotalVariableValue
    value = HS-_bottom
  [../]
[]

[Executioner]
  type = Transient
  solve_type = NEWTON
  end_time = 1E7
#  nl_abs_tol = 1E-7
  nl_rel_tol = 1E-3

  automatic_scaling = true
  compute_scaling_once = false

  [./TimeStepper]
    type = IterationAdaptiveDT
    cutback_factor = 0.8
    dt = 0.001
    growth_factor = 1.2
  [../]
[]

[Outputs]
  exodus = true
[]

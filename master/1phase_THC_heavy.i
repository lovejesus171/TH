# Unsaturated Darcy-Richards flow without using an Action

[Mesh]
  file = 'KRS+_4parts_new_heavy.msh'
[]

[UserObjects]
  [./dictator]
    type = PorousFlowDictator
    porous_flow_vars = 'pp temperature'
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
#  [./Cl-]
#    order = FIRST
#    family = LAGRANGE
#  [../]
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
    variable = temperature
    block = 'bentonite backfill hostrock'
  [../]
  [./Heat_advection]
    type = PorousFlowHeatAdvection
    variable = temperature
    gravity = '0 0 0'
    block = 'bentonite backfill hostrock'
  [../]
  [./Heat_conduction]
    type = PorousFlowHeatConduction
    variable = temperature
    block = 'bentonite backfill hostrock'
  [../]

# Chemical species
  [./dO2_dt]
    type = PrimaryTimeDerivative
    variable = O2
  [../]
  [./Adve_O2]
    type = PorousFlowBasicAdvection
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
  [./Adve_HS-]
    type = PorousFlowBasicAdvection
    variable = HS-
  [../]
  [./Diff_HS-]
    type = PorousFlowDiffusion
    variable = HS-
  [../]

#  [./dCl-_dt]
#    type = PrimaryTimeDerivative
#    variable = Cl-
#  [../]
#  [./Adve_Cl-]
#    type = PorousFlowBasicAdvection
#    variable = Cl-
#  [../]
#  [./Diff_Cl-]
#    type = PorousFlowDiffusion
#    variable = Cl-
#  [../]

# Chemical species accumulation
  [./dCu2O_dt]
    type = PrimaryTimeDerivative
    variable = Cu2O
  [../]
  [./Diff_Cu2O]
    type = CoefDiffusion
    coef = 0
    variable = Cu2O
  [../]

  [./dCu2S_dt]
    type = PrimaryTimeDerivative
    variable = Cu2S
  [../]
  [./Diff_Cu2S]
    type = CoefDiffusion
    coef = 0
    variable = Cu2S
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
    value = 1.685 # mol/m3
    block = 'bentonite'
  [../]
  [./IC_O2_backfill]
    type = ConstantIC
    variable = O2
    value = 1.685 # mol/m3
    block = 'backfill'
  [../]
  [./IC_HS-_hostrock]
    type = ConstantIC
    variable = HS-
    value = 0.0907 # mol/m3
    block = 'hostrock'
  [../] 
  [./IC_HS-_interface]
    type = ConstantIC
    variable = HS-
    value = 0.0907 # mol/m3
    boundary = 'bentonite_surface backfill_surface'
  [../] 

#  [./IC_Cl-_hostrock]
#    type = ConstantIC
#    variable = Cl-
#    value = 0.003 # mol/m3
#    block = 'hostrock'
#  [../] 
#  [./IC_Cl-_interface]
#    type = ConstantIC
#    variable = Cl-
#    value = 0.003 # mol/m3
#    boundary = 'bentonite_surface backfill_surface'
#   [../] 
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
  [./BC_HS-_surface]
    type = DirichletBC
    variable = HS-
    boundary = 'bentonite_surface backfill_surface'
    value = 0.0907
  [../]
#  [./BC_Cl-_canister]
#    type = DirichletBC
#    variable = Cl-
#    boundary = 'spent_fuel spent_fuel_top spent_fuel_bottom'
#    value = 0
#  [../]
#  [./BC_Cl-_top_bottom]
#    type = DirichletBC
#    variable = Cl-
#    boundary = 'top bottom'
#    value = 0.003
#  [../]

# Chemical species accumulation
  [./BC_O2_accumulation]
    type = ChemFluxBC
    variable = Cu2O
    Reactant1 = O2
    Num = 2
    boundary = 'spent_fuel spent_fuel_top spent_fuel_bottom'
  [../]
  [./BC_HS-_accumulation]
    type = ChemFluxBC
    variable = Cu2S
    Reactant1 = HS-
    Num = 1
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
#      thermal_conductivity = 1.9E7
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
    temperature = temperature
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

[Postprocessors]
  [./O2_side]
    type = SideFluxIntegral
    boundary = 'spent_fuel'
    variable = O2
    diffusivity = 6.76E-5
  [../]
  [./O2_total_side]
    type = TotalVariableValue
    value = O2_side
  [../]
  [./O2_top]
    type = SideFluxIntegral
    boundary = 'spent_fuel_top'
    variable = O2
    diffusivity = 6.76E-5
  [../]
  [./O2_total_top]
    type = TotalVariableValue
    value = O2_top
  [../]
  [./O2_bottom]
    type = SideFluxIntegral
    boundary = 'spent_fuel_bottom'
    variable = O2
    diffusivity = 6.76E-5
  [../]
  [./O2_total_bottom]
    type = TotalVariableValue
    value = O2_bottom
  [../]

  [./HS-_side]
    type = SideFluxIntegral
    boundary = 'spent_fuel'
    variable = HS-
    diffusivity = 6.76E-5
  [../]
  [./HS-_total_side]
    type = TotalVariableValue
    value = HS-_side
  [../]
  [./HS-_top]
    type = SideFluxIntegral
    boundary = 'spent_fuel_top'
    variable = HS-
    diffusivity = 6.76E-5
  [../]
  [./HS-_total_top]
    type = TotalVariableValue
    value = HS-_top
  [../]
  [./HS-_bottom]
    type = SideFluxIntegral
    boundary = 'spent_fuel_bottom'
    variable = HS-
    diffusivity = 6.76E-5
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

# Unsaturated Darcy-Richards flow without using an Action

[Mesh]
  file = '1DTHC.msh'
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
    block = 'copper bentonite'
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
  [./Cl-]
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
  [./CuCl2-]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[Kernels]
# Pressure
  [./dPwater_dt]
    type = PorousFlowMassTimeDerivative
    variable = pp
    block = 'copper bentonite hostrock'
  [../]
  [./flux_Pwater]
    type = PorousFlowAdvectiveFlux
    variable = pp
    gravity = '0 0 0'
    block = 'copper bentonite hostrock'
  [../]
 
# Heat Transfer
  [./dT_dt]
    type = PorousFlowEnergyTimeDerivative
    variable = T
    block = 'copper bentonite hostrock'
  [../]
  [./Heat_advection]
    type = PorousFlowHeatAdvection
    variable = T
    gravity = '0 0 0'
    block = 'copper bentonite hostrock'
  [../]
  [./Heat_conduction]
    type = PorousFlowHeatConduction
    variable = T
    block = 'copper bentonite hostrock'
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

  [./dCl-_dt]
    type = PrimaryTimeDerivative
    variable = Cl-
  [../]
  [./Adve_Cl-]
    type = PorousFlowBasicAdvection
    variable = Cl-
  [../]
  [./Diff_Cl-]
    type = PorousFlowDiffusion
    variable = Cl-
  [../]

  [./dCuCl2-_dt]
    type = PrimaryTimeDerivative
    variable = CuCl2-
  [../]
  [./Adve_CuCl2-]
    type = PorousFlowBasicAdvection
    variable = CuCl2-
  [../]
  [./Diff_CuCl2-]
    type = PorousFlowDiffusion
    variable = CuCl2-
  [../]

# Chemical species accumulation
  [./dCu2O_dt]
    type = PrimaryTimeDerivative
    variable = Cu2O
  [../]
  [./Diff_Cu2O]
    type = CoefDiffusion
    coef = 0.5e-16
    variable = Cu2O
  [../]

  [./dCu2S_dt]
    type = PrimaryTimeDerivative
    variable = Cu2S
  [../]
  [./Diff_Cu2S]
    type = CoefDiffusion
    coef = 0.5e-16
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
    block = 'copper bentonite'
  [../]
[]

[ICs]
# Temperature
   [./IC_T]
    type = ConstantIC
    variable = T
    value = 298.15
    block = 'copper bentonite hostrock'
   [../]

# Pressure
  [./IC_P_bentonite]
    type = ConstantIC
    variable = pp
    value = -12002599.86 #[Pa]
    block = 'copper bentonite'
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
    block = 'copper bentonite'
  [../]
  [./IC_HS-_hostrock]
    type = ConstantIC
    variable = HS-
    value = 0.0907 # mol/m3
    block = 'hostrock'
  [../] 

  [./IC_Cl-_hostrock]
    type = ConstantIC
    variable = Cl-
    value = 100 # mol/m3
    block = 'hostrock'
  [../] 
[]

[BCs]
# Pressure
  [./BC_P]
    type = DirichletBC
    variable = pp
    value = -3338
    boundary = 'hostrocksurface'
  [../]

# Temperature
  [./BC_hostrock]
    type = DirichletBC
    variable = T
    value = '298.15'
    boundary = 'hostrocksurface'
  [../]
 
# Heat Flux
  [./BC_HeatFlux]
    type = FunctionNeumannBC
    variable = T
    boundary = 'canistersurface'
    function = Decay_fn
  [../]

# Chemical species
  [./BC_O2_canister]
    type = DirichletBC
    variable = O2
    boundary = 'canistersurface'
    value = 0
  [../]
  [./BC_HS-]
    type = DirichletBC
    variable = HS-
    boundary = 'bentonitehostrockinterface'
    value = 0.0907
  [../]
  [./BC_Cl-]
    type = DirichletBC
    variable = Cl-
    boundary = 'bentonitehostrockinterface'
    value = 100
  [../]

# Chemical species accumulation
  [./BC_O2_accumulation]
    type = ChemFluxBC
    variable = Cu2O
    Reactant1 = O2
    Num = 2
    boundary = 'canistersurface'
  [../]

# Mixed potential Boundary Conditions
  [./BC_HS-_mixed_canister_top]
    type = ADES2
    variable = HS-
    boundary = 'canistersurface'
    Faraday_constant = 96485
    Kinetic = 216 # m4mol/hr at 25
    AlphaS = 0.5
    Corrosion_potential = Ecorr
    Temperature = T
    AlphaS3 = 0.5
    Standard_potential2 = -0.747
    Standard_potential3 = -0.747
    Num = -1
    Area = AnodeArea 
  [../]

  [./BC_Cu2S_mixed_canister_top]
    type = ADCu2S
    variable = Cu2S
    Reactant1 = HS-
    boundary = 'canistersurface'
    Faraday_constant = 96485
    Kinetic = 216 # m4mol/hr at 25
    AlphaS = 0.5
    Corrosion_potential = Ecorr
    Temperature = T
    AlphaS3 = 0.5
    Standard_potential2 = -0.747
    Standard_potential3 = -0.747
    Num = 1
    Area = AnodeArea
  [../]

  [./BC_Cl-_mixed_canister_top]
    type = ADClm
    variable = Cl-
    Reactant1 = CuCl2-
    boundary = 'canistersurface'
    Corrosion_potential = Ecorr
    Temperature = T
    kF = 1.188E-4
    kB = 2.4444E-3
    StandardPotential = -0.105
    Num = -2
    Area = AnodeArea
  [../]


  [./BC_CuCl2-_mixed_canister_top]
    type = ADCuCl2m
    variable = CuCl2-
    Reactant1 = Cl-
    boundary = 'canistersurface'
    Corrosion_potential = Ecorr
    kF = 1.188E-4
    kB = 2.4444E-3
    Temperature = T
    StandardPotential = -0.105
    Num = 1
    Area = AnodeArea
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
    block = 'copper bentonite'
  [../]
  [./porosity_hostrock]
    type = PorousFlowPorosity
    porosity_zero = '0.01'
    block = 'hostrock'
  [../]

  [./permeability_bentonite]
    type = PorousFlowPermeabilityConst
    block = 'copper bentonite'
    permeability = '1.5E-20 0 0   0 1.5E-20 0   0 0 1.5E-20'
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
    block = 'copper bentonite'
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
    block = 'copper bentonite hostrock'
  [../]
  [./massfrac_bentonite]
    type = PorousFlowMassFraction
    block = 'copper bentonite hostrock'
  [../]
  [./simple_fluid_bentonite]
    type = PorousFlowSingleComponentFluid
    fp = the_simple_fluid
    phase = 0
    block = 'copper bentonite'
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
    block = 'copper bentonite'
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
    block = 'copper bentonite hostrock'
  [../]

# Heat transfer
  [./Thermal_conductivity_bentonite]
    type = PorousFlowThermalConductivityIdeal
    dry_thermal_conductivity = '2.271E7 0 0  0 2.271E7 0  0 0 2.271E7'
    wet_thermal_conductivity = '3.785E7 0 0  0 3.785E7 0  0 0 3.785E7'
    block = 'copper bentonite'
  [../]
  [./Internal_energy_bentonite]
    type = PorousFlowMatrixInternalEnergy
    specific_heat_capacity = 966
    density = 2740
    block = 'copper bentonite'
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
    block = 'copper bentonite'
  [../]
  [./Mass_transfer_hostrock]
    type = GenericConstantMaterial
    prop_names = 'diffusivity tortuosity porosity'
    prop_values = '2.46E-3 0.8 0.01' 
    block = 'hostrock'
  [../]

# Mixed potential
  [./Corrosion_potential]
    type = ECorr
    block = 'copper'
#    boundary = 'canistersurface'
    C1 = CuCl2-
    C6 = Cl-
    C9 = HS-
    Tol = 1E-4
    T = T
    DelE = 0.1E-5
    outputs = exodus
    kF = 0
    Porosity = 0.1
    AnodeAreaValue = 0.1
    Area = 0.9
  [../]
[]

#[Preconditioning]
#  active = basic
#  [./basic]
#    type = SMP
#    full = true
#    petsc_options = '-ksp_diagonal_scale -ksp_diagonal_scale_fix'
#    petsc_options_iname = '-pc_type -sub_pc_type -sub_pc_factor_shift_type -pc_asm_overlap'
#    petsc_options_value = ' asm      lu           NONZERO                   2'
#  [../]
#  [./preferred_but_might_not_be_installed]
#    type = SMP
#    full = true
#    petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
#    petsc_options_value = ' lu       mumps'
#  [../]
#[]

[Preconditioning]
  [./smp]
    type = SMP
    full = true
  [../]
[]

[Postprocessors]
  [./O2_flux]
    type = SideFluxIntegral
    boundary = 'canistersurface'
    variable = O2
    diffusivity = 6.76E-5
  [../]

  [./HS-_flux]
    type = SideFluxIntegral
    boundary = 'canistersurface'
    variable = HS-
    diffusivity = 6.76E-5
  [../]
[]

[Executioner]
  type = Transient
  solve_type = NEWTON
  end_time = 1E7
#  nl_abs_tol = 1E-7
  nl_rel_tol = 1E-3
  l_max_its = 10
  nl_max_its = 30

  automatic_scaling = true
  compute_scaling_once = false

  [./TimeStepper]
    type = IterationAdaptiveDT
    cutback_factor = 0.99
    dt = 1E-3
    growth_factor = 1.1
  [../]
[]

[Outputs]
  exodus = true
[]

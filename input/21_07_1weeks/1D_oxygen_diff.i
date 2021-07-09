# Unsaturated Darcy-Richards flow without using an Action

[Mesh]
  file = '1DTHC.msh'
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
    block = 'copper bentonite'
  [../]
  [./pc_hostrock]
    type = PorousFlowCapillaryPressureVG
    alpha = 5E-7 #[Pa]
    m = 0.6 #[Unitless]
    block = 'hostrock'
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
  [./gypsum]
    order = FIRST
    family = LAGRANGE
  [../]
  [./SO4_2-]
    order = FIRST
    family = LAGRANGE
  [../]
  [./HS-]
    order = FIRST
    family = LAGRANGE
  [../]
  [./organic]
    order = FIRST
    family = LAGRANGE
  [../]
  [./CH3CO2H]
    order = FIRST
    family = LAGRANGE
  [../]
#  [./H2]
#    order = FIRST
#    family = LAGRANGE
#  [../]   
  [./Fe2+]
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
  [./x]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[Kernels]
# Pressure
  [./dwater_dt]
    type = PorousFlowMassTimeDerivative
    variable = pp
  [../]
  [./flux_water]
    type = PorousFlowAdvectiveFlux
    gravity = '0 0 0'
    variable = pp
  [../]

# Chemical species
  [./dO2_dt]
    type = PrimaryTimeDerivative
    variable = O2
  [../]
  [./Advec_O2]
    type = PorousFlowBasicAdvection
    variable = O2
  [../]
  [./Diff_O2_bentonite]
    type = PorousFlowDiffusion
    variable = O2
    Diffusion_coeff = 1.7E-7 # m2/s @ 25C
#    Diffusion_coeff_gas = 0.00178 # m2/s
  [../]

  [./dFe2+_dt]
    type = PrimaryTimeDerivative
    variable = Fe2+
  [../]
  [./Advec_Fe2+]
    type = PorousFlowBasicAdvection
    variable = Fe2+
  [../]
  [./Diff_Fe2+_bentonite]
    type = PorousFlowDiffusion
    variable = Fe2+
    Diffusion_coeff = 5E-8 # m2/s @ 25C
  [../]

  [./dgypsum_dt]
    type = PrimaryTimeDerivative
    variable = gypsum
  [../]
  [./dFeS_dt]
    type = PrimaryTimeDerivative
    variable = FeS
  [../]
  [./dx_dt]
    type = PrimaryTimeDerivative
    variable = x # product of microbial respiration
  [../]
  [./dorganic_dt]
    type = PrimaryTimeDerivative
    variable = organic # solid organic varbon
  [../]

  [./dSO4_2-_dt]
    type = PrimaryTimeDerivative
    variable = SO4_2-
  [../]
  [./Advec_SO4_2-]
    type = PorousFlowBasicAdvection
    variable = SO4_2-
  [../]
  [./Diff_SO4_2-]
    type = PorousFlowDiffusion
    variable = SO4_2-
    Diffusion_coeff = 1E-7 # m2/s @ 25C
  [../]

  [./dCH3CO2H_dt]
    type = PrimaryTimeDerivative
    variable = CH3CO2H # C16
  [../]
  [./Advec_CH3CO2H]
    type = PorousFlowBasicAdvection
    variable = CH3CO2H
  [../]
  [./Diff_CH3CO2H]
    type = PorousFlowDiffusion
    variable = CH3CO2H
    Diffusion_coeff = 1E-7 # m2/s @ 25C
  [../]

#  [./dH2_dt]
#    type = PrimaryTimeDerivative
#    variable = H2 # C13
#  [../]
#  [./Advec_H2]
#    type = PorousFlowBasicAdvection
#    variable = H2
#  [../]
#  [./Diff_H2]
#    type = PorousFlowDiffusion
#    variable = H2
#    Diffusion_coeff = 1E-7 # m2/s
#  [../]

  [./dHS-_dt]
    type = PrimaryTimeDerivative
    variable = HS-
  [../]
  [./Advec_HS-]
    type = PorousFlowBasicAdvection
    variable = HS-
  [../]
  [./Diff_HS-]
    type = PorousFlowDiffusion
    variable = HS-
    Diffusion_coeff = 5E-8 # m2/s @ 25C
  [../]

  [./dSRB1_dt]
    type = PrimaryTimeDerivative
    variable = SRB1
  [../]
  [./dSRB2_dt]
    type = PrimaryTimeDerivative
    variable = SRB2
  [../]
[]

[ChemicalReactions]
  [./Network]
    species = 'gypsum SO4_2- HS- organic CH3CO2H H2 Fe2+ FeS'
    track_rates = True

   equation_variables = 'SRB1 SRB2 swater'

    reactions = 'gypsum -> SO4_2-                    : 8E-6
                 organic -> CH3CO2H                  : 2.2E-10
                 SO4_2- + CH3CO2H -> HS-             : 1.3E-5 * SRB1
                 SO4_2- -> HS-                       : 5.7E-6 * SRB2
                 Fe2+ + HS- -> FeS                   : 1
                 O2 -> x                             : 2.2E-10 * swater * 0.438'
    block = 'bentonite hostrock'
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
    value = -12002599.86 #[Pa]
    block = 'copper bentonite'
  [../]
  [./IC_P_hostrock]
    type = ConstantIC
    variable = pp
    value = -3337.783216 # [Pa]
    block = 'hostrock'
  [../]

# Chemical species
  [./IC_O2_bentonite]
    type = ConstantIC
    variable = O2
    value = 0.000361 # mol/m3
    block = 'bentonite'
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
    value = 0.149
    block = 'bentonite'
  [../]
  [./IC_SO4_2-_hostrock]
    type = ConstantIC
    variable = SO4_2-
    value = 0.0094
    block = 'hostrock'
  [../]

  [./IC_gypsum_bentonite]
    type = ConstantIC
    variable = gypsum
    value = 0.0365 
    block = 'bentonite'
  [../]

  [./IC_CH3CO2H_bentonite]
    type = ConstantIC
    variable = CH3CO2H # dissolved organic carbon
    value = 0
    block = 'bentonite'
  [../]
  [./IC_organic_bentonite]
    type = ConstantIC
    variable = organic    # solid organic carbon
    value = 0.0105 # mol/m3
    block = 'bentonite'
  [../]

  [./IC_SRB1_bentonite]
    type = ConstantIC
    variable = SRB1
    value = 9E-8
    block = 'bentonite'
  [../]
  [./IC_SRB1_hostrock]
    type = ConstantIC
    variable = SRB1
    value = 9E-8
    block = 'hostrock'
  [../]
  [./IC_SRB2_bentonite]
    type = ConstantIC
    variable = SRB2
    value = 9E-8
    block = 'bentonite'
  [../]
  [./IC_SRB2_hostrock]
    type = ConstantIC
    variable = SRB2
    value = 3E-8
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

# Chemical species
  [./BC_O2_canister]
    type = DirichletBC
    variable = O2
    boundary = 'canistersurface'
    value = 0
  [../]

  [./BC_HS-_canister]
    type = DirichletBC
    variable = HS-
    boundary = 'canistersurface'
    value = 0
  [../]

  [./BC_Fe2+_hostrock]
    type = DirichletBC
    variable = Fe2+
    boundary = 'hostrocksurface'
    value = 1E-5
  [../]

  [./BC_SO4_2-_hostrock]
    type = DirichletBC
    variable = SO4_2-
    boundary = 'hostrocksurface'
    value = 1E-5
  [../]

  [./BC_HS-_hostrock]
    type = DirichletBC
    variable = HS-
    boundary = 'hostrocksurface'
    value = 1E-5
  [../]
[]

[Modules]
  [./FluidProperties]
    [./the_simple_fluid]
      type = SimpleFluidProperties
    [../]
  [../]
[]

[Materials]
  [./porosity_bentonite]
    type = PorousFlowPorosity
    porosity_zero = '0.438'
    block = 'copper bentonite'
  [../]
  [./porosity_hostrock]
    type = PorousFlowPorosity
    porosity_zero = '0.438'
    block = 'hostrock'
  [../]

  [./permeability_bentonite]
    type = PorousFlowPermeabilityConst
    permeability = '6.4E-21 0 0   0 6.4E-21 0   0 0 6.4E-21' # Intrinsic permeability
    block = 'copper bentonite'
  [../]
  [./permeability_hostrock]
    type = PorousFlowPermeabilityConst
    permeability = '6.4E-21 0 0   0 6.4E-21 0   0 0 6.4E-21' # Intrinsic permeability
    block = 'hostrock'
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
    block = 'hostrock'
  [../]

  [./temperature]
    type = PorousFlowTemperature
  [../]
  [./massfrac]
    type = PorousFlowMassFraction
  [../]

  [./simple_fluid]
    type = PorousFlowSingleComponentFluid
    fp = the_simple_fluid
    phase = 0
  [../]

  [./relperm_bentonite]
    type = PorousFlowRelativePermeabilityCorey
    n = 3
    phase = 0
    block = 'copper bentonite'
  [../]
  [./relperm_hostrock]
    type = PorousFlowRelativePermeabilityCorey
    n = 3
    phase = 0
    block = 'hostrock'
  [../]

  [./darcy_velocity]
    type = PorousFlowDarcyVelocityMaterial
    gravity = '0 0 0'
  [../]

# Chemical species
  [./chmical_species_transport_bentonite]
    type = GenericConstantMaterial
    prop_names = 'diffusivity tortuosity porosity van_genuchten_coeff van_genuchten_parameter'
    prop_values = '2.46E-4 0.1 0.05 0.2941 3.85E6'
    block = 'copper bentonite'
  [../]
  [./chmical_species_transport_hostrock]
    type = GenericConstantMaterial
    prop_names = 'diffusivity tortuosity porosity van_genuchten_coeff van_genuchten_parameter'
    prop_values = '2.46E-3 0.8 0.01 0.6 2E6'
    block = 'hostrock'
  [../]
[]

[Postprocessors]
  [./total_gypsum]
    type = ElementIntegralVariablePostprocessor
    variable = gypsum
    block = 'bentonite hostrock'
  [../]
  [./total_SO4_2-]
    type = ElementIntegralVariablePostprocessor
    variable = SO4_2-
    block = 'bentonite hostrock'
  [../]
  [./total_HS-]
    type = ElementIntegralVariablePostprocessor
    variable = HS-
    block = 'bentonite hostrock'
  [../]
  [./total_CH3CO2H]
    type = ElementIntegralVariablePostprocessor
    variable = CH3CO2H
    block = 'bentonite hostrock'
  [../]
  [./total_organic]
    type = ElementIntegralVariablePostprocessor
    variable = organic
    block = 'bentonite hostrock'
  [../]
  [./total_Fe2+]
    type = ElementIntegralVariablePostprocessor
    variable = Fe2+
    block = 'bentonite hostrock'
  [../]
  [./total_FeS]
    type = ElementIntegralVariablePostprocessor
    variable = FeS
    block = 'bentonite hostrock'
  [../]
  [./total_O2]
    type = ElementIntegralVariablePostprocessor
    variable = O2
    block = 'bentonite hostrock'
  [../]
  [./Flux_tot_O2]
    type = TotalVariableValue
    value = Flux_O2
  [../]
  [./Flux_O2]
    type = SideFluxIntegral
    variable = O2
    boundary = 'canistersurface'
    diffusivity = '5E-10'
  [../]
  [./Flux_tot_HS-]
    type = TotalVariableValue
    value = Flux_HS-
  [../]
  [./Flux_HS-]
    type = SideFluxIntegral
    variable = HS-
    boundary = 'canistersurface'
    diffusivity = '2.5E-10'
  [../]
[]

[Preconditioning]
  active = basic
  [./basic]
    type = SMP
    full = true
  [../]
[]

[Executioner]
  type = Transient
  solve_type = NEWTON
  end_time = 3.1536E10
  
  nl_rel_tol = 1E-3
  [./TimeStepper]
    type = IterationAdaptiveDT
   cutback_factor = 0.8
    dt = 0.1
    growth_factor = 1.2
  [../]
[]

[Outputs]
  exodus = true
[]

# Unsaturated Darcy-Richards flow without using an Action

[Mesh]
  file = '1D_z.msh'
  construct_side_list_from_node_list = true
[]

[UserObjects]
  [./dictator]
    type = PorousFlowDictator
    porous_flow_vars = 'pp'
    number_fluid_phases = 1
    number_fluid_components = 1
  [../]
  [./pc]
    type = PorousFlowCapillaryPressureVG
    alpha = 1.087E-7 #[Pa]
    m = 0.3 #[Unitless]
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
  [./SRB1]
    order = FIRST
    family = LAGRANGE
  [../]
  [./SRB2]
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
    type = O2TimeDerivative
    variable = O2
    pressure = pp
  [../]
  [./Advec_O2]
    type = PorousFlowBasicAdvection
    variable = O2
  [../]
  [./Diff_O2_bentonite]
    type = PorousFlowDiffusion
    variable = O2
    pressure = pp
    Diffusion_coeff = 1.7E-7 # m2/yr
  [../]
  [./Diff_O2_gas]
    type = PorousFlowGasDiffusion
    variable = O2
    pressure = pp
    Diffusion_coeff = 0.00165 # m2/s
  [../]

#  [./dgypsum_dt]
#    type = PrimaryTimeDerivative
#    variable = gypsum
#  [../]

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
    pressure = pp
    Diffusion_coeff = 1E-7 # m2/s
  [../]

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
    pressure = pp
    Diffusion_coeff = 5E-8 # m2/s
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
    species = 'gypsum SO4_2- HS-'
    track_rates = True

    equation_variables = 'SRB1 SRB2'

    reactions = 'gypsum -> SO4_2-    : 8E-6'
                'SO4_2- -> HS-       : 1.3E-6'
#                'SO4_2- -> HS-       : 5.7E-7'
    block = 'bentonite_BC'
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
  [./IC_P]
    type = ConstantIC
    variable = pp
    value = 1.01E5 #[Pa]
    boundary = 'hostrock_BC'
  [../]
  [./IC_P_hostrock]
    type = ConstantIC
    variable = pp
    value = -99.5E6 # [Pa]
    block = 'bentonite_BC'
  [../]

# Chemical species
  [./IC_O2_bentonite]
    type = ConstantIC
    variable = O2
    value = 0.000361 # mol/m3
    block = 'bentonite_BC'
  [../]
  
  [./IC_gypsum_bentonite]
    type = ConstantIC
    variable = gypsum
    value = 0.0365 
    block = 'bentonite_BC'
  [../]

  [./IC_SRB1_bentonite]
    type = ConstantIC
    variable = SRB1
    value = 9E-8
    block = 'bentonite_BC'
  [../]
  [./IC_SRB2_bentonite]
    type = ConstantIC
    variable = SRB2
    value = 9E-8
    block = 'bentonite_BC'
  [../]
[]

[BCs]
# Pressure
  [./BC_P]
    type = DirichletBC
    variable = pp
    value = 1E5
    boundary = 'hostrock_BC'
  [../]

# Chemical species
  [./BC_O2_canister]
    type = DirichletBC
    variable = O2
    boundary = 'canister_BC'
    value = 0
  [../]

  [./BC_HS-_canister]
    type = DirichletBC
    variable = HS-
    boundary = 'canister_BC'
    value = 0
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
  [./porosity]
    type = PorousFlowPorosity
    porosity_zero = '0.438'
  [../]

  [./permeability]
    type = PorousFlowPermeabilityConst
    permeability = '6.4E-21 0 0   0 6.4E-21 0   0 0 6.4E-21' # Intrinsic permeability
  [../]

  [./saturation_calculator]
    type = PorousFlow1PhaseP
    porepressure = pp
    capillary_pressure = pc
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

  [./relperm]
    type = PorousFlowRelativePermeabilityCorey
    n = 3
    phase = 0
    block = bentonite_BC
  [../]

  [./darcy_velocity]
    type = PorousFlowDarcyVelocityMaterial
    gravity = '0 0 0'
  [../]

# Chemical species
  [./chmical_species_transport]
    type = GenericConstantMaterial
    prop_names = 'diffusivity tortuosity porosity van_genuchten_coeff van_genuchten_parameter'
    prop_values = '2.46E-4 0.1 0.05 0.3 9.23E6'
    block = 'bentonite_BC'
  [../]
[]

[Postprocessors]
  [./total_HS-]
    type = ElementIntegralVariablePostprocessor
    variable = HS-
    block = 'bentonite_BC'
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
  end_time = 3.1536E9
  
  nl_rel_tol = 1E-4
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

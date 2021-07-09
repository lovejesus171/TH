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
  [./HS-]
    order = FIRST
    family = LAGRANGE
  [../] 
  [./Cu2S]
    order = FIRST
    family = LAGRANGE
  [../]
  [./Cu2O]
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
  [./Diff_O2]
    type = PorousFlowDiffusion
    variable = O2
  [../]

  [./dFe2+_dt]
    type = PrimaryTimeDerivative
    variable = Fe2+
  [../]
  [./Advec_Fe2+]
    type = PorousFlowBasicAdvection
    variable = Fe2+
  [../]
  [./Diff_Fe2+]
    type = PorousFlowDiffusion
    variable = Fe2+
  [../]

  [./dgypsum_dt]
    type = PrimaryTimeDerivative
    variable = gypsum
  [../]
  [./Advec_gypsum]
    type = PorousFlowBasicAdvection
    variable = gypsum
  [../]
  [./Diff_gypsum]
    type = PorousFlowDiffusion
    variable = gypsum
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
  [../]

  [./dCu2O_dt]
    type = PrimaryTimeDerivative
    variable = Cu2O
  [../]
  [./Diff_Cu2O]
    type = CoefDiffusion
    coef = 0.5e-5
    variable = Cu2O
  [../]

  [./dCu2S_dt]
    type = PrimaryTimeDerivative
    variable = Cu2S
  [../]
  [./Diff_Cu2S]
    type = CoefDiffusion
    coef = 0.5e-5
    variable = Cu2S
  [../]

  [./dFeS_dt]
    type = PrimaryTimeDerivative
    variable = FeS
  [../]
  [./Diff_FeS]
    type = CoefDiffusion
    coef = 0.5e-5
    variable = FeS
  [../]

  [./dABS_dt]
    type = PrimaryTimeDerivative
    variable = ABS
  [../]
  [./Diff_ABS]
    type = CoefDiffusion
    coef = 0.5e-5
    variable = ABS
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
    value = 1.685 # mol/m3
    block = 'bentonite_BC'
  [../]
  [./IC_O2_hostrock]
    type = ConstantIC
    variable = O2
    value = 1.685 # mol/m3
    boundary = 'hostrock_BC'
  [../]
  
#  [./IC_HS-_bentonite]
#    type = ConstantIC
#    variable = HS-
#    value = 0.0907 # mol/m3
#    block = 'bentonite_BC'
#  [../]
#  [./IC_HS-_hostrock]
#    type = ConstantIC
#    variable = HS-
#    value = 0 # mol/m3
#    boundary = 'hostrock_BC'
#  [../]

  [./IC_gypsum_bentonite]
    type = ConstantIC
    variable = gypsum
    value = 0.0365 # anonimous value
    block = 'bentonite_BC'
  [../]
  [./IC_gypsum_hostrock]
    type = ConstantIC
    variable = gypsum
    value = 0.0365 # anonimous value
    boundary = 'hostrock_BC'
  [../]

  [./IC_Fe2+_bentonite]
    type = ConstantIC
    variable = Fe2+
    value = 1E-5 # anonimous value
    block = 'bentonite_BC'
  [../]
  [./IC_Fe2+_hostrock]
    type = ConstantIC
    variable = Fe2+
    value = 1E-5 # anonimous value
    boundary = 'hostrock_BC'
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
#  [./BC_O2_hostrock]
#    type = DirichletBC
#    variable = O2
#    boundary = 'hostrock_BC'
#    value = 0
#  [../]
  
  [./BC_HS-_canister]
    type = DirichletBC
    variable = HS-
    boundary = 'canister_BC'
    value = 0
  [../]
#  [./BC_HS-_hostrock]
#    type = DirichletBC
#    variable = HS-
#    boundary = 'hostrock_BC'
#    value = 0.0907
#  [../]

#  [./BC_gypsum_canister]
#    type = DirichletBC
#    variable = gypsum
#    boundary = 'hostrock_BC'
#    value = 0
#  [../]

#  [./BC_Fe2+_canister]
#    type = DirichletBC
#    variable = Fe2+
#    boundary = 'hostrock_BC'
#    value = 0
#  [../]

# Corrosion film
  [./BC_Cu2O_canister]
    type = ChemFluxBC
    variable = Cu2O
    Reactant1 = O2
    Num = 2
    boundary = 'canister_BC'
  [../]
  [./BC_Cu2S_canister]
    type = ChemFluxBC
    variable = Cu2S
    Reactant1 = HS-
    Num = 2
    boundary = 'canister_BC'
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
    prop_names = 'diffusivity tortuosity porosity'
    prop_values = '7.8E-12 0.67 0.41'
    block = 'bentonite_BC'
  [../]
[]

[Postprocessors]
  [./O2_canister]
    type = SideFluxIntegral
    boundary = 'canister_BC'
    variable = O2
    diffusivity = 2.143E-12
  [../]
  [./O2_total_canister]
    type = TotalVariableValue
    value = O2_canister
  [../]
  [./HS-_canister]
    type = SideFluxIntegral
    boundary = 'canister_BC'
    variable = HS-
    diffusivity = 2.143E-12
  [../]
  [./HS-_total_canister]
    type = TotalVariableValue
    value = HS-_canister
  [../]
## add another postprocessors for total amount of Cu2O & Cu2S 
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
  end_time = 1E8
  nl_abs_tol = 1E-10
#  nl_rel_tol = 1E-5
  [./TimeStepper]
    type = IterationAdaptiveDT
    cutback_factor = 0.88
    dt = 10
    growth_factor = 1.12
  [../]
[]

[Outputs]
  exodus = true
[]

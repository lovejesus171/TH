# Unsaturated Darcy-Richards flow without using an Action

[Mesh]
  file = '1D_z.msh'
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

  [./dO2_dt]
    type = PrimaryTimeDerivative
    variable = O2
  [../]
#  [./diffusionO2_dt]
#    type = PorousFlowGasDiffusion
#    variable = O2
#    Sat = PorousFlow_saturation_nodal
#  [../]
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

  [./IC_O2_bentonite]
    type = ConstantIC
    variable = O2
    value = 1.685 # [Pa]
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
  [./BC_O2]
    type = DirichletBC
    variable = O2
    value = 0
    boundary = 'hostrock_BC'
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

  [./Chemical_species_transport]
    type = GenericConstantMaterial
    prop_names = 'diffusivity tortuosity porosity'
    prop_values = '2.46E-4 0.67 0.41'
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

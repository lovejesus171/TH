# Unsaturated Darcy-Richards flow without using an Action

[Mesh]
  file = 'KRS+_4parts.msh'
[]

[GlobalParams]
  PorousFlowDictator = dictator
[]

[Variables]
  [./pp]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[PorousFlowUnsaturated]
#  active = 'bentonite backfill'
  porepressure = pp
  coupling_type = Hydro
  fp = the_simple_fluid
  relative_permeability_exponent = 1.9
  relative_permeability_type = Corey
  residual_saturation = 0.59
  van_genuchten_alpha = 3E-7
  van_genuchten_m = 0.3
  time_unit = years
[]

[ICs]
# Pressure
  [./IC_P]
    type = ConstantIC
    variable = pp
    value = 1.01E5 #[Pa]
    block = 'bentonite backfill'
  [../]
  [./IC_P_hostrock]
    type = FunctionIC
    variable = pp
    function = hydro_static
    block = 'hostrock'
  [../]
[]

[BCs]
# Pressure
  [./BC_P]
    type = FunctionDirichletBC
    variable = pp
    function = hydro_static
    boundary = 'surface'
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
      bulk_modulus = 2.1E9 #[Pa]
      viscosity = 1.2811E-10 #1E-3/(365*24*3600) [Pas]
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
    permeability = '5.7E-21 0 0   0 5.7E-21 0   0 0 55.7E-21'
  [../]
  [./permeability_backfill]
    type = PorousFlowPermeabilityConst
    block = backfill
    permeability = '6.08E-20 0 0   0 6.08E-20 0   0 0 6.08E-20'
  [../]
  [./permeability_hostrock]
    type = PorousFlowPermeabilityConst
    block = hostrock
    permeability = '9.7E-19 0 0   0 9.7E-19 0   0 0 9.7E-19'
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
  end_time = 1E3
#  nl_abs_tol = 1E-7
  nl_rel_tol = 1E-2
  [./TimeStepper]
    type = IterationAdaptiveDT
    cutback_factor = 0.88
    dt = 0.001
    growth_factor = 1.12
  [../]
[]

[Outputs]
  exodus = true
  csv = true
[]

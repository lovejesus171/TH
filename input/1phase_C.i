# Unsaturated Darcy-Richards flow without using an Action

[Mesh]
  file = 'KRS+_4parts.msh'
[]

[Variables]
  [./O2]
    order = FIRST
    family = LAGRANGE
  [../]
  [./HS-]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[Kernels]
  [./dO2_dt]
    type = PrimaryTimeDerivative
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
  [./Diff_HS-]
    type = PorousFlowDiffusion
    variable = HS-
  [../]
[]

[ICs]
  [./IC_O2_bentonite]
    type = ConstantIC
    variable = O2
    value = 1.68 #[mol/m3]
    block = 'bentonite'
  [../]
  [./IC_O2_backfill]
    type = ConstantIC
    variable = O2
    value = 1.933 #[mol/m3]
    block = 'backfill'
  [../]
  [./IC_HS-_interface]
    type = ConstantIC
    variable = HS-
    value = 0.003 #[mol/m3]
    boundary = 'bentonite_surface backfill_surface'
  [../]
[]

[BCs]
  [./BC_O2_canister]
    type = DirichletBC
    variable = O2
    boundary = 'spent_fuel spent_fuel_top spent_fuel_bottom'
    value = 0
  [../]
  [./BC_O2_interface]
    type = NeumannBC
    variable = O2
    boundary = 'bentonite_surface backfill_surface'
    value = 0
  [../]
  [./BC_HS-_interface]
    type = DirichletBC
    variable = HS-
    boundary = 'bentonite_surface backfill_surface'
    value = 0.003
  [../]
  [./BC_HS-_canister]
    type = DirichletBC
    variable = HS-
    boundary = 'spent_fuel spent_fuel_top spent_fuel_bottom'
    value = 0
  [../]
[]

[Materials]
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
    prop_values = '0 0.8 0.01'
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

[Executioner]
  type = Transient
  solve_type = NEWTON
  end_time = 100
  nl_abs_tol = 1E-7
  nl_rel_tol = 1E-5
  [./TimeStepper]
    type = IterationAdaptiveDT
    cutback_factor = 0.88
    dt = 0.001
    growth_factor = 1.12
  [../]
[]

[Outputs]
  exodus = true
[]

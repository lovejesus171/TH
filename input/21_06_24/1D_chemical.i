# Unsaturated Darcy-Richards flow without using an Action

[Mesh]
  file = '1D_z.msh'
  construct_side_list_from_node_list = true
[]

[Variables]
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
# Chemical species
  [./dO2_dt]
    type = PrimaryTimeDerivative
    variable = O2
  [../]
#  [./Diff_O2]
#    type = PorousFlowDiffusion
#    variable = O2
#  [../]

  [./dFe2+_dt]
    type = PrimaryTimeDerivative
    variable = Fe2+
  [../]
#  [./Diff_Fe2+]
#    type = PorousFlowDiffusion
#    variable = Fe2+
#  [../]

  [./dgypsum_dt]
    type = PrimaryTimeDerivative
    variable = gypsum
  [../]
#  [./Diff_gypsum]
#    type = PorousFlowDiffusion
#    variable = gypsum
#  [../]

  [./dSO4_2-_dt]
    type = PrimaryTimeDerivative
    variable = SO4_2-
  [../]
#  [./Diff_SO4_2-]
#    type = PorousFlowDiffusion
#    variable = SO4_2-
#  [../]

  [./dHS-_dt]
    type = PrimaryTimeDerivative
    variable = HS-
  [../]
#  [./Diff_HS-]
#    type = PorousFlowDiffusion
#    variable = HS-
#  [../]

  [./dCu2O_dt]
    type = PrimaryTimeDerivative
    variable = Cu2O
  [../]
#  [./Diff_Cu2O]
#    type = CoefDiffusion
#    coef = 0.5e-5
#    variable = Cu2O
#  [../]

  [./dCu2S_dt]
    type = PrimaryTimeDerivative
    variable = Cu2S
  [../]
#  [./Diff_Cu2S]
#    type = CoefDiffusion
#    coef = 0.5e-5
#    variable = Cu2S
#  [../]

  [./dFeS_dt]
    type = PrimaryTimeDerivative
    variable = FeS
  [../]
#  [./Diff_FeS]
#    type = CoefDiffusion
#    coef = 0.5e-5
#    variable = FeS
#  [../]

  [./dABS_dt]
    type = PrimaryTimeDerivative
    variable = ABS
  [../]
#  [./Diff_ABS]
#    type = CoefDiffusion
#    coef = 0.5e-5
#    variable = ABS
#  [../]
[]

[ChemicalReactions]
  [./Network]
    species = 'O2 Fe2+ gypsum SO4_2- HS- FeS Cu2O Cu2S ABS'
    track_rates = True
    reaction_coefficient_format = 'rate'
    reactions = 'Fe2+ + HS- -> FeS       : 1
                 O2 -> ABS               : 2.2e-10
                 gypsum -> SO4_2-        : 8e-6
                 SO4_2- -> HS-           : 1.87e-5
                 Cu2O + HS- -> Cu2S      : 1.99  '
    block = 'bentonite_BC'
  [../]
[]

[ICs]
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
# Chemical species
#  [./BC_O2_canister]
#    type = DirichletBC
#    variable = O2
#    boundary = 'canister_BC'
#    value = 0
#  [../]
#  [./BC_O2_hostrock]
#    type = DirichletBC
#    variable = O2
#    boundary = 'hostrock_BC'
#    value = 0
#  [../]
  
#  [./BC_HS-_canister]
#    type = DirichletBC
#    variable = HS-
#    boundary = 'canister_BC'
#    value = 0
#  [../]
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
#  [./BC_Cu2O_canister]
#    type = ChemFluxBC
#    variable = Cu2O
#    Reactant1 = O2
#    Num = 2
#    boundary = 'canister_BC'
#  [../]
#  [./BC_Cu2S_canister]
#    type = ChemFluxBC
#    variable = Cu2S
#    Reactant1 = HS-
#    Num = 2
#    boundary = 'canister_BC'
#  [../]
[]

[Materials]
# Chemical species
  [./chmical_species_transport]
    type = GenericConstantMaterial
    prop_names = 'diffusivity tortuosity porosity'
    prop_values = '2.46E-4 0.67 0.41'
    block = 'bentonite_BC'
  [../]
[]

#[Postprocessors]
#  [./O2_canister]
#    type = SideFluxIntegral
#    boundary = 'canister_BC'
#    variable = O2
#    diffusivity = 6.76E-5
#  [../]
#  [./O2_total_canister]
#    type = TotalVariableValue
#    value = O2_canister
#  [../]
#  [./HS-_canister]
#    type = SideFluxIntegral
#    boundary = 'canister_BC'
#    variable = HS-
#    diffusivity = 6.76E-5
#  [../]
#  [./HS-_total_canister]
#    type = TotalVariableValue
#    value = HS-_canister
#  [../]
## add another postprocessors for total amount of Cu2O & Cu2S 
#[]

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
  end_time = 3.1536E10
#  nl_abs_tol = 1E-10
  nl_rel_tol = 1E-3
  [./TimeStepper]
    type = IterationAdaptiveDT
    cutback_factor = 0.8
    dt = 1
    growth_factor = 1.2
  [../]
[]

[Outputs]
  exodus = true
[]

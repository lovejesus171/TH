[Mesh]
  file = 'THM_KAERI.msh'
[]

[GlobalParams]
  PorousFlowDictator = dictator
[]

[Variables]
  [./porepressure]
  [../]
  [./H2O]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[ICs]
# Initial condition of Pressure 
  [./IC_P_hostrock]
    type = FunctionIC
    variable = porepressure
    function = hydro_static
    block = 'hostrock'
  [../]
  [./IC_P_bentonite_backfill]
    type = ConstantIC
    variable = porepressure
    value = 1E5
    block = 'bentonite backfill'
  [../]
  
# Initial condition of Saturation
  [./IC_H2O_Hostrock]
    type = ConstantIC
    variable = H2O
    value = 100
    block = 'hostrock'
  [../]
  [./IC_H2O_Bentonite]
    type = ConstantIC
    variable = H2O
    value = 59
    block = 'bentonite'
  [../]
  [./IC_H2O_Backfill]
    type = ConstantIC
    variable = H2O
    value = 59
    block = 'backfill'
  [../]
[]

[PorousFlowBasicTHM]
  porepressure = porepressure
  coupling_type = Hydro
  gravity = '0 0 0'
  fp = the_simple_fluid
[]

[BCs]
  [./Constant_injection_porepressure]
    type = FunctionDirichletBC
    variable = porepressure
    function = hydro_static
    boundary = 'right'
  [../]
  [./Constant_injection_H2O]
    type = DirichletBC
    variable = H2O
    value = 100
    boundary = 'right'
  [../]
[]

[Modules]
  [./FluidProperties]
    [./the_simple_fluid]
      type = SimpleFluidProperties
      bulk_modulus = 2.1E9
      viscosity = 3.2E-8    # 8.9E-4/(365 * 24 * 3600)
      density0 = 1000
    [../]
  [../]
[]

[UserObjects]
  [./PorousFlow]
    type = PorousFlowDictator
    porous_flow_vars = porepressure
    number_fluid_phases = 1
    number_fluid_components = 1
  [../]
  [./Suction_pressure_bentonite]
     type = PorousFlowCapillaryPressureVG
     alpha = 3.85E6
     m = 0.2941
     block = 'bentonite'
  [../]
  [./Suction_pressure_backfill]
     type = PorousFlowCapillaryPressureVG
     alpha = 3.03E6
     m = 0.5
     block = 'backfill'
  [../]
  [./Suction_pressure_hostrock]
     type = PorousFlowCapillaryPressureVG
     alpha = 2E6
     m = 0.6
     block = 'hostrock'
  [../]
[]

[Functions]
  [./hydro_static]
     type = ParsedFunction
     value = '-1000 * 9.81 * y'
  [../]
[]

[Materials]
# Material properties about Pressure
  [./porosity_bentonite]
    type = PorousFlowPorosity
    porosity_zero = 0.4
    block = bentonite
  [../]
  [./porosity_backfill]
    type = PorousFlowPorosity
    porosity_zero = 0.41
    block = backfill
  [../]
  [./porosity]
    type = PorousFlowPorosity
    porosity_zero = 0.01
    block = hostrock
  [../]
  [./biot_modulus_bentonite]
    type = PorousFlowConstantBiotModulus
    biot_coefficient = 1
    block = bentonite
  [../]
  [./biot_modulus_backfill]
    type = PorousFlowConstantBiotModulus
    biot_coefficient = 1
    block = backfill
  [../]
  [./biot_modulus_hostrock]
    type = PorousFlowConstantBiotModulus
    biot_coefficient = 1
    block = hostrock
  [../]
  [./Permeability_hostrock]
    type = PorousFlowPermeabilityConst
    block = 'hostrock'
    permeability = '1E-18 0 0   0 1E-18 0   0 0 1E-18'
  [../]
  [./Permeability_bentonite]
    type = PorousFlowPermeabilityConst
    block = 'bentonite'
    permeability = '1.5E-20 0 0   0 1.5E-20 0   0 0 1.5E-20'
  [../]
  [./Permeability_backfill]
    type = PorousFlowPermeabilityConst
    block = 'backfill'
    permeability = '1.6E-19 0 0   0 1.6E-19 0   0 0 1.6E-19'
  [../]
# Material properties about Darcy Flow
  [./darcy_velcity_qp_bentonite]
    type = PorousFlowDarcyVelocityMaterial
    gravity = '0 0 0'
    block = 'bentonite'
  [../]
  [./darcy_velcity_qp_backfill]
    type = PorousFlowDarcyVelocityMaterial
    gravity = '0 0 0'
    block = 'backfill'
  [../]
  [./darcy_velcity_qp_hostrock]
    type = PorousFlowDarcyVelocityMaterial
    gravity = '0 0 0'
    block = 'hostrock'
  [../]
[]

[Kernels]
  [./Darcy_water_hostrock]
    type = PorousFlowBasicAdvection
    variable = H2O
    block = 'hostrock'
  [../]
  [./Darcy_water_bentonite]
    type = PorousFlowBasicAdvection
    variable = H2O
    block = 'bentonite'
  [../]
  [./Darcy_water_backfill]
    type = PorousFlowBasicAdvection
    variable = H2O
    block = 'backfill'
  [../]
  [./dH2O_dt_hostrock]
    type = TimeDerivative
    variable = H2O
    block = 'hostrock'
  [../]
  [./Diff_H2O_hostrock]
    type = CoefDiffusion
    coef = 9.5E-4
    variable = H2O
    block = 'hostrock'
  [../]
  [./dH2O_dt_bentonite]
    type = TimeDerivative
    variable = H2O
    block = 'bentonite'
  [../]
  [./Diff_H2O_bentonite]
    type = CoefDiffusion
    coef = 9.5E-4
    variable = H2O
    block = 'bentonite'
  [../]
  [./dH2O_dt_backfill]
    type = TimeDerivative
    variable = H2O
    block = 'backfill'
  [../]
  [./Diff_H2O_backfill]
    type = CoefDiffusion
    coef = 9.5E-4
    variable = H2O
    block = 'backfill'
  [../]
[]

[Preconditioning]
  active = basic
  [./basic]
    type = SMP
    full = true
    petsc_options = '-ksp_diagonal_scale -ksp_diagonal_scale_fix'
    petsc_options_iname = '-ps_type -sub_pc_type -sub_pc_factor_shift_type -pc_asm_overlap'
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
  solve_type = Newton
  end_time = 200
  l_abs_tol = 1e-13
  nl_abs_tol = 1e-13
   [./TimeStepper]
     type = IterationAdaptiveDT
     cutback_factor = 0.9
     dt = 0.1
     growth_factor =1.1
   [../]
[]

[Outputs]
  exodus = true
[]

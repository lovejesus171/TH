[Mesh]
   file = '3D_Real_Circle_Copper.msh'
[]

[Variables]
  # Name of chemical species
  [./HS]
    order = FIRST
    initial_condition = 1 #[mol/m3]
  [../]
  [./Hp]
    order = FIRST
    initial_condition = 1.0079e-8 #[mol/m3]
  [../]
  [./OHm]
    order = FIRST
    initial_condition = 1.0001e-3 #[mol/m3]
  [../]
  [./T]
    order = FIRST
    family = LAGRANGE
    initial_condition = 298.15 #[K]
  [../]
  [./pH]
    order = FIRST
    family = LAGRANGE
    initial_condition = 11 #[pH = log(H+)]
  [../]
[]


[Kernels]
  # dCi/dt
  [./dHS_dt]
    type = TimeDerivative
    variable = HS
  [../]
  [./dCu2S_dt]
    type = TimeDerivative
    variable = Cu2S
  [../]
  [./dSO4_dt]
    type = TimeDerivative
    variable = SO4
  [../]
  [./dH2O2_dt]
    type = TimeDerivative
    variable = H2O2
  [../]
  [./dpH_dt]
    type = TimeDerivative
    variable = pH
  [../]
# Diffusion terms
  [./DgradHS]
    type = CoefDiffusion
    coef = 7.31e-10 #[m2/s]
    variable = HS
  [../]
  [./DgradH2O2]
    type = CoefDiffusion
    coef = 1.18e-9 #[m2/s], at 30C
    variable = H2O2
  [../]
# HeatConduction terms
  [./heat]
    type = HeatConduction
    variable = T
  [../]
  [./ie]
    type = HeatConductionTimeDerivative
    variable = T
  [../]
[]


[ChemicalReactions]
 [./Network]
   block = 'Solution'
   species = 'HS H2O2 SO4'
   track_rates = True

   equation_constants = 'Ea R'
   equation_values = '300 8.314'
   equation_variables = 'T pH H2O2'

   reactions = 'HS + H2O2 -> SO4 : {10^(12.04-2641/T-0.186*pH)/60*H2O2*10^-3}'
 [../]
[]

[BCs]
  [./right_chemical]
    type = DirichletBC
    variable = HS
    boundary = Copper_top
    value = 0 #[mol/m2]
  [../]
[]

[Materials]
  [./hcm]
    type = HeatConductionMaterial
    temp = T
    specific_heat  = 75.309 #[J/(mol*K)]
    thermal_conductivity  = 0.6145 #[W/(m*K)]
  [../]
  [./density]
    type = GenericConstantMaterial
    prop_names = density
    prop_values = 995.65 #[kg/m3]
  [../]
[]

[Executioner]
  type = Transient
  start_time = 0 #[s]
  end_time = 1209600 #[s]
  solve_type = 'NEWTON'
  l_abs_tol = 1e-10
  nl_abs_tol = 1e-10
  dtmax = 1000 
  [./TimeStepper]
    type = IterationAdaptiveDT
    cutback_factor = 0.9
    dt = 0.1
    growth_factor = 1.2
  [../]
[]

[Preconditioning]
  [./smp]
    type = SMP
    full = true
  [../]
[]


[Postprocessors]
  [./Consumed_HS_mol_per_s]
    type = SideFluxIntegral
    variable = HS
    diffusivity = 7.31e-10 #m2/s
    boundary = Copper_top
  [../]
  [./Volume_tegetral_of_HS-]
    type = ElementIntegralVariablePostprocessor
    block = 'Solution'
    variable = HS
  [../]
[]

[Outputs]
  exodus = true
[]

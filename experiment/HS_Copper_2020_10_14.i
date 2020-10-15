[Mesh]
   file = '3D_Real_Circle_Copper.msh'
[]

[Variables]
  # Name of chemical species
  [./H+]
   block = 'Solution'
   order = FIRST
   initial_condition = 1.0079e-8 #[mol/m3] at 25 C with 1mol/l of HS- in solution (Na2S)
  [../]
  [./OH-]
   block = 'Solution'
   order =FIRST
   initial_condition = 1.0001 #[mol/m3]
  [../]
  [./H2O]
   block = 'Solution'
   order = FIRST
   initial_condition = 55347 #[mol/m3] at 25 C
  [../]
  [./HS-]
    block = 'Solution'
    order = FIRST
    initial_condition = 1 #[mol/m3]
  [../]
  [./T]
    block = 'Solution'
    order = FIRST
    family = LAGRANGE
    initial_condition = 298.15 #[K]
  [../]
  [./pH]
    block = 'Solution'
    order = FIRST
    family = LAGRANGE
    initial_condition = 11.00 #[pH = log(H+)]
  [../]
[]

[Kernels]
# dCi/dt
  [./dHS_dt]
    block = 'Solution'
    type = TimeDerivative
    variable = HS-
  [../]
  [./dH2O_dt]
    block = 'Solution'
    type = TimeDerivative
    variable = H2O
  [../]
  [./dHp_dt]
    block = 'Solution'
    type = TimeDerivative
    variable = H+
  [../]
  [./dOHm_dt]
    block = 'Solution'
    type = TimeDerivative
    variable = OH-
  [../]
  [./dpH_dt]
    block = 'Solution'
    type = TimeDerivative
    variable = pH
  [../]
# Diffusion terms
  [./DgradHS]
    block = 'Solution'
    type = CoefDiffusion
    coef = 7.31e-10 #[m2/s]
    variable = HS-
  [../]
  [./DgradH2O]
    block = 'Solution'
    type = CoefDiffusion
    coef = 2.31e-9 #[m2/s], at 30C
    variable = H2O
  [../]
  [./DgradHp]
    block = 'Solution'
    type = CoefDiffusion
    coef = 1.008e-8 #[m2/s], at 30C
    variable = H+
  [../]
  [./DgradOHm]
    block = 'Solution'
    type = CoefDiffusion
    coef = 4.82e-9 #[m2/s], at 30C
    variable = OH-
  [../]

# HeatConduction terms
  [./heat]
    block = 'Solution'
    type = HeatConduction
    variable = T
  [../]
  [./ie]
    block = 'Solution'
    type = HeatConductionTimeDerivative
    variable = T
  [../]
[]


[ChemicalReactions]
 [./Network]
   block = 'Solution'
   species = 'H+ OH- H2O'
   track_rates = True

   equation_constants = 'Ea R'
   equation_values = '20 8.314'
   equation_variables = 'T pH'

   reactions = 'H2O -> OH- + H+ : {2294.41*exp(-45.4e3/(R*T))}
                OH- + H+ -> H2O : {2.25775e10*exp(-12.6e3/(R*T))}
                '
 [../]
[]

[BCs]
  [./right_chemical]
    type = DirichletBC
    variable = HS-
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
    prop_values = 997.10 #[kg/m3]
  [../]
[]

[Executioner]
  type = Transient
  start_time = 1e-9 #[s]
  end_time = 6048000 #[s]
  solve_type = 'NEWTON'
  l_abs_tol = 1e-11
  nl_abs_tol = 1e-11
  dtmax = 1000 
  [./TimeStepper]
    type = IterationAdaptiveDT
    cutback_factor = 0.9
    dt = 1e-9
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
    variable = HS-
    diffusivity = 7.31e-10 #m2/s
    boundary = Copper_top
  [../]
  [./Volume_tegetral_of_HS-]
    type = ElementIntegralVariablePostprocessor
    block = 'Solution'
    variable = HS-
  [../]
[]

[Outputs]
  exodus = true
[]

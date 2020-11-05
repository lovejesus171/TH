[Mesh]
   type = GeneratedMesh
   dim = 2
   xmin = 0
   xmax = 1
   ymin = 0
   ymax = 1
   nx = 1
   ny = 1
[]

[Variables]
  # Name of chemical species
  [./H+]
   order = FIRST
   initial_condition = 1e-6 #[mol/m3] at 25 C with 1mol/l of HS- in solution (Na2S)
  [../]
  [./OH-]
   order =FIRST
   initial_condition = 0.01 #[mol/m3]
  [../]
  [./H2O]
   order = FIRST
   initial_condition = 55347 #[mol/m3] at 25 C
  [../]
  [./HS-]
   order = FIRST
    initial_condition = 0.1 #[mol/m3]
  [../]
  [./H2O2]
    order = FIRST
    initial_condition = 1.2 #[mol/m3]
  [../]
  [./SO42-]
    order = FIRST
    initial_condition = 0 #[mol/m3]
  [../]
  [./T]
    order = FIRST
    family = LAGRANGE
    initial_condition = 298.15 #[K]
  [../]
[]

[Kernels]
# dCi/dt
  [./dHS_dt]
    type = TimeDerivative
    variable = HS-
  [../]
  [./dH2O_dt]
    type = TimeDerivative
    variable = H2O
  [../]
  [./dHp_dt]
    type = TimeDerivative
    variable = H+
  [../]
  [./dOHm_dt]
    type = TimeDerivative
    variable = OH-
  [../]
  [./dH2O2_dt]
    type = TimeDerivative
    variable = H2O2
  [../]
  [./dSO42m_dt]
    type = TimeDerivative
    variable = SO42-
  [../]
# Diffusion terms
  [./DgradHS]
    type = CoefDiffusion
    coef = 7.31e-10 #[m2/s]
    variable = HS-
  [../]
  [./DgradH2O]
    type = CoefDiffusion
    coef = 2.31e-9 #[m2/s], at 25C
    variable = H2O
  [../]
  [./DgradHp]
    type = CoefDiffusion
    coef = 1.008e-8 #[m2/s], at 25C
    variable = H+
  [../]
  [./DgradOHm]
    type = CoefDiffusion
    coef = 4.82e-9 #[m2/s], at 25C
    variable = OH-
  [../]
  [./DgradH2O2]
    type = CoefDiffusion
    coef = 2.31e-9 #[m2/s], at 25C
    variable = H2O2
  [../]
  [./DgradSO42m]
    type = CoefDiffusion
    coef = 1.8e-9 #[m2/s], to be checked
    variable = SO42-
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
   block = 0

   species = 'H+ OH- H2O H2O2 SO42- HS-'
   track_rates = True

   equation_constants = 'Ea R'
   equation_values = '20 8.314'
   equation_variables = 'T'

   reactions = ' HS- + H2O2 + H2O2 + H2O2 + H2O2 -> OH- + H+ + H+ + SO42- : {3e-3}              
                '
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
  start_time = 0 #[s]
  end_time = 1440 #[s]
  solve_type = 'NEWTON'
  l_abs_tol = 1e-11
  nl_abs_tol = 1e-11
  dtmax = 10 
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

[Outputs]
  exodus = true
[]

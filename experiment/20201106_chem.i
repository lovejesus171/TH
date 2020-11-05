[Mesh]
   file = '2D_Experiment.msh'
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
  [./H2O2]
    block = 'Solution'
    order = FIRST
    initial_condition = 1  #[mol/m3]
  [../]
  [./SO42-]
    block = 'Solution'
    order = FIRST
    initial_condition = 0 #[mol/m3]
  [../]
  [./O2]
    block = 'Solution'
    order = FIRST
    initial_condition = 0 #[mol/m3]
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
  [./dH2O2_dt]
    block = 'Solution'
    type = TimeDerivative
    variable = H2O2
  [../]
  [./dSO42m_dt]
    block = 'Solution'
    type = TimeDerivative
    variable = SO42-
  [../]
  [./dO2_dt]
    block = 'Solution'
    type = TimeDerivative
    variable = O2
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
    coef = 2.31e-9 #[m2/s], at 25C
    variable = H2O
  [../]
  [./DgradHp]
    block = 'Solution'
    type = CoefDiffusion
    coef = 1.008e-8 #[m2/s], at 25C
    variable = H+
  [../]
  [./DgradOHm]
    block = 'Solution'
    type = CoefDiffusion
    coef = 4.82e-9 #[m2/s], at 25C
    variable = OH-
  [../]
  [./DgradH2O2]
    block = 'Solution'
    type = CoefDiffusion
    coef = 4.82e-9 #[m2/s], to be added
    variable = H2O2
  [../]
  [./DgradSO42m]
    block = 'Solution'
    type = CoefDiffusion
    coef = 4.82e-9 #[m2/s], to be added
    variable = SO42-
  [../]
  [./DgradO2]
    block = 'Solution'
    type = CoefDiffusion
    coef = 2e-9 #[m2/s], to be added
    variable = O2
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

#unit = 1/hour
[ChemicalReactions]
 [./Network]
   block = 'Solution'
   species = 'H+ OH- H2O H2O2 SO42- O2 HS-'
   track_rates = False

   equation_constants = 'Ea R T_Re'
   equation_values = '20 8.314 298.15'
   equation_variables = 'T pH'

   reactions = 'H2O -> OH- + H+ : {2.5e-5*exp(-45.4e3/R*(1/T_Re-1/T))}
                OH- + H+ -> H2O : {1.4e8*exp(-12.2e3/R*(1/T_Re-1/T))}
                HS- + H2O2 + H2O2 + H2O2 + H2O2 -> OH- + H+ + H+ + SO42- : {5.5e-4*exp(-51.3e3/R*(1/T_Re-1/T))}
                HS- + O2 -> SO42- + H+ : {3.6*10^(11.78-3000/T)}'
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
  end_time = 10000 #[s]
  solve_type = 'PJFNK'
  l_abs_tol = 1e-11
  l_tol = 1e-7 #default = 1e-5
  nl_abs_tol = 1e-11
  nl_rel_tol = 1e-9 #default = 1e-7
  l_max_its = 10
  nl_max_its = 10
  dtmax = 10000 
  [./TimeStepper]
    type = IterationAdaptiveDT
    cutback_factor = 0.9
    dt = 0.1
    growth_factor = 1.1
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

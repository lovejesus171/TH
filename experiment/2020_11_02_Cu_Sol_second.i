[Mesh]
   file = '2D_Cu_Sol.msh'
[]

[Variables]
  # Name of chemical species
  [./H+]
   block = 'Copper Solution'
   order = FIRST
  [../]
  [./OH-]
   block = 'Copper Solution'
   order =FIRST
  [../]
  [./H2O]
   block = 'Copper Solution'
   order = FIRST
  [../]
  [./HS-]
    block = 'Copper Solution'
    order = FIRST
  [../]
  [./H2O2]
    block = 'Copper Solution'
    order = FIRST
  [../]
  [./SO42-]
    block = 'Copper Solution'
    order = FIRST
    initial_condition = 0 #[mol/m3]
  [../]
  [./O2]
    block = 'Copper Solution'
    order = FIRST
  [../]
  [./T]
    block = 'Copper Solution'
    order = FIRST
    family = LAGRANGE
    initial_condition = 298.15 #[K]
  [../]
  [./pH]
    block = 'Copper Solution'
    order = FIRST
    family = LAGRANGE
  [../]
  [./Cu]
    block = 'Copper Solution'
    order = FIRST
    family = LAGRANGE
  [../]
  [./Cu2S]
    block = 'Copper Solution'
    order = FIRST
    family = LAGRANGE
    initial_condition = 0
  [../]
[]

[ICs]
  [./Copper_Cu]
    type = ConstantIC
    block = 'Copper'
    variable = Cu
    value = 141000 #[mol/m3]
  [../]
  [./Solution_Cu]
    type = ConstantIC
    block = 'Solution'
    variable = Cu
    value = 0 #[mol/m3]
  [../]
  [./Copper_Hp]
    type = ConstantIC
    block = 'Copper'
    variable = H+
    value = 0
  [../]
  [./Solution_Hp]
    type = ConstantIC
    block = 'Solution'
    variable = H+
    value = 1.0079e-8 #[mol/m3]
  [../]
  [./Copper_OHm]
    type = ConstantIC
    block = 'Copper'
    variable = OH-
    value = 0
  [../]
  [./Solution_OHm]
    type = ConstantIC
    block = 'Solution'
    variable = OH-
    value = 1.0001 #[mol/m3]
  [../]
  [./Copper_H2O]
    type = ConstantIC
    block = 'Copper'
    variable = H2O
    value = 0
  [../]
  [./Solution_H2O]
    type = ConstantIC
    block = 'Solution'
    variable = H2O
    value = 55347 #[mol/m3]
  [../]
  [./Copper_HS-]
    type = ConstantIC
    block = 'Copper'
    variable = HS-
    value = 0
  [../]
  [./Solution_HS-]
    type = ConstantIC
    block = 'Solution'
    variable = HS-
    value = 1 #[mol/m3]
  [../]
  [./Copper_H2O2]
    type = ConstantIC
    block = 'Copper'
    variable = H2O2
    value = 0
  [../]
  [./Solution_H2O2]
    type = ConstantIC
    block = 'Solution'
    variable = H2O2
    value = 0 #[mol/m3]
  [../]
  [./Copper_O2]
    type = ConstantIC
    block = 'Copper'
    variable = O2
    value = 0
  [../]
  [./Solution_O2]
    type = ConstantIC
    block = 'Solution'
    variable = O2
    value = 0 #[mol/m3]
  [../]
  [./Copper_pH]
    type = ConstantIC
    block = 'Copper'
    variable = pH
    value = 0
  [../]
  [./Solution_pH]
    type = ConstantIC
    block = 'Solution'
    variable = pH
    value = 11
  [../]
[]


[Kernels]
# dCi/dt
  [./dHS_dt]
    block = 'Copper Solution'
    type = TimeDerivative
    variable = HS-
  [../]
  [./dH2O_dt]
    block = 'Copper Solution'
    type = TimeDerivative
    variable = H2O
  [../]
  [./dHp_dt]
    block = 'Copper Solution'
    type = TimeDerivative
    variable = H+
  [../]
  [./dOHm_dt]
    block = 'Copper Solution'
    type = TimeDerivative
    variable = OH-
  [../]
  [./dpH_dt]
    block = 'Copper Solution'
    type = TimeDerivative
    variable = pH
  [../]
  [./dH2O2_dt]
    block = 'Copper Solution'
    type = TimeDerivative
    variable = H2O2
  [../]
  [./dSO42m_dt]
    block = 'Copper Solution'
    type = TimeDerivative
    variable = SO42-
  [../]
  [./dO2_dt]
    block = 'Copper Solution'
    type = TimeDerivative
    variable = O2
  [../]
  [./dCu_dt]
    block = 'Copper Solution'
    type = TimeDerivative
    variable = Cu
  [../]
  [./dCu2S_dt]
    block = 'Copper Solution'
    type = TimeDerivative
    variable = Cu2S
  [../]
# Diffusion terms
  [./DgradHS]
    block = 'Solution'
    type = CoefDiffusion
    coef = 2.63e-6 #[m2/hr]
    variable = HS-
  [../]
  [./DgradH2O]
    block = 'Copper Solution'
    type = CoefDiffusion
    coef = 8.32e-6 #[m2/hr], at 25C
    variable = H2O
  [../]
  [./DgradHp]
    block = 'Copper Solution'
    type = CoefDiffusion
    coef = 3.63e-5 #[m2/hr], at 25C
    variable = H+
  [../]
  [./DgradOHm]
    block = 'Copper Solution'
    type = CoefDiffusion
    coef = 1.74e-5 #[m2/hr], at 25C
    variable = OH-
  [../]
  [./DgradH2O2]
    block = 'Copper Solution'
    type = CoefDiffusion
    coef = 1.74e-5 #[m2/hr], to be added
    variable = H2O2
  [../]
  [./DgradSO42m]
    block = 'Copper Solution'
    type = CoefDiffusion
    coef = 1.74e-5 #[m2/hr], to be added
    variable = SO42-
  [../]
  [./DgradO2]
    block = 'Copper Solution'
    type = CoefDiffusion
    coef = 7.2e-6 #[m2/hr], to be added
    variable = O2
  [../]
  [./DgradCu]
    block = 'Copper Solution'
    type = CoefDiffusion
    coef = 0 #[m2/hr], to be added
    variable = Cu
  [../]
  [./DgradCu2S]
    block = 'Copper Solution'
    type = CoefDiffusion
    coef = 0 #[m2/hr], to be added
    variable = Cu2S
  [../]
# HeatConduction terms
  [./heat]
    block = 'Copper Solution'
    type = HeatConduction
    variable = T
  [../]
  [./ie]
    block = 'Copper Solution'
    type = HeatConductionTimeDerivative
    variable = T
  [../]
[]

#unit = 1/hour
[ChemicalReactions]
 [./Network]
   block = 'Copper Solution'
   species = 'H+ OH- H2O H2O2 SO42- O2'
   track_rates = False

   equation_constants = 'Ea R T_Re'
   equation_values = '20 8.314 298.15'
   equation_variables = 'T pH'

   reactions = 'H2O -> OH- + H+ : {0.09*exp(-45.4e3/R*(1/T_Re-1/T))}
                OH- + H+ -> H2O : {5.04*10^8*exp(-12.2e3/R*(1/T_Re-1/T))}
                HS- + H2O2 + H2O2 + H2O2 + H2O2 -> OH- + H+ + H+ + SO42- : {1.98*exp(-51.3e3/R*(1/T_Re-1/T))}
                HS- + O2 -> SO42- + H+ : {1.3*10^14*10^(11.78-3000/T)}'
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
  end_time = 1 #[s]
  solve_type = 'PJFNK'
  l_abs_tol = 1e-11
  l_tol = 1e-7 #default = 1e-5
  nl_abs_tol = 1e-11
  nl_rel_tol = 1e-9 #default = 1e-7
  l_max_its = 10
  nl_max_its = 10
  dtmax = 10 
  [./TimeStepper]
    type = IterationAdaptiveDT
    cutback_factor = 0.99
    dt = 1e-3
    growth_factor = 1.01
  [../]
[]

[Preconditioning]
  [./smp]
    type = SMP
    full = true
  [../]
[]


[Postprocessors]
  [./Volume_tegetral_of_HS-]
    type = ElementIntegralVariablePostprocessor
    block = 'Solution'
    variable = HS-
  [../]
    [./Volume_tegetral_of_Cu2S]
    type = ElementIntegralVariablePostprocessor
    block = 'Copper Solution'
    variable = Cu2S
  [../]
[]

[Outputs]
  exodus = true
[]

[Mesh]
   type = GeneratedMesh
   dim = 1
   nx = 1
[]

[Variables]
  # Name of chemical species
  [./H+]
#   block = 'Solution'
   order = FIRST
   initial_condition = 1E-4 #[mol/m3] at 25 C with 1mol/l of HS- in solution (Na2S)
  [../]
  [./OH-]
#   block = 'Solution'
   order =FIRST
   initial_condition = 1E-4 #[mol/m3]
  [../]
  [./H2O]
#   block = 'Solution'
   order = FIRST
   initial_condition = 55347 #[mol/m3] at 25 C
  [../]
  [./H2O2]
#    block = 'Solution'
    order = FIRST
    initial_condition = 0  #[mol/m3]
  [../]
  [./O2]
#    block = 'Solution'
    order = FIRST
    initial_condition = 0 #[mol/m3]
  [../]
  [./OH]
#    block = 'Solution'
    order = FIRST
    initial_condition = 0 #[mol/m3]
  [../]
  [./H2]
#    block = 'Solution'
    order = FIRST
    initial_condition = 0 #[mol/m3]
  [../]
  [./H]
#    block = 'Solution'
    order = FIRST
    initial_condition = 0 #[mol/m3]
  [../]  
  [./HO2-]
#    block = 'Solution'
    order = FIRST
    initial_condition = 0 #[mol/m3]
  [../]  
  [./O2-]
#    block = 'Solution'
    order = FIRST
    initial_condition = 0 #[mol/m3]
  [../] 
  [./eaq-]
#    block = 'Solution'
    order = FIRST
    initial_condition = 0 #[mol/m3]
  [../]  
  [./HO2]
#    block = 'Solution'
    order = FIRST
    initial_condition = 0 #[mol/m3]
  [../]
  [./T]
#    block = 'Solution'
    order = FIRST
    family = LAGRANGE
    initial_condition = 298.15 #[K]
  [../]
[]

[Kernels]
# dCi/dt
  [./dH2O_dt]
#    block = 'Solution'
    type = TimeDerivative
    variable = H2O
  [../]
  [./dHp_dt]
#    block = 'Solution'
    type = TimeDerivative
    variable = H+
  [../]
  [./dOHm_dt]
#    block = 'Solution'
    type = TimeDerivative
    variable = OH-
  [../]
  [./dH2O2_dt]
#    block = 'Solution'
    type = TimeDerivative
    variable = H2O2
  [../]
  [./dO2_dt]
#    block = 'Solution'
    type = TimeDerivative
    variable = O2
  [../]
  [./dOH_dt]
#    block = 'Solution'
    type = TimeDerivative
    variable = OH
  [../]
  [./dH2_dt]
#    block = 'Solution'
    type = TimeDerivative
    variable = H2
  [../]
  [./dH_dt]
#    block = 'Solution'
    type = TimeDerivative
    variable = H
  [../]
  [./dHO2m_dt]
#    block = 'Solution'
    type = TimeDerivative
    variable = HO2-
  [../]
  [./dO2m_dt]
#    block = 'Solution'
    type = TimeDerivative
    variable = O2-
  [../]
  [./deaqm_dt]
#    block = 'Solution'
    type = TimeDerivative
    variable = eaq-
  [../]
  [./dHO2_dt]
#    block = 'Solution'
    type = TimeDerivative
    variable = HO2
  [../]  
# HeatConduction terms
  [./heat]
#    block = 'Solution'
    type = HeatConduction
    variable = T
  [../]
  [./ie]
#    block = 'Solution'
    type = HeatConductionTimeDerivative
    variable = T
  [../]
# Radiolysis source terms
  [./Source_Hp]
#     block = 'Solution'
  type = Source
  variable = H+
  Source = 8.8E-5
  [../]
  [./Source_OHm]
#     block = 'Solution'
  type = Source
  variable = OH-
  Source = 1.8E-5
  [../]  
  [./Source_eaqm]
#     block = 'Solution'
  type = Source
  variable = eaq-
  Source = 7E-5 
  [../] 
  [./Source_H]
#     block = 'Solution'
  type = Source
  variable = H
  Source = 1.55E-5
  [../] 
  [./Source_H2]
#     block = 'Solution'
  type = Source
  variable = H2
  Source = 1.2E-5
  [../]  
  [./Source_OH]
#     block = 'Solution'
  type = Source
  variable = OH
  Source = 7.2E-5
  [../]
  [./Source_H2O2]
#     block = 'Solution'
  type = Source
  variable = H2O2
  Source = 1.8E-5
  [../]  
[]

#unit = 1/s
[ChemicalReactions]
 [./Network]
#   block = 'Solution'
   block = 0
   species = 'H+ OH- H2O H2O2 O2 OH H2 H HO2- O2- eaq- HO2'
   track_rates = False

   equation_constants = 'Ea R T_Re CH2O k2 k3 k4 k5 k6'
   equation_values = '0 8.314 298.15 55347 10^-15.7 10^-11.7 10^-11.9 10^-4.8 10^-9.77'
   equation_variables = 'T'

   reactions = '
OH + H2 -> H + H2O : {3.74E7/1000*exp(-18E3/R*(1/T_Re-1/T))}
OH + HO2- -> HO2 + OH- : {5E9/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
OH + H2O2 -> HO2 + H2O : {3.8E7/1000*exp(-14E3/R*(1/T_Re-1/T))}
OH + O2- -> OH- + O2 : {9.96E9/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
OH + HO2 -> H2O + O2 : {7.1E9/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
OH + OH -> H2O2 : {5.3E9/1000*exp(-8E3/R*(1/T_Re-1/T))}
OH + eaq- -> OH- : {3E10/1000*exp(-12.6E3/R*(1/T_Re-1/T))}

H + O2 -> HO2 : {2E10/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
H + O2- -> HO2- : {2E10/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
H + HO2 -> H2O2 : {2E10/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
H + H2O2 -> OH + H2O : {3.44E7/1000*exp(-13.6E3/R*(1/T_Re-1/T))}
H + OH -> H2O : {7E9/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
H + H -> H2 : {7.9E9/1000*exp(-12.6E3/R*(1/T_Re-1/T))}

eaq- + O2 -> O2- : {1.94E10/1000*exp(-13E3/R*(1/T_Re-1/T))}
eaq- + O2- -> HO2- + OH- : {1.3E10/1000*exp(-18.8E3/R*(1/T_Re-1/T))}
eaq- + HO2 -> HO2- : {2E10/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
eaq- + H -> H2 + OH- : {2.5E10/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
eaq- + H2O2 -> OH + OH- : {1.14E10/1000*exp(-15.1E3/R*(1/T_Re-1/T))}
eaq- + H+ -> H : {2.3E10/1000*exp(-12.2E3/R*(1/T_Re-1/T))}
eaq- + eaq- -> H2 + OH- + OH- : {5.6E9/1000*exp(-20.5E3/R*(1/T_Re-1/T))}

HO2 + O2- -> HO2- + O2 : {9.5E7/1000*exp(-8.8E3/R*(1/T_Re-1/T))}
HO2 + HO2 -> H2O2 + O2 : {8.1E5/1000*exp(-24.7E3/R*(1/T_Re-1/T))}
HO2 + H2O2 -> OH + O2 + H2O : {3.7/1000*exp(-20E3/R*(1/T_Re-1/T))}
HO2 -> H+ + O2- : {7E5*exp(-12.6E3/R*(1/T_Re-1/T))}
H+ + O2- -> HO2 : {4.5E10/1000*exp(-12.6E3/R*(1/T_Re-1/T))}

H2O2 -> H+ + HO2- : {0.0356*exp(-12.6E3/R*(1/T_Re-1/T))}
H+ + HO2- -> H2O2 : {2E10/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
H+ + OH- -> H2O : {1.4E11/1000*exp(-12.6E3/R*(1/T_Re-1/T))}

H2O -> H+ + OH- : {2.5E-5*exp(-45.4E3/R*(1/T_Re-1/T))}

H + OH- -> eaq- + H2O : {1.8E7/1000*exp(-26E3/R*(1/T_Re-1/T))}

O2- + O2- -> O2 + HO2- + OH- : {0.3/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
O2- + H2O2 -> OH + O2 + OH- : {16/1000*exp(-20E3/R*(1/T_Re-1/T))}
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
  end_time = 10000 #[s]
  solve_type = 'PJFNK'
#  l_abs_tol = 1e-4 #1e-3 
#  l_tol = 1e-5 #1e-5
#  nl_abs_tol = 1e-4 #1e-3
  nl_rel_tol = 1e-2  #1e-7
  l_max_its = 40
  nl_max_its = 40
  dtmax = 10 
  [./TimeStepper]
    type = IterationAdaptiveDT
    cutback_factor = 0.99
    dt = 1e-7
    growth_factor = 1.01
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

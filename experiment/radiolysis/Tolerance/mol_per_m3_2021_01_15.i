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
  [./HS-]
#    block = 'Solution'
    order = FIRST
    initial_condition = 0 #[mol/m3]
  [../]
  [./H2O2]
#    block = 'Solution'
    order = FIRST
    initial_condition = 0  #[mol/m3]
  [../]
  [./SO42-]
#    block = 'Solution'
    order = FIRST
    initial_condition = 0 #[mol/m3]
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
  [./O-]
#    block = 'Solution'
    order = FIRST
    initial_condition = 0 #[mol/m3]
  [../]
  [./O3]
#    block = 'Solution'
    order = FIRST
    initial_condition = 0 #[mol/m3]
  [../]
  [./O3-]
#    block = 'Solution'
    order = FIRST
    initial_condition = 0 #[mol/m3]
  [../]  
  [./HO3]
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
  [./pH]
#    block = 'Solution'
    order = FIRST
    family = LAGRANGE
    initial_condition = 11.00 #[pH = log(H+)]
  [../]
[]

[Kernels]
# dCi/dt
  [./dHS_dt]
#    block = 'Solution'
    type = TimeDerivative
    variable = HS-
  [../]
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
  [./dpH_dt]
#    block = 'Solution'
    type = TimeDerivative
    variable = pH
  [../]
  [./dH2O2_dt]
#    block = 'Solution'
    type = TimeDerivative
    variable = H2O2
  [../]
  [./dSO42m_dt]
#    block = 'Solution'
    type = TimeDerivative
    variable = SO42-
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
  [./dOm_dt]
#    block = 'Solution'
    type = TimeDerivative
    variable = O-
  [../]  
  [./dO3_dt]
#    block = 'Solution'
    type = TimeDerivative
    variable = O3
  [../]  
  [./dO3m_dt]
#    block = 'Solution'
    type = TimeDerivative
    variable = O3-
  [../]
  [./dHO3_dt]
#    block = 'Solution'
    type = TimeDerivative
    variable = HO3
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
  Source = 8.00838E-5
  [../]
  [./Source_OHm]
#     block = 'Solution'
  type = Source
  variable = OH-
  Source = 1.29167E-5
  [../]  
  [./Source_eaqm]
#     block = 'Solution'
  type = Source
  variable = eaq-
  Source = 6.71671E-5
  [../] 
  [./Source_H]
#     block = 'Solution'
  type = Source
  variable = H
  Source = 1.70501E-5
  [../] 
  [./Source_H2]
#     block = 'Solution'
  type = Source
  variable = H2
  Source = 1.16251E-5
  [../]  
  [./Source_OH]
#     block = 'Solution'
  type = Source
  variable = OH
  Source = 6.97504E-5
  [../]
  [./Source_H2O2]
#     block = 'Solution'
  type = Source
  variable = H2O2
  Source = 1.80834E-5
  [../]   
  [./Source_HO2]
#     block = 'Solution'
  type = Source
  variable = HO2
  Source = 5.1667E-7
  [../] 
[]

#unit = 1/s
[ChemicalReactions]
 [./Network]
#   block = 'Solution'
   block = 0
   species = 'H+ OH- H2O H2O2 SO42- O2 HS- OH H2 H HO2- O2- eaq- HO2 O- O3 O3- HO3'
   track_rates = False

   equation_constants = 'Ea R T_Re CH2O k2 k3 k4 k5 k6'
   equation_values = '0 8.314 298.15 55347 10^-15.7 10^-11.7 10^-11.9 10^-4.8 10^-9.77'
   equation_variables = 'T pH'

   reactions = '
H+ + OH- -> H2O : {1.4E11/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
H2O -> H+ + OH- : {1.4E11*k2/CH2O*exp(-45.4E3/R*(1/T_Re-1/T))}
H2O2 -> HO2- + H+ : {5E10*k3*exp(Ea/R*(1/T_Re-1/T))}
H+ + HO2- -> H2O2 : {2E10/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
H2O2 + OH- -> HO2- + H2O : {1.3E10/1000*exp(Ea/R*(1/T_Re-1/T))}
HO2- + H2O -> H2O2 + OH- : {1.3E10*k2/k3*CH2O/1000*exp(Ea/R*(1/T_Re-1/T))}
eaq- + H2O -> H + OH- : {1.9E1/1000*exp(Ea/R*(1/T_Re-1/T))}
H + OH- -> eaq- + H2O : {1.8E7/1000*exp(-26E3/R*(1/T_Re-1/T))}
H -> eaq- + H+ : {2.3E10*k6*exp(Ea/R*(1/T_Re-1/T))}
eaq- + H+ -> H : {2.3E10/1000*exp(-12.2E3/R*(1/T_Re-1/T))}
OH + OH- -> O- + H2O : {1.3E10/1000*exp(Ea/R*(1/T_Re-1/T))}
O- + H2O -> OH + OH- : {1.3E10*k2/k4*CH2O/1000*exp(Ea/R*(1/T_Re-1/T))}
OH -> O- + H+ : {1E11*k4*exp(Ea/R*(1/T_Re-1/T))}
O- + H+ -> OH : {1E11/1000*exp(Ea/R*(1/T_Re-1/T))}
HO2 -> O2- + H+ : {5E10*k5*exp(-12.6E3/R*(1/T_Re-1/T))}
O2- + H+ -> HO2 : {4.5E10/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
HO2 + OH- -> O2- + H2O : {5E10/1000*exp(Ea/R*(1/T_Re-1/T))}
O2- + H2O -> HO2 + OH- : {5E10*k2/k5*CH2O/1000*exp(Ea/R*(1/T_Re-1/T))}

eaq- + OH -> OH- : {3E10/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
eaq- + H2O2 -> OH + OH- : {1.1E10/1000*exp(-15.1E3/R*(1/T_Re-1/T))}
eaq- + O2- + H2O -> HO2- + OH- : {1.3E10/CH2O/1000*exp(-18.8E3/R*(1/T_Re-1/T))}
eaq- + HO2 -> HO2- : {2E10/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
eaq- + O2 -> O2- : {1.9E10/1000*exp(-13E3/R*(1/T_Re-1/T))}
eaq- + eaq- + H2O + H2O -> H2 + OH- + OH- : {5.5E9/CH2O/1000*exp(-20.5E3/R*(1/T_Re-1/T))}
eaq- + H + H2O -> H2 + OH- : {2.5E10/CH2O/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
eaq- + HO2- -> O- + OH- : {3.5E9/1000*exp(Ea/R*(1/T_Re-1/T))}
eaq- + O- + H2O -> OH- + OH- : {2.2E10/CH2O/1000*exp(Ea/R*(1/T_Re-1/T))}
eaq- + O3- + H2O -> O2 + OH- + OH- : {1.6E10/CH2O/1000*exp(Ea/R*(1/T_Re-1/T))}
eaq- + O3 -> O3- : {3.6E10/1000*exp(Ea/R*(1/T_Re-1/T))}

H + H2O -> H2 + OH : {1.1E1/1000*exp(Ea/R*(1/T_Re-1/T))}
H + O- -> OH- : {1E10/1000*exp(Ea/R*(1/T_Re-1/T))}
H + HO2- -> OH + OH- : {9E7/1000*exp(Ea/R*(1/T_Re-1/T))}
H + O3- -> OH- + O2 : {1E10/1000*exp(Ea/R*(1/T_Re-1/T))}
H + H -> H2 : {7.8E9/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
H + OH -> H2O : {7E9/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
H + H2O2 -> OH + H2O : {9E7/1000*exp(-13.6E3/R*(1/T_Re-1/T))}
H + O2 -> HO2 : {2.1E10/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
H + HO2 -> H2O2 : {1E10/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
H + O2- -> HO2- : {2E10/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
H + O3 -> HO3 : {3.8E10/1000*exp(Ea/R*(1/T_Re-1/T))}

OH + OH -> H2O2 : {5.5E9/1000*exp(-8E3/R*(1/T_Re-1/T))}
OH + HO2 -> H2O + O2 : {6E9/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
OH + O2- -> OH- + O2 : {8E9/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
OH + H2 -> H + H2O : {4.2E7/1000*exp(-18E3/R*(1/T_Re-1/T))}
OH + H2O2 -> HO2 + H2O : {2.7E7/1000*exp(-14E3/R*(1/T_Re-1/T))}
OH + O- -> HO2- : {2.5E10/1000*exp(Ea/R*(1/T_Re-1/T))}
OH + HO2- -> HO2 + OH- : {7.5E9/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
OH + O3- -> O3 + OH- : {2.6E9/1000*exp(Ea/R*(1/T_Re-1/T))}
OH + O3- -> O2- + O2- + H+ : {6E9/1000*exp(Ea/R*(1/T_Re-1/T))}
OH + O3 -> HO2 + O2 : {1.1E8/1000*exp(Ea/R*(1/T_Re-1/T))}

HO2 + O2- -> HO2- + O2 : {9.5E7/1000*exp(-8.8E3/R*(1/T_Re-1/T))}
HO2 + HO2 -> H2O2 + O2 : {8.1E5/1000*exp(-24.7E3/R*(1/T_Re-1/T))}
HO2 + O- -> O2 + OH- : {6E9/1000*exp(Ea/R*(1/T_Re-1/T))}
HO2 + H2O2 -> OH + O2 + H2O : {3.7/1000*exp(-20E3/R*(1/T_Re-1/T))}
HO2 + HO2- -> OH + O2 + OH- : {5E-1/1000*exp(Ea/R*(1/T_Re-1/T))}
HO2 + O3- -> O2 + O2 + OH- : {6E9/1000*exp(Ea/R*(1/T_Re-1/T))}
HO2 + O3 -> HO3 + O2 : {5E8/1000*exp(Ea/R*(1/T_Re-1/T))}

O2- + O2- + H2O + H2O -> H2O2 + O2 + OH- + OH- : {1E2/(2*CH2O)/1000*exp(Ea/R*(1/T_Re-1/T))}
O2- + O- + H2O -> O2 + OH- + OH- : {6E8/CH2O/1000*exp(Ea/R*(1/T_Re-1/T))}
O2- + H2O2 -> OH + O2 + OH- : {16/1000*exp(-20E3/R*(1/T_Re-1/T))}
O2- + HO2- -> O- + O2 + OH- : {1.3E-1/1000*exp(Ea/R*(1/T_Re-1/T))}
O2- + O3- + H2O -> O2 + O2 + OH- + OH- : {1E4/CH2O/1000*exp(Ea/R*(1/T_Re-1/T))}
O2- + O3 -> O3- + O2 : {1.5E9/1000*exp(Ea/R*(1/T_Re-1/T))}

O- + O- + H2O -> HO2- + OH- : {1E9/CH2O/1000*exp(Ea/R*(1/T_Re-1/T))}
O- + O2 -> O3- : {3.6E9/1000*exp(Ea/R*(1/T_Re-1/T))}
O- + H2 -> H + OH- : {8E7/1000*exp(Ea/R*(1/T_Re-1/T))}
O- + H2O2 -> O2- + H2O : {5E8/1000*exp(Ea/R*(1/T_Re-1/T))}
O- + HO2- -> O2- + OH- : {4E8/1000*exp(Ea/R*(1/T_Re-1/T))}
O- + O3- -> O2- + O2- : {7E8/1000*exp(Ea/R*(1/T_Re-1/T))}
O- + O3 -> O2- + O2 : {5E9/1000*exp(Ea/R*(1/T_Re-1/T))}

O3- -> O2 + O- : {3.3E3*exp(Ea/R*(1/T_Re-1/T))}
O3- + H+ -> O2 + OH : {9E10/1000*exp(Ea/R*(1/T_Re-1/T))}
HO3 -> O2 + OH : {1.1E5*exp(Ea/R*(1/T_Re-1/T))}
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
  end_time = 1e2 #[s]
  solve_type = 'PJFNK'
#  l_abs_tol = 1e-3 #1e-11 for HS- + H2O2
#  l_tol = 1e-1 #default = 1e-5
#  nl_abs_tol = 1e-15 #1e-11 for HS- + H2O2
  nl_rel_tol = 1e-1  #default = 1e-7
  l_max_its = 100
  nl_max_its = 5
  automatic_scaling = true
  compute_scaling_once = false
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
  file_base = mol_per_m3_unit
#  sync_times = '1e-7 1e-6 1e-5 1e-4 1e-3 1e-2 1e-1 1 5 1e1 2e1 3e1 5e1 7e1 1e2 3e2 5e2 7e2 1e33e3 5e3 7e3  1e4'
  exodus = true
[]

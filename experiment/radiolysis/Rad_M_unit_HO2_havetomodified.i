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
   initial_condition = 1E-7 #[mol/m3] at 25 C with 1mol/l of HS- in solution (Na2S)
  [../]
  [./OH-]
#   block = 'Solution'
   order =FIRST
   initial_condition = 1E-7 #[mol/m3]
  [../]
  [./H2O]
#   block = 'Solution'
   order = FIRST
   initial_condition = 55.347 #[mol/m3] at 25 C
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
  Source = 8.00838E-8
  [../]
  [./Source_OHm]
#     block = 'Solution'
  type = Source
  variable = OH-
  Source = 1.29167E-8 
  [../]  
  [./Source_eaqm]
#     block = 'Solution'
  type = Source
  variable = eaq-
  Source = 6.71671E-8
  [../] 
  [./Source_H]
#     block = 'Solution'
  type = Source
  variable = H
  Source = 1.70501E-8 
  [../] 
  [./Source_H2]
#     block = 'Solution'
  type = Source
  variable = H2
  Source = 1.16251E-8
  [../]  
  [./Source_OH]
#     block = 'Solution'
  type = Source
  variable = OH
  Source = 6.97504E-8
  [../]
  [./Source_H2O2]
#     block = 'Solution'
  type = Source
  variable = H2O2
  Source = 1.80834E-8 
  [../]   
  [./Source_HO2]
#     block = 'Solution'
  type = Source
  variable = HO2
  Source = 5.1667E-10
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
   equation_values = '20 8.314 298.15 55.347 10^-13.999 10^-11.65 10^-11.9 10^-4.57 10^-9.77'
   equation_variables = 'T pH'

   reactions = '
H+ + OH- -> H2O : {1.4E11}
H2O -> H+ + OH- : {1.4E11*k2/CH2O}
H2O2 -> HO2- + H+ : {5E10*k3}
H+ + HO2- -> H2O2 : {5E10}
H2O2 + OH- -> HO2- + H2O : {1.3E10}
HO2- + H2O -> H2O2 + OH- : {1.3E10*k2/k3*CH2O}
eaq- + H2O -> H + OH- : {1.9E1}
H + OH- -> eaq- + H2O : {2.2E7}
H -> eaq- + H+ : {2.3E10*k6}
eaq- + H+ -> H : {2.3E10}
OH + OH- -> O- + H2O : {1.3E10}
O- + H2O -> OH + OH- : {1.3E10*k2/k4*CH2O}
OH -> O- + H+ : {1E11*k4}
O- + H+ -> OH : {1E11}
HO2 -> O2- + H+ : {5E10*k5}
O2- + H+ -> HO2 : {5E10}
HO2 + OH- -> O2- + H2O : {5E10}
O2- + H2O -> HO2 + OH- : {5E10*k2/k5*CH2O}

eaq- + OH -> OH- : {3E10}
eaq- + H2O2 -> OH + OH- : {1.1E10}
eaq- + O2- + H2O -> HO2- + OH- : {1.3E10/CH2O}
eaq- + HO2 -> HO2- : {2E10}
eaq- + O2 -> O2- : {1.9E10}
eaq- + eaq- + H2O + H2O -> H2 + OH- + OH- : {5.5E9/CH2O}
eaq- + H + H2O -> H2 + OH- : {2.5E10/CH2O}
eaq- + HO2- -> O- + OH- : {3.5E9}
eaq- + O- + H2O -> OH- + OH- : {2.2E10/CH2O}
eaq- + O3- + H2O -> O2 + OH- + OH- : {1.6E10/CH2O}
eaq- + O3 -> O3- : {3.6E10}

H + H2O -> H2 + OH : {1.1E1}
H + O- -> OH- : {1E10}
H + HO2- -> OH + OH- : {9E7}
H + O3- -> OH- + O2 : {1E10}
H + H -> H2 : {7.8E9}
H + OH -> H2O : {7E9}
H + H2O2 -> OH + H2O : {9E7}
H + O2 -> HO2 : {2.1E10}
H + HO2 -> H2O2 : {1.8E10}
H + O2- -> HO2- : {1.8E10}
H + O3 -> HO3 : {3.8E10}

OH + OH -> H2O2 : {3.6E9}
OH + HO2 -> H2O + O2 : {6E9}
OH + O2- -> OH- + O2 : {8.2E9}
OH + H2 -> H + H2O : {4.3E7}
OH + H2O2 -> HO2 + H2O : {2.7E7}
OH + O- -> HO2- : {2.5E10}
OH + HO2- -> HO2 + OH- : {7.5E9}
OH + O3- -> O3 + OH- : {2.6E9}
OH + O3- -> O2- + O2- + H+ : {6E9}
OH + O3 -> HO2 + O2 : {1.1E8}

HO2 + O2- -> HO2- + O2 : {8E7}
HO2 + HO2 -> H2O2 + O2 : {7E5}
HO2 + O- -> O2 + OH- : {6E9}
HO2 + H2O2 -> OH + O2 + H2O : {5E-1}
HO2 + HO2- -> OH + O2 + OH- : {5E-1}
HO2 + O3- -> O2 + O2 + OH- : {6E9}
HO2 + O3 -> HO3 + O2 : {5E8}

O2- + O2- + H2O + H2O -> H2O2 + O2 + OH- + OH- : {1E2/(2*CH2O)}
O2- + O- + H2O -> O2 + OH- + OH- : {6E8/CH2O}
O2- + H2O2 -> OH + O2 + OH- : {1.3E-1}
O2- + HO2- -> O- + O2 + OH- : {1.3E-1}
O2- + O3- + H2O -> O2 + O2 + OH- + OH- : {1E4/CH2O}
O2- + O3 -> O3- + O2 : {1.5E9}

O- + O- + H2O -> HO2- + OH- : {1E9/CH2O}
O- + O2 -> O3- : {3.6E9}
O- + H2 -> H + OH- : {8E7}
O- + H2O2 -> O2- + H2O : {5E8}
O- + HO2- -> O2- + OH- : {4E8}
O- + O3- -> O2- + O2- : {7E8}
O- + O3 -> O2- + O2 : {5E9}

O3- -> O2 + O- : {3.3E3}
O3- + H+ -> O2 + OH : {9E10}
HO3 -> O2 + OH : {1.1E5}
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
  start_time = 1e-8 #[s]
  end_time = 10000 #[s]
#  solve_type = 'NEWTON'
  solve_type = 'PJFNK'
#  l_abs_tol = 1e-4 #1e-11 for HS- + H2O2
#  l_tol = 1e-3 #default = 1e-5
#  nl_abs_tol = 1e-7 #1e-11 for HS- + H2O2
#  nl_abs_step_tol = 1e-3
  nl_rel_tol = 1e-1  #default = 1e-7
  l_max_its = 40
  nl_max_its = 40
  dtmax = 10

 petsc_options_iname = '-pc_type  -sub_pc_type '
 petsc_options_value = 'asm       lu'
 
  [./TimeStepper]
    type = IterationAdaptiveDT
    cutback_factor = 0.99
    dt = 1e-8
    growth_factor = 1.01
    optimal_iterations = 10
  [../]
#  automatic_scaling = true
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

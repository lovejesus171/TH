[Mesh]
   file = '2D_Experiment.msh'
[]

[Variables]
  # Name of chemical species
  [./H+]
   block = 'Solution'
   order = FIRST
   initial_condition = 1E-4 #[mol/m3] at 25 C with 1mol/l of HS- in solution (Na2S)
  [../]
  [./OH-]
   block = 'Solution'
   order =FIRST
   initial_condition = 1E-4 #[mol/m3]
  [../]
  [./H2O]
   block = 'Solution'
   order = FIRST
   initial_condition = 55347 #[mol/m3] at 25 C
  [../]
  [./HS-]
    block = 'Solution'
    order = FIRST
    initial_condition = 1E-3 #[mol/m3]
  [../]
  [./H2O2]
    block = 'Solution'
    order = FIRST
    initial_condition = 0  #[mol/m3]
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
  [./OH]
    block = 'Solution'
    order = FIRST
    initial_condition = 0 #[mol/m3]
  [../]
  [./H2]
    block = 'Solution'
    order = FIRST
    initial_condition = 0 #[mol/m3]
  [../]
  [./H]
    block = 'Solution'
    order = FIRST
    initial_condition = 0 #[mol/m3]
  [../]  
  [./HO2-]
    block = 'Solution'
    order = FIRST
    initial_condition = 0 #[mol/m3]
  [../]  
  [./O2-]
    block = 'Solution'
    order = FIRST
    initial_condition = 0 #[mol/m3]
  [../] 
  [./eaq-]
    block = 'Solution'
    order = FIRST
    initial_condition = 0 #[mol/m3]
  [../]  
  [./HO2]
    block = 'Solution'
    order = FIRST
    initial_condition = 0 #[mol/m3]
  [../]
  [./O-]
    block = 'Solution'
    order = FIRST
    initial_condition = 0 #[mol/m3]
  [../]
  [./O3]
    block = 'Solution'
    order = FIRST
    initial_condition = 0 #[mol/m3]
  [../]
  [./O3-]
    block = 'Solution'
    order = FIRST
    initial_condition = 0 #[mol/m3]
  [../]  
  [./HO3]
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
  [./dOH_dt]
    block = 'Solution'
    type = TimeDerivative
    variable = OH
  [../]
  [./dH2_dt]
    block = 'Solution'
    type = TimeDerivative
    variable = H2
  [../]
  [./dH_dt]
    block = 'Solution'
    type = TimeDerivative
    variable = H
  [../]
  [./dHO2m_dt]
    block = 'Solution'
    type = TimeDerivative
    variable = HO2-
  [../]
  [./dO2m_dt]
    block = 'Solution'
    type = TimeDerivative
    variable = O2-
  [../]
  [./deaqm_dt]
    block = 'Solution'
    type = TimeDerivative
    variable = eaq-
  [../]
  [./dHO2_dt]
    block = 'Solution'
    type = TimeDerivative
    variable = HO2
  [../]  
  [./dOm_dt]
    block = 'Solution'
    type = TimeDerivative
    variable = O-
  [../]  
  [./dO3_dt]
    block = 'Solution'
    type = TimeDerivative
    variable = O3
  [../]  
  [./dO3m_dt]
    block = 'Solution'
    type = TimeDerivative
    variable = O3-
  [../]
  [./dHO3_dt]
    block = 'Solution'
    type = TimeDerivative
    variable = HO3
  [../]
 
  
# Radiolysis source terms
  [./Source_Hp]
     block = 'Solution'
  type = Source
  variable = H+
  Source = 0.8008
  [../]
  [./Source_OHm]
     block = 'Solution'
  type = Source
  variable = OH-
  Source = 0.1292 
  [../]  
  [./Source_eaqm]
     block = 'Solution'
  type = Source
  variable = eaq-
  Source = 0.6717 
  [../] 
  [./Source_H]
     block = 'Solution'
  type = Source
  variable = H
  Source = 0.1705 
  [../] 
  [./Source_H2]
     block = 'Solution'
  type = Source
  variable = H2
  Source = 0.1163 
  [../]  
  [./Source_OH]
     block = 'Solution'
  type = Source
  variable = OH
  Source = 0.6975 
  [../]
  [./Source_H2O2]
     block = 'Solution'
  type = Source
  variable = H2O2
  Source = 0.1808 
  [../]   
  [./Source_HO2]
     block = 'Solution'
  type = Source
  variable = HO2
  Source = 0.0052 
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
  
  [./DgradOH]
    block = 'Solution'
    type = CoefDiffusion
    coef = 2.31e-9 #[m2/s], 
    variable = OH
  [../]
  [./DgradH2]
    block = 'Solution'
    type = CoefDiffusion
    coef = 4.58e-9 #[m2/s], 
    variable = H2
  [../] 
  [./DgradH]
    block = 'Solution'
    type = CoefDiffusion
    coef = 7e-9 #[m2/s], 
    variable = H
  [../]
  [./DgradHO2m]
    block = 'Solution'
    type = CoefDiffusion
    coef = 1.75e-9 #[m2/s], 
    variable = HO2-
  [../]
  [./DgradO2m]
    block = 'Solution'
    type = CoefDiffusion
    coef = 1.75e-9 #[m2/s], 
    variable = O2-
  [../]
  [./Dgradeaqm]
    block = 'Solution'
    type = CoefDiffusion
    coef = 4.5e-9 #[m2/s], 
    variable = eaq-
  [../] 
  [./DgradHO2]
    block = 'Solution'
    type = CoefDiffusion
    coef = 1.75e-9 #[m2/s], 
    variable = HO2
  [../]
  [./DgradOm]
    block = 'Solution'
    type = CoefDiffusion
    coef = 2e-9 #[m2/s], to be added
    variable = O-
  [../]
  [./DgradO3]
    block = 'Solution'
    type = CoefDiffusion
    coef = 2e-9 #[m2/s], to be added
    variable = O3
  [../]
  [./DgradO3m]
    block = 'Solution'
    type = CoefDiffusion
    coef = 2e-9 #[m2/s], to be added
    variable = O3-
  [../] 
  [./DgradHO3]
    block = 'Solution'
    type = CoefDiffusion
    coef = 2e-9 #[m2/s], to be added
    variable = HO3
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

#unit = 1/s
[ChemicalReactions]
 [./Network]
   block = 'Solution'
   species = 'H+ OH- H2O H2O2 SO42- O2 HS- OH H2 H HO2- O2- eaq- HO2 O- O3 O3- HO3'
   track_rates = False

   equation_constants = 'Ea R T_Re CH2O k2 k3 k4 k5 k6'
   equation_values = '20 8.314 298.15 55347 10^-13.999 10^-11.65 10^-11.9 10^-4.57 10^-9.77'
   equation_variables = 'T pH'

   reactions = '
HS- + H2O2 + H2O2 + H2O2 + H2O2 -> OH- + H+ + H+ + SO42- : {5.5e-4*exp(-51.3e3/R*(1/T_Re-1/T))}
HS- + O2 -> SO42- + H+ : {3.6*10^(11.78-3000/T)}

H2O2 -> H2O : {1.15E7*exp(-25400/(R*T))}
H2O2 -> H2O + O2 : {1.15E7*exp(-25400/(R*T))}

H+ + OH- -> H2O : {1.4E11/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
H2O -> H+ + OH- : {1.4E11*k2/CH2O*exp(-45.4E3/R*(1/T_Re-1/T))}
H+ + HO2- -> H2O2 : {2E10/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
H + OH- -> eaq- + H2O : {1.8E7/1000*exp(-26E3/R*(1/T_Re-1/T))}
eaq- + H+ -> H : {2.3E10/1000*exp(-12.2E3/R*(1/T_Re-1/T))}
HO2 -> O2- + H+ : {5E10*k5*exp(-12.6E3/R*(1/T_Re-1/T))}
O2- + H+ -> HO2 : {4.5E10/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
eaq- + OH -> OH- : {3E10/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
eaq- + H2O2 -> OH + OH- : {1.1E10/1000*exp(-15.1E3/R*(1/T_Re-1/T))}
eaq- + O2- + H2O -> HO2- + OH- : {1.3E10/CH2O/1000*exp(-18.8E3/R*(1/T_Re-1/T))}
eaq- + HO2 -> HO2- : {2E10/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
eaq- + O2 -> O2- : {1.9E10/1000*exp(-13E3/R*(1/T_Re-1/T))}
eaq- + eaq- + H2O + H2O -> H2 + OH- + OH- : {5.5E9/CH2O/1000*exp(-20.5E3/R*(1/T_Re-1/T))}
eaq- + H + H2O -> H2 + OH- : {2.5E10/CH2O/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
H + H -> H2 : {7.8E9/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
H + OH -> H2O : {7E9/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
H + H2O2 -> OH + H2O : {9E7/1000*exp(-13.6E3/R*(1/T_Re-1/T))}
H + O2 -> HO2 : {2.1E10/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
H + HO2 -> H2O2 : {1E10/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
H + O2- -> HO2- : {2E10/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
OH + OH -> H2O2 : {5.5E9/1000*exp(-8E3/R*(1/T_Re-1/T))}
OH + HO2 -> H2O + O2 : {6E9/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
OH + O2- -> OH- + O2 : {8E9/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
OH + H2 -> H + H2O : {4.2E7/1000*exp(-18E3/R*(1/T_Re-1/T))}
OH + H2O2 -> HO2 + H2O : {2.7E7/1000*exp(-14E3/R*(1/T_Re-1/T))}
OH + HO2- -> HO2 + OH- : {7.5E9/1000*exp(-12.6E3/R*(1/T_Re-1/T))}
HO2 + O2- -> HO2- + O2 : {9.5E7/1000*exp(-8.8E3/R*(1/T_Re-1/T))}
HO2 + HO2 -> H2O2 + O2 : {8.1E5/1000*exp(-24.7E3/R*(1/T_Re-1/T))}
HO2 + H2O2 -> OH + O2 + H2O : {3.7/1000*exp(-20E3/R*(1/T_Re-1/T))}
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

[BCs]
 [./Cu_top]
   type = DirichletBC
   variable = HS-
   boundary = Copper_top
   value = 0
 [../]
 [./Cu_side]
   type = DirichletBC
   variable = HS-
   boundary = Copper_side
   value = 0
 [../]
[]


[Executioner]
  type = Transient
  start_time = 0 #[s]
  end_time = 100 #[s]
  solve_type = 'PJFNK'
#  l_abs_tol = 1e-5 #1e-11 for HS- + H2O2
#  l_tol = 1e-5 #default = 1e-5
  nl_abs_tol = 1e-5 #1e-11 for HS- + H2O2
#  nl_rel_tol = 1e-7  #default = 1e-7
  l_max_its = 100
  nl_max_its = 100
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

[Postprocessors]
  [./Consumed_HS_mol_per_s]
   type = SideFluxIntegral
   variable = HS-
   diffusivity = 7.31E-10 #m2/s
   boundary = Copper_top
  [../]
[]


[Outputs]
  exodus = true
[]

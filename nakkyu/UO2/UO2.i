[Mesh]
  file = 'UO2.msh'
  construct_side_list_from_node_list = true
[]
#[UserObjects]
#  [./changeID]
#    block = 'Alpha Solution'
#    type = ActivateElementsCoupled
#    execute_on = timestep_begin
#    coupled_var = Cu2S
#    activate_value = 2.487
#    activate_type = above
#    active_subdomain_id = 3
#    expand_boundary_name = Interface
#  [../]
#[]


[Variables]
  # Name of chemical species
  [./UO22+]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./UO32H2O]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./H]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./H2O2]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./UO2O24H2O]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./H2]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./H+]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./UO2CO322-]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./CO32-]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./Fe2+]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./OH-]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./Fe2O3]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./UO2_precip]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./O2]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./H2O]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./UOH4]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./UO2CO334-]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]


  [./T]
    block = 'Alpha Solution'
    order = FIRST
    family = LAGRANGE
    initial_condition = 298.15 #[K]
  [../]
[]

[Kernels]
# dCi/dt
  [./dUO22+_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = UO22+
  [../]
  [./dUO32H2O_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = UO32H2O
  [../]
  [./dH_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = H
  [../]
  [./dH2O2_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = H2O2
  [../]
  [./dUO2O24H2O_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = UO2O24H2O
  [../]
  [./dH2_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = H2
  [../]
  [./dH+_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = H+
  [../]
  [./dUO2CO322-_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = UO2CO322-
  [../]
  [./dCO32-_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = CO32-
  [../]
  [./dFe2+_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = Fe2+
  [../]
  [./dOH-_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = OH-
  [../]
  [./dFe2O3_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = Fe2O3
  [../]
  [./dUO2_precip_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = UO2_precip
  [../]
  [./dO2_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = O2
  [../]
  [./dH2O_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = H2O
  [../]
  [./dUOH4_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = UOH4
  [../]
  [./dUO2CO334-_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = UO2CO334-
  [../]


# Diffusion terms
  [./DgradH2O]
    block = 'Alpha Solution'
    type = CoefDiffusion
    coef = 2.31E-9 #[m2/s], at 25C
    variable = H2O
  [../]
  [./DgradHp]
    block = 'Alpha Solution'
    type = CoefDiffusion
    coef = 1.01E-8 #[m2/s], at 25C
    variable = H+
  [../]
  [./DgradOHm]
    block = 'Alpha Solution'
    type = CoefDiffusion
    coef = 4.82E-9 #[m2/s], at 25C
    variable = OH-
  [../]
  [./DgradH2O2]
    block = 'Alpha Solution'
    type = CoefDiffusion
    coef = 1.9E-9 #[m2/s], to be added
    variable = H2O2
  [../]
  [./DgradO2]
    block = 'Alpha Solution'
    type = CoefDiffusion
    coef = 2.5E-9 #[m2/s], to be added
    variable = O2
  [../]

  [./DgradUO22+]
    block = 'Alpha Solution'
    type = CoefDiffusion
    coef = 7.59e-10 #[m2/s], to be added
    variable = UO22+
  [../]
  [./DgradUO2CO322-]
    block = 'Alpha Solution'
    type = CoefDiffusion
    coef = 6.67E-10 #[m2/s], to be added
    variable = UO2CO322-
  [../]
  [./DgradUOH4]
    block = 'Alpha Solution'
    type = CoefDiffusion
    coef = 6E-10 #[m2/s], to be added
    variable = UOH4
  [../]
  [./DgradCO32-]
    block = 'Alpha Solution'
    type = CoefDiffusion
    coef = 8.12E-10 #[m2/s], to be added
    variable = CO32-
  [../]
  [./DgradFe2+]
    block = 'Alpha Solution'
    type = CoefDiffusion
    coef = 7.19E-10 #[m2/s], to be added
    variable = Fe2+
  [../]
  [./DgradH2]
    block = 'Alpha Solution'
    type = CoefDiffusion
    coef = 6E-9 #[m2/s], to be added
    variable = H2
  [../]
  [./DgradUO2CO334-]
    block = 'Alpha Solution'
    type = CoefDiffusion
    coef = 6.67E-10 #[m2/s], assumed same as UO2CO322-
    variable = UO2CO334-
  [../]




# HeatConduction terms
  [./heat]
    block = 'Alpha Solution'
    type = HeatConduction
    variable = T
  [../]
  [./ie]
    block = 'Alpha Solution'
    type = HeatConductionTimeDerivative
    variable = T
  [../]

[]

[Materials]
  [./Corrosion_Potential]
    block = 'Alpha Solution'
    type = UO2
    C1 = CO32-
    C2 = H2
    C3 = H2O2
    C4 = O2
    T = T
    Tol = 0.5E-3
    DelE = 0.1E-5
    Porosity = 1
    outputs = exodus
  [../]
[]



[BCs]
   [./BC_UO22+_ProductionA]
    type = UO22P_P
    variable = UO22+
    boundary = 'UO2'
    Porosity = 1
    Kinetic = 5E-8 #mol/(m2s)
    DelH = 6E4 #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Alpha = 0.96
    Standard_potential = 0.453 # Eqauilibrium potentials... -> Have to check the standard potential later!
    fraction = 0.99 #UO2 = 0.99, And NMP = 0.01. Assumed portion of NMP is 1%
  [../]

  [./BC_UO2CO322-_ProductionB]
    type = UO2BC
    variable = UO2CO322-
    boundary = 'UO2'
    Num = 1
    Kinetic = 1.3E-8 #mol/(m2s)
    DelH = 6E4 #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Chemical = CO32-    
    Alpha = 0.82
    Standard_potential = 0.046 # Eqauilibrium potentials... -> Have to check the standard potential later!
    m = 0.66
    fraction = 0.99 #UO2 = 0.99, And NMP = 0.01. Assumed portion of NMP is 1%
  [../]
  [./BC_CO32-_ConsumptionB]
    type = UO2BCCon
    variable = CO32-
    boundary = 'UO2'
    Num = -2
    Kinetic = 1.3E-8 #mol/(m2s)
    DelH = 6E4 #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Alpha = 0.82
    Standard_potential = 0.046 # Eqauilibrium potentials... -> Have to check the standard potential later!
    m = 0.66
    fraction = 0.99 #UO2 = 0.99, And NMP = 0.01. Assumed portion of NMP is 1%
  [../]


  [./BC_UO2CO334-_ProductionC]
    type = UO2BC
    variable = UO2CO334-
    boundary = 'UO2'
    Num = 1
    Kinetic = 1.3E-8 #mol/(m2s)
    DelH = 6E4 #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Chemical = CO32-    
    Alpha = 0.82
    Standard_potential = 0.184 # Eqauilibrium potentials... -> Have to check the standard potential later!
    m = 0.66
    fraction = 0.99 #UO2 = 0.99, And NMP = 0.01. Assumed portion of NMP is 1%
  [../]
  [./BC_CO32-_ConsumptionC]
    type = UO2BCCon
    variable = CO32-
    boundary = 'UO2'
    Num = -3
    Kinetic = 1.3E-8 #mol/(m2s)
    DelH = 6E4 #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Alpha = 0.82
    Standard_potential = 0.184 # Eqauilibrium potentials... -> Have to check the standard potential later!
    m = 0.66
    fraction = 0.99 #UO2 = 0.99, And NMP = 0.01. Assumed portion of NMP is 1%
  [../]


  [./BC_H+_ProductionD]
    type = UO2BC
    variable = H+
    boundary = 'UO2'
    Num = 2
    Kinetic = 3.6E-12 #mol/(m2s)
    DelH = 6E4 #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Chemical = H2    
    Alpha = 0.5
    Standard_potential = 0.049 # Eqauilibrium potentials... -> Have to check the standard potential later!
    m = 1
    fraction = 0.99 #UO2 = 0.99, And NMP = 0.01. Assumed portion of NMP is 1%
  [../]
  [./BC_CO32-_ConsumptionD]
    type = UO2BCCon
    variable = H2
    boundary = 'UO2'
    Num = -1
    Kinetic = 3.6E-12 #mol/(m2s)
    DelH = 6E4 #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Alpha = 0.5
    Standard_potential = 0.049 # Eqauilibrium potentials... -> Have to check the standard potential later!
    m = 1
    fraction = 0.99 #UO2 = 0.99, And NMP = 0.01. Assumed portion of NMP is 1%
  [../]


  [./BC_O2_ProductionE]
    type = UO2BC
    variable = O2
    boundary = 'UO2'
    Num = 1
    Kinetic = 7.4E-8 #mol/(m2s)
    DelH = 6E4 #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Chemical = H2O2    
    Alpha = 0.41
    Standard_potential = 0.737 # Eqauilibrium potentials... -> Have to check the standard potential later!
    m = 1
    fraction = 0.99 #UO2 = 0.99, And NMP = 0.01. Assumed portion of NMP is 1%
  [../]
  [./BC_H+_ProductionE]
    type = UO2BC
    variable = H+
    boundary = 'UO2'
    Num = 2
    Kinetic = 7.4E-8 #mol/(m2s)
    DelH = 6E4 #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Chemical = H2O2    
    Alpha = 0.41
    Standard_potential = 0.737 # Eqauilibrium potentials... -> Have to check the standard potential later!
    m = 1
    fraction = 0.99 #UO2 = 0.99, And NMP = 0.01. Assumed portion of NMP is 1%
  [../]
  [./BC_CO32-_ConsumptionE]
    type = UO2BCCon
    variable = H2O2
    boundary = 'UO2'
    Num = -1
    Kinetic = 7.4E-8 #mol/(m2s)
    DelH = 6E4 #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Alpha = 0.41
    Standard_potential = 0.737 # Eqauilibrium potentials... -> Have to check the standard potential later!
    m = 1
    fraction = 0.99 #UO2 = 0.99, And NMP = 0.01. Assumed portion of NMP is 1%
  [../]


  [./BC_OH-_ProductionF]
    type = UO2BC
    variable = OH-
    boundary = 'UO2'
    Num = 2
    Kinetic = 1.2E-12 #mol/(m2s)
    DelH = 6E4 #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Chemical = H2O2    
    Alpha = -0.41
    Standard_potential = 0.979 # Eqauilibrium potentials... -> Have to check the standard potential later!
    m = 1
    fraction = 0.99 #UO2 = 0.99, And NMP = 0.01. Assumed portion of NMP is 1%
  [../]
  [./BC_H2O2_ConsumptionF]
    type = UO2BCCon
    variable = H2O2
    boundary = 'UO2'
    Num = -1
    Kinetic = 1.2E-12 #mol/(m2s)
    DelH = 6E4 #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Alpha = -0.41
    Standard_potential = 0.979 # Eqauilibrium potentials... -> Have to check the standard potential later!
    m = 1
    fraction = 0.99 #UO2 = 0.99, And NMP = 0.01. Assumed portion of NMP is 1%
  [../]

  [./BC_OH-_ProductionG]
    type = UO2BC
    variable = OH-
    boundary = 'UO2'
    Num = 4
    Kinetic = 1.4E-12 #mol/(m2s)
    DelH = 6E4 #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Chemical = O2    
    Alpha = -0.5
    Standard_potential = 0.444 # Eqauilibrium potentials... -> Have to check the standard potential later!
    m = 1
    fraction = 0.99 #UO2 = 0.99, And NMP = 0.01. Assumed portion of NMP is 1%
  [../]
  [./BC_O2_ConsumptionG]
    type = UO2BCCon
    variable = O2
    boundary = 'UO2'
    Num = -1
    Kinetic = 1.4E-12 #mol/(m2s)
    DelH = 6E4 #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Alpha = -0.5
    Standard_potential = 0.444 # Eqauilibrium potentials... -> Have to check the standard potential later!
    m = 1
    fraction = 0.99 #UO2 = 0.99, And NMP = 0.01. Assumed portion of NMP is 1%
  [../]


#NMP (Noble Metal Particles) Surface
  [./BC_H+_ProductionH]
    type = UO2BC
    variable = H+
    boundary = 'UO2'
    Num = 2
    Kinetic = 1E-6 #mol/(m2s)
    DelH = 6E4 #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Chemical = H2    
    Alpha = 0.5
    Standard_potential = 0.049 # Eqauilibrium potentials... -> Have to check the standard potential later!
    m = 1
    fraction = 0.01 #UO2 = 0.99, And NMP = 0.01. Assumed portion of NMP is 1%
  [../]
  [./BC_CO32-_ConsumptionH]
    type = UO2BCCon
    variable = H2
    boundary = 'UO2'
    Num = -1
    Kinetic = 1E-6 #mol/(m2s)
    DelH = 6E4 #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Alpha = 0.5
    Standard_potential = 0.049 # Eqauilibrium potentials... -> Have to check the standard potential later!
    m = 1
    fraction = 0.01 #UO2 = 0.99, And NMP = 0.01. Assumed portion of NMP is 1%
  [../]


  [./BC_O2_ProductionI]
    type = UO2BC
    variable = O2
    boundary = 'UO2'
    Num = 1
    Kinetic = 7.0E-6 #mol/(m2s)
    DelH = 6E4 #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Chemical = H2O2    
    Alpha = 0.41
    Standard_potential = 0.737 # Eqauilibrium potentials... -> Have to check the standard potential later!
    m = 1
    fraction = 0.01 #UO2 = 0.99, And NMP = 0.01. Assumed portion of NMP is 1%
  [../]
  [./BC_H+_ProductionI]
    type = UO2BC
    variable = H+
    boundary = 'UO2'
    Num = 2
    Kinetic = 7.0E-6 #mol/(m2s)
    DelH = 6E4 #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Chemical = H2O2    
    Alpha = 0.41
    Standard_potential = 0.737 # Eqauilibrium potentials... -> Have to check the standard potential later!
    m = 1
    fraction = 0.01 #UO2 = 0.99, And NMP = 0.01. Assumed portion of NMP is 1%
  [../]
  [./BC_CO32-_ConsumptionI]
    type = UO2BCCon
    variable = H2O2
    boundary = 'UO2'
    Num = -1
    Kinetic = 7.6E-6 #mol/(m2s)
    DelH = 6E4 #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Alpha = 0.41
    Standard_potential = 0.737 # Eqauilibrium potentials... -> Have to check the standard potential later!
    m = 1
    fraction = 0.01 #UO2 = 0.99, And NMP = 0.01. Assumed portion of NMP is 1%
  [../]


  [./BC_OH-_ProductionJ]
    type = UO2BC
    variable = OH-
    boundary = 'UO2'
    Num = 2
    Kinetic = 1.2E-10 #mol/(m2s)
    DelH = 6E4 #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Chemical = H2O2    
    Alpha = -0.41
    Standard_potential = 0.979 # Eqauilibrium potentials... -> Have to check the standard potential later!
    m = 1
    fraction = 0.01 #UO2 = 0.99, And NMP = 0.01. Assumed portion of NMP is 1%
  [../]
  [./BC_H2O2_ConsumptionJ]
    type = UO2BCCon
    variable = H2O2
    boundary = 'UO2'
    Num = -1
    Kinetic = 1.2E-10 #mol/(m2s)
    DelH = 6E4 #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Alpha = -0.41
    Standard_potential = 0.979 # Eqauilibrium potentials... -> Have to check the standard potential later!
    m = 1
    fraction = 0.01 #UO2 = 0.99, And NMP = 0.01. Assumed portion of NMP is 1%
  [../]

  [./BC_OH-_ProductionK]
    type = UO2BC
    variable = OH-
    boundary = 'UO2'
    Num = 4
    Kinetic = 1.4E-10 #mol/(m2s)
    DelH = 6E4 #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Chemical = O2    
    Alpha = -0.5
    Standard_potential = 0.444 # Eqauilibrium potentials... -> Have to check the standard potential later!
    m = 1
    fraction = 0.01 #UO2 = 0.99, And NMP = 0.01. Assumed portion of NMP is 1%
  [../]
  [./BC_O2_ConsumptionK]
    type = UO2BCCon
    variable = O2
    boundary = 'UO2'
    Num = -1
    Kinetic = 1.4E-10 #mol/(m2s)
    DelH = 6E4 #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Alpha = -0.5
    Standard_potential = 0.444 # Eqauilibrium potentials... -> Have to check the standard potential later!
    m = 1
    fraction = 0.01 #UO2 = 0.99, And NMP = 0.01. Assumed portion of NMP is 1%
  [../]


  [./BC_OH-_ProductionL]
    type = UO2BC
    variable = UOH4
    boundary = 'UO2'
    Num = 1
    Kinetic = 1.9E-12 #mol/(m2s)
    DelH = 0
    Corrosion_potential = Ecorr
    Temperature = T
    Chemical = H2O    
    Alpha = 0
    Standard_potential = 0 # Eqauilibrium potentials... -> Have to check the standard potential later!
    m = 1
    fraction = 0.01 #UO2 = 0.99, And NMP = 0.01. Assumed portion of NMP is 1%
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
  start_time = 0 #[hr]
  end_time = 1750 #[hr]
  solve_type = 'PJFNK'
#  l_abs_tol = 1e-12
#  l_tol = 1e-7 #default = 1e-5
#  nl_abs_tol = 1e-12
  nl_rel_tol = 1e-1 #default = 1e-7
  l_max_its = 10
  nl_max_its = 30
  dtmax = 100

  automatic_scaling = true
  compute_scaling_once = false
 

  [./TimeStepper]
    type = IterationAdaptiveDT
    cutback_factor = 0.99
    dt = 1e-5
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

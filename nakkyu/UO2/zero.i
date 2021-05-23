[Mesh]
  file = 'UO2.msh'
  construct_side_list_from_node_list = true
[]


[Variables]
  # Name of chemical species
  [./UO2CO322-]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./CO32-]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 1E-20 #mol/m3
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
  [./dUO2CO334-_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = UO2CO334-
  [../]



# Diffusion terms
  [./DgradUO2CO322-]
    block = 'Alpha Solution'
    type = CoefDiffusion
    coef = 6.67E-10 #[m2/s], to be added
    variable = UO2CO322-
  [../]
  [./DgradCO32-]
    block = 'Alpha Solution'
    type = CoefDiffusion
    coef = 8.12E-10 #[m2/s], to be added
    variable = CO32-
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
    block = 'Alpha'
    type = InitUO2
    C1 = CO32-
    C2 = 0
    C3 = 0
    C4 = 0
    T = T
    Tol = 5E-9
    DelE = 1E-5


    EA = 0.4412
    EB = 0.5115
    EC = 0.6568
    ED = 0.049
    EE = 0.4
    EF = 0.9797
    EG = 0.4752
    EH = 0.049
    EI = 0.4
    EJ = 0.9797
    EK = 0.4752

    Porosity = 1

    outputs = exodus

  [../]
  [./Sat_Property]
    block = 'Alpha Solution'
    type = UO2Property
    UO22p = 1E-2
    UO2CO322m = 1E-1
    UOH4 = 4E-7
    Fe2p = 5E-3
    outputs = exodus 
  [../]
[]




[BCs]

  [./BC_UO2CO322-_ProductionB]
    type = UO2CO322m_BC_rem
    variable = UO2CO322-
    boundary = 'UO2'
    Num = 1
    Kinetic = 1.3E-8 #mol/(m2s)
    DelH = 6E4 #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    v = CO32-    
    Alpha = 0.82
    Standard_potential = 0.046 # Eqauilibrium potentials... -> Have to check the standard potential later!
    m = 0.66
    fraction = 0.99 #UO2 = 0.99, And NMP = 0.01. Assumed portion of NMP is 1%
  [../]

  [./BC_UO2CO334-_ProductionC]
    type = UO2CO334m_BC_rem
    variable = UO2CO334-
    boundary = 'UO2'
    Num = 1
    Kinetic = 1.3E-8 #mol/(m2s)
    DelH = 6E4 #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    v = CO32-    
    Alpha = 0.82
    Standard_potential = 0.184 # Eqauilibrium potentials... -> Have to check the standard potential later!
    m = 0.66
    fraction = 0.99 #UO2 = 0.99, And NMP = 0.01. Assumed portion of NMP is 1%
  [../]

  [./BC_CO32-_Consumption_B]
    type = CO32m_rem
    variable = CO32-
    boundary = 'UO2'
    Num1 = -2
    Kinetic1 = 1.3E-8 #mol/(m2s)
    DelH = 6E4 #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    v = UO2CO322-
    Alpha1 = 0.82
    Standard_potential1 = 0.046 # Eqauilibrium potentials... -> Have to check the standard potential later!
    m = 0.66
    fraction = 0.01 #NMP = 0.01. Assumed portion of NMP is 1%
  [../]
  [./BC_CO32-_Consumption_C]
    type = CO32m_UO2CO334m_rem
    variable = CO32-
    boundary = 'UO2'
    Num1 = -3
    Kinetic1 = 1.3E-8 #mol/(m2s)
    DelH = 6E4 #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Alpha1 = 0.82
    Standard_potential1 = 0.184 # Eqauilibrium potentials... -> Have to check the standard potential later!
    m = 0.66
    fraction = 0.01 #NMP = 0.01. Assumed portion of NMP is 1%
  [../]



  [./BC_Right_CO32m]
    type = DirichletBC
    boundary = 'Boundary'
    variable = CO32-
    value = 0
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
  end_time = 3.1536E12 #[s]
  solve_type = 'PJFNK'
#  l_abs_tol = 1e-12
#  l_tol = 1e-7 #default = 1e-5
#  nl_abs_tol = 1e-12
  nl_rel_tol = 1e-3 #default = 1e-7
#  l_rel_tol = 1e-35
  l_max_its = 30
  nl_max_its = 10


#  scheme = crank-nicolson  
#  line_search = bt

  automatic_scaling = true
  compute_scaling_once = false
  verbose = true

  [./TimeStepper]
    type = IterationAdaptiveDT
    cutback_factor = 0.9
    dt = 3.1536E-6
    growth_factor = 1.1
  [../]
[]

[Preconditioning]
  [./smp]
    type = SMP
    full = true
  [../]
[]

[Debug]
  show_var_residual_norms = true
[]

[Outputs]
  exodus = true
[]

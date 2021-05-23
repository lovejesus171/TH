[Mesh]
  file = 'UO2.msh'
  construct_side_list_from_node_list = true
[]


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
  [./H2O2]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 1E-5 #mol/m3
  [../]
  [./UO2O24H2O]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./H2]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 1E-6 #mol/m3
  [../]
  [./H+]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 1E-4 #mol/m3
  [../]
  [./UO2CO322-]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./CO32-]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 1E-6 #mol/m3
  [../]
  [./Fe2+]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 1E-6 #mol/m3
  [../]
  [./OH-]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 1E-4 #mol/m3
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
   initial_condition = 1E-6 #mol/m3
  [../]
  [./H2O]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 55314 #mol/m3
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
  [./ConsumedH2O2]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
[]


[Functions]
  [H2O2_produce]
    type = ParsedFunction
    value = '1.02E-4 * (0.99883 - 11833.90869 * x)^(-1/-0.13308)' #1.02E-4 mol/m3/Gy * 1 Gy/s
  []
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
  [./dConsumedH2O2_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = ConsumedH2O2
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


## First Order Chemical Reactions
# M reaction
  [./UO22+_M]
    block = 'Alpha Solution'
    type = ReactantU
    variable = UO22+
    Reaction_rate = 1E-3 # 1/s
    Num = -1
    Activation_energy = -6E4
    Saturation = Sat_UO22p #Unit: mol/m3
    T = T
  [../]
  [./UO32H2O_M]
    block = 'Alpha Solution'
    type = PreDis1V
    variable = UO32H2O
    v = UO22+
    Reaction_rate = 1E-3 # 1/s
    Num = 1
    Activation_energy = -6E4
    Saturation = Sat_UO22p #Unit: mol/m3
    T = T
  [../]
  [./H+_M]
    block = 'Alpha Solution'
    type = PreDis1V
    variable = H+
    v = UO22+
    Reaction_rate = 1E-3 # 1/s
    Num = 2
    Activation_energy = -6E4
    Saturation = Sat_UO22p #Unit: mol/m3
    T = T
  [../]

# N reaction
  [./UO22+_N]
    block = 'Alpha Solution'
    type = ReactantU
    variable = UO22+
    Reaction_rate = 1E-3 # 1/s
    Num = -1
    Activation_energy = -6E4
    Saturation = Sat_UO22p #Unit: mol/m3
    T = T
  [../]
  [./H2O2_N]
    block = 'Alpha Solution'
    type = PreDis1V
    variable = H2O2
    v = UO22+
    Reaction_rate = 1E-3 # 1/s
    Num = -1
    Activation_energy = -6E4
    Saturation = Sat_UO22p #Unit: mol/m3
    T = T
  [../]
  [./UO2O24H2O_N]
    block = 'Alpha Solution'
    type = PreDis1V
    variable = UO2O24H2O
    v = UO22+
    Reaction_rate = 1E-3 # 1/s
    Num = 1
    Activation_energy = -6E4
    Saturation = Sat_UO22p #Unit: mol/m3
    T = T
  [../]
  [./H+_N]
    block = 'Alpha Solution'
    type = PreDis1V
    variable = H+
    v = UO22+
    Reaction_rate = 1E-3 # 1/s
    Num = 2
    Activation_energy = -6E4
    Saturation = Sat_UO22p #Unit: mol/m3
    T = T
  [../]

# O reaction
  [./UO2CO322-_O]
    block = 'Alpha Solution'
    type = ReactantU
    variable = UO2CO322-
    Reaction_rate = 1E-4 # 1/s
    Num = -1
    Activation_energy = -6E4
    Saturation = Sat_UO2CO322m #Unit: mol/m3
    T = T
  [../]
  [./H2O2_O]
    block = 'Alpha Solution'
    type = PreDis1V
    variable = H2O2
    v = UO2CO322-
    Reaction_rate = 1E-4 # 1/s
    Num = -1
    Activation_energy = -6E4
    Saturation = Sat_UO2CO322m #Unit: mol/m3
    T = T
  [../]
  [./UO32H2O_O]
    block = 'Alpha Solution'
    type = PreDis1V
    variable = UO32H2O
    v = UO2CO322-
    Reaction_rate = 1E-4 # 1/s
    Num = 1
    Activation_energy = -6E4
    Saturation = Sat_UO2CO322m #Unit: mol/m3
    T = T
  [../]
  [./CO32-_O]
    block = 'Alpha Solution'
    type = PreDis1V
    variable = CO32-
    v = UO2CO322-
    Reaction_rate = 1E-4 # 1/s
    Num = 2
    Activation_energy = -6E4
    Saturation = Sat_UO2CO322m #Unit: mol/m3
    T = T
  [../]
  [./H+_O]
    block = 'Alpha Solution'
    type = PreDis1V
    variable = H+
    v = UO2CO322-
    Reaction_rate = 1E-4 # 1/s
    Num = 2
    Activation_energy = -6E4
    Saturation = Sat_UO2CO322m #Unit: mol/m3
    T = T
  [../]


# P reaction
  [./UO2CO322-_P]
    block = 'Alpha Solution'
    type = ReactantU
    variable = UO2CO322-
    Reaction_rate = 1E-4 # 1/s
    Num = -1
    Activation_energy = -6E4
    Saturation = Sat_UO2CO322m #Unit: mol/m3
    T = T
  [../]
  [./H2O2_P]
    block = 'Alpha Solution'
    type = PreDis1V
    variable = H2O2
    v = UO2CO322-
    Reaction_rate = 1E-4 # 1/s
    Num = -1
    Activation_energy = -6E4
    Saturation = Sat_UO2CO322m #Unit: mol/m3
    T = T
  [../]
  [./UO2O24H2O_P]
    block = 'Alpha Solution'
    type = PreDis1V
    variable = UO2O24H2O
    v = UO2CO322-
    Reaction_rate = 1E-4 # 1/s
    Num = 1
    Activation_energy = -6E4
    Saturation = Sat_UO2CO322m #Unit: mol/m3
    T = T
  [../]
  [./H+_P]
    block = 'Alpha Solution'
    type = PreDis1V
    variable = H+
    v = UO2CO322-
    Reaction_rate = 1E-4 # 1/s
    Num = 2
    Activation_energy = -6E4
    Saturation = Sat_UO2CO322m #Unit: mol/m3
    T = T
  [../]
  [./CO32-_P]
    block = 'Alpha Solution'
    type = PreDis1V
    variable = CO32-
    v = UO2CO322-
    Reaction_rate = 1E-4 # 1/s
    Num = 2
    Activation_energy = -6E4
    Saturation = Sat_UO2CO322m #Unit: mol/m3
    T = T
  [../]


## Zeroth Order Chemical Reactions
# Q reactions
  [./UO22+_Q]
    block = 'Alpha Solution'
    type = ReactionZerothOrder
    variable = UO22+
    Reaction_rate = 8.6E-7
    Num = 1
    Activation_energy = -6E4
    T = T
  [../]
  [./UO32H2O_Q]
    block = 'Alpha Solution'
    type = ReactionZerothOrder
    variable = UO32H2O
    Reaction_rate = 8.6E-7
    Num = -1
    Activation_energy = -6E4
    T = T
  [../]
  [./H+_Q]
    block = 'Alpha Solution'
    type = ReactionZerothOrder
    variable = H+
    Reaction_rate = 8.6E-7
    Num = -2
    Activation_energy = -6E4
    T = T
  [../]
#R reactions
  [./UO22+_R]
    block = 'Alpha Solution'
    type = ReactionZerothOrder
    variable = UO22+
    Reaction_rate = 8.6E-7
    Num = 1
    Activation_energy = -6E4
    T = T
  [../]
  [./H2O2_R]
    block = 'Alpha Solution'
    type = ReactionZerothOrder
    variable = H2O2
    Reaction_rate = 8.6E-7
    Num = 1
    Activation_energy = -6E4
    T = T
  [../]
  [./H+_R]
    block = 'Alpha Solution'
    type = ReactionZerothOrder
    variable = H+
    Reaction_rate = 8.6E-7
    Num = -2
    Activation_energy = -6E4
    T = T
  [../]
  [./UO2O24H2O_R]
    block = 'Alpha Solution'
    type = ReactionZerothOrder
    variable = H+
    Reaction_rate = 8.6E-7
    Num = -2
    Activation_energy = -6E4
    T = T
  [../]

#S reactions
  [./UO2CO322-_S]
    block = 'Alpha Solution'
    type = ReactionZerothOrder
    variable = UO2CO322-
    Reaction_rate = 8.6E-6
    Num = 1
    Activation_energy = -6E4
    T = T
  [../]
  [./UO32H2O_S]
    block = 'Alpha Solution'
    type = ReactionZerothOrder
    variable = UO32H2O
    Reaction_rate = 8.6E-6
    Num = -1
    Activation_energy = -6E4
    T = T
  [../]
  [./CO32-_S]
    block = 'Alpha Solution'
    type = ReactionZerothOrder
    variable = CO32-
    Reaction_rate = 8.6E-6
    Num = -2
    Activation_energy = -6E4
    T = T
  [../]
  [./H+_S]
    block = 'Alpha Solution'
    type = ReactionZerothOrder
    variable = H+
    Reaction_rate = 8.6E-6
    Num = -2
    Activation_energy = -6E4
    T = T
  [../]

#T reactions
  [./UO2CO322-_T]
    block = 'Alpha Solution'
    type = ReactionZerothOrder
    variable = UO2CO322-
    Reaction_rate = 8.6E-6
    Num = 1
    Activation_energy = -6E4
    T = T
  [../]
  [./H2O2_T]
    block = 'Alpha Solution'
    type = ReactionZerothOrder
    variable = H2O2
    Reaction_rate = 8.6E-6
    Num = 1
    Activation_energy = -6E4
    T = T
  [../]
  [./UO2O24H2O_T]
    block = 'Alpha Solution'
    type = ReactionZerothOrder
    variable = UO2O24H2O
    Reaction_rate = 8.6E-6
    Num = -1
    Activation_energy = -6E4
    T = T
  [../]
  [./H+_T]
    block = 'Alpha Solution'
    type = ReactionZerothOrder
    variable = H+
    Reaction_rate = 8.6E-6
    Num = -2
    Activation_energy = -6E4
    T = T
  [../]
  [./CO32-_T]
    block = 'Alpha Solution'
    type = ReactionZerothOrder
    variable = CO32-
    Reaction_rate = 8.6E-6
    Num = -2
    Activation_energy = -6E4
    T = T
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
    Tol = 4.5E-6
    DelE = 0.1E-3
    Porosity = 1
    outputs = exodus
  [../]
  [./Sat_Property]
    block = 'Alpha Solution'
    type = UO2Property
    UO22p = 1E-5
    UO2CO322m = 1E-4
    UOOH4 = 4E-10
    Fe2p = 5E-6
    outputs = exodus 
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

[Outputs]
  exodus = true
[]

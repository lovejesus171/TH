[Mesh]
  file = 'UO2_One.msh'
  construct_side_list_from_node_list = true
[]


[Variables]
  # Name of chemical species
  [./UO22+]
   block = 'PotentialZone Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./UO32H2O]
   block = 'PotentialZone Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./UO2O24H2O]
   block = 'PotentialZone Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./H2]
   block = 'PotentialZone Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./H2O2]
   block = 'PotentialZone Alpha Solution'
   order = FIRST
   initial_condition = 1E-3 #mol/m3
  [../]
  [./H+]
   block = 'PotentialZone Alpha Solution'
   order = FIRST
   initial_condition = 1E-4 #mol/m3
  [../]
  [./UO2CO322-]
   block = 'PotentialZone Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./CO32-]
   block = 'PotentialZone Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./Fe2+]
   block = 'PotentialZone Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./OH-]
   block = 'PotentialZone Alpha Solution'
   order = FIRST
   initial_condition = 1E-4 #mol/m3
  [../]
  [./Fe2O3]
   block = 'PotentialZone Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./UO2_precip]
   block = 'PotentialZone Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./O2]
   block = 'PotentialZone Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./UOH4]
   block = 'PotentialZone Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./UO2CO334-]
   block = 'PotentialZone Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]



  [./T]
    block = 'PotentialZone Alpha Solution'
    order = FIRST
    family = LAGRANGE
    initial_condition = 298.15 #[K]
  [../]
  [./ConsumedH2O2]
   block = 'PotentialZone Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./ConsumedFe2+]
   block = 'PotentialZone Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
[]

[Functions]
  [H2O2_Production]
    type = ParsedFunction
    value = '1.02E-4 * 7.34573 * (t + 4.48993)^(-0.76378) * (0.99883 - 11833.90869 * x)^(-1/-0.13308) * 365 * 24 * 60 *60' #1.02E-4 mol/m3/Gy * Gy/s * s/hr
  []
[]


[Kernels]
# dCi/dt
  [./dUO22+_dt]
    block = 'PotentialZone Alpha Solution'
    type = TimeDerivative
    variable = UO22+
  [../]
  [./dUO32H2O_dt]
    block = 'PotentialZone Alpha Solution'
    type = TimeDerivative
    variable = UO32H2O
  [../]
  [./dH2O2_dt]
    block = 'PotentialZone Alpha Solution'
    type = TimeDerivative
    variable = H2O2
  [../]
  [./dUO2O24H2O_dt]
    block = 'PotentialZone Alpha Solution'
    type = TimeDerivative
    variable = UO2O24H2O
  [../]
  [./dH2_dt]
    block = 'PotentialZone Alpha Solution'
    type = TimeDerivative
    variable = H2
  [../]
  [./dH+_dt]
    block = 'PotentialZone Alpha Solution'
    type = TimeDerivative
    variable = H+
  [../]
  [./dUO2CO322-_dt]
    block = 'PotentialZone Alpha Solution'
    type = TimeDerivative
    variable = UO2CO322-
  [../]
  [./dCO32-_dt]
    block = 'PotentialZone Alpha Solution'
    type = TimeDerivative
    variable = CO32-
  [../]
  [./dFe2+_dt]
    block = 'PotentialZone Alpha Solution'
    type = TimeDerivative
    variable = Fe2+
  [../]
  [./dOH-_dt]
    block = 'PotentialZone Alpha Solution'
    type = TimeDerivative
    variable = OH-
  [../]
  [./dFe2O3_dt]
    block = 'PotentialZone Alpha Solution'
    type = TimeDerivative
    variable = Fe2O3
  [../]
  [./dUO2_precip_dt]
    block = 'PotentialZone Alpha Solution'
    type = TimeDerivative
    variable = UO2_precip
  [../]
  [./dO2_dt]
    block = 'PotentialZone Alpha Solution'
    type = TimeDerivative
    variable = O2
  [../]
  [./dUOH4_dt]
    block = 'PotentialZone Alpha Solution'
    type = TimeDerivative
    variable = UOH4
  [../]
  [./dUO2CO334-_dt]
    block = 'PotentialZone Alpha Solution'
    type = TimeDerivative
    variable = UO2CO334-
  [../]
  [./dConsumedH2O2_dt]
    block = 'PotentialZone Alpha Solution'
    type = TimeDerivative
    variable = ConsumedH2O2
  [../]
  [./dConsumedFe2+_dt]
    block = 'PotentialZone Alpha Solution'
    type = TimeDerivative
    variable = ConsumedFe2+
  [../]




# Diffusion terms
  [./DgradHp]
    block = 'PotentialZone Alpha Solution'
    type = CoefDiffusion
    coef = 3.19E-1 #[m2/yr], at 25C
    variable = H+
  [../]
  [./DgradOHm]
    block = 'PotentialZone Alpha Solution'
    type = CoefDiffusion
    coef = 1.52E-1 #[m2/yr], at 25C
    variable = OH-
  [../]
  [./DgradH2O2]
    block = 'PotentialZone Alpha Solution'
    type = CoefDiffusion
    coef = 5.99E-2 #[m2/yr], to be added
    variable = H2O2
  [../]
  [./DgradO2]
    block = 'PotentialZone Alpha Solution'
    type = CoefDiffusion
    coef = 7.88E-2 #[m2/yr], to be added
    variable = O2
  [../]

  [./DgradUO22+]
    block = 'PotentialZone Alpha Solution'
    type = CoefDiffusion
    coef = 2.39e-2 #[m2/yr], to be added
    variable = UO22+
  [../]
  [./DgradUO2CO322-]
    block = 'PotentialZone Alpha Solution'
    type = CoefDiffusion
    coef = 2.1E-2 #[m2/yr], to be added
    variable = UO2CO322-
  [../]
  [./DgradUOH4]
    block = 'PotentialZone Alpha Solution'
    type = CoefDiffusion
    coef = 1.89E-2 #[m2/yr], to be added
    variable = UOH4
  [../]
  [./DgradCO32-]
    block = 'PotentialZone Alpha Solution'
    type = CoefDiffusion
    coef = 2.56E-2 #[m2/yr], to be added
    variable = CO32-
  [../]
  [./DgradFe2+]
    block = 'PotentialZone Alpha Solution'
    type = CoefDiffusion
    coef = 2.27E-2 #[m2/yr], to be added
    variable = Fe2+
  [../]
  [./DgradH2]
    block = 'PotentialZone Alpha Solution'
    type = CoefDiffusion
    coef = 1.89E-1 #[m2/yr], to be added
    variable = H2
  [../]
  [./DgradUO2CO334-]
    block = 'PotentialZone Alpha Solution'
    type = CoefDiffusion
    coef = 2.1E-2 #[m2/yr], assumed same as UO2CO322-
    variable = UO2CO334-
  [../]




# HeatConduction terms
  [./heat]
    block = 'PotentialZone Alpha Solution'
    type = HeatConduction
    variable = T
  [../]
  [./ie]
    block = 'PotentialZone Alpha Solution'
    type = HeatConductionTimeDerivative
    variable = T
  [../]

## Radiolysis source
# H2O2 production
  [./H2O2_Radiolysis_product]
    block = 'PotentialZone Alpha'
    type = FunctionSource
    variable = H2O2
    Function_Name = H2O2_Production
  [../]


## First Order Chemical Reactions
# M reaction
  [./UO22+_M]
    block = 'PotentialZone Alpha Solution'
    type = ReactionMReactant
    variable = UO22+
    Reaction_rate = kM
    Num = -1
    Activation_energy = DelH
    Saturation = Sat_UO22p #Unit: mol/m3
    T = T
  [../]
  [./UO32H2O_M]
    block = 'PotentialZone Alpha Solution'
    type = ReactionMProduct
    variable = UO32H2O
    v = UO22+
    Reaction_rate = kM
    Num = 1
    Activation_energy = DelH
    Saturation = Sat_UO22p #Unit: mol/m3
    T = T
  [../]
  [./H+_M]
    block = 'PotentialZone Alpha Solution'
    type = ReactionMProduct
    variable = H+
    v = UO22+
    Reaction_rate = kM
    Num = 2
    Activation_energy = DelH
    Saturation = Sat_UO22p #Unit: mol/m3
    T = T
  [../]

# N reaction
  [./UO22+_N]
    block = 'PotentialZone Alpha Solution'
    type = ReactionMReactant
    variable = UO22+
    Reaction_rate = kN
    Num = -1
    Activation_energy = DelH
    Saturation = Sat_UO22p #Unit: mol/m3
    T = T
  [../]
  [./H2O2_N]
    block = 'PotentialZone Alpha Solution'
    type = ReactionMProduct
    variable = H2O2
    v = UO22+
    Reaction_rate = kN
    Num = -1
    Activation_energy = DelH
    Saturation = Sat_UO22p #Unit: mol/m3
    T = T
  [../]
  [./UO2O24H2O_N]
    block = 'PotentialZone Alpha Solution'
    type = ReactionMProduct
    variable = UO2O24H2O
    v = UO22+
    Reaction_rate = kN
    Num = 1
    Activation_energy = DelH
    Saturation = Sat_UO22p #Unit: mol/m3
    T = T
  [../]
  [./H+_N]
    block = 'PotentialZone Alpha Solution'
    type = ReactionMProduct
    variable = H+
    v = UO22+
    Reaction_rate = kN
    Num = 2
    Activation_energy = DelH
    Saturation = Sat_UO22p #Unit: mol/m3
    T = T
  [../]


## O reaction
#  [./UO2CO322-_O]
#    block = 'PotentialZone Alpha Solution'
#    type = ReactionMReactant
#    variable = UO2CO322-
#    Reaction_rate = kO
#    Num = -1
#    Activation_energy = DelH
#    Saturation = Sat_UO2CO322m #Unit: mol/m3
#    T = T
#  [../]
#  [./UO32H2O_O]
#    block = 'PotentialZone Alpha Solution'
#    type = ReactionMProduct
#    variable = UO32H2O
#    v = UO2CO322-
#    Reaction_rate = kO
#    Num = 1
#    Activation_energy = DelH
#    Saturation = Sat_UO2CO322m #Unit: mol/m3
#    T = T
#  [../]
#  [./CO32-_O]
#    block = 'PotentialZone Alpha Solution'
#    type = ReactionMProduct
#    variable = CO32-
#    v = UO2CO322-
#    Reaction_rate = kO
#    Num = 2
#    Activation_energy = DelH
#    Saturation = Sat_UO2CO322m #Unit: mol/m3
#    T = T
#  [../]
#  [./H+_O]
#    block = 'PotentialZone Alpha Solution'
#    type = ReactionMProduct
#    variable = H+
#    v = UO2CO322-
#    Reaction_rate = kO
#    Num = 2
#    Activation_energy = DelH
#    Saturation = Sat_UO2CO322m #Unit: mol/m3
#    T = T
#  [../]

## P reaction
#  [./UO2CO322-_P]
#    block = 'PotentialZone Alpha Solution'
#    type = ReactionMReactant
#    variable = UO2CO322-
#    Reaction_rate = kP
#    Num = -1
#    Activation_energy = DelH
#    Saturation = Sat_UO2CO322m #Unit: mol/m3
#    T = T
#  [../]
#  [./UO2O24H2O_P]
#    block = 'PotentialZone Alpha Solution'
#    type = ReactionMProduct
#    variable = UO2O24H2O
#    v = UO2CO322-
#    Reaction_rate = kP
#    Num = 1
#    Activation_energy = DelH
#    Saturation = Sat_UO2CO322m #Unit: mol/m3
#    T = T
#  [../]
#  [./H+_P]
#    block = 'PotentialZone Alpha Solution'
#    type = ReactionMProduct
#    variable = H+
#    v = UO2CO322-
#    Reaction_rate = kP
#    Num = 2
#    Activation_energy = DelH
#    Saturation = Sat_UO2CO322m #Unit: mol/m3
#    T = T
#  [../]
#  [./CO32-_P]
#    block = 'PotentialZone Alpha Solution'
#    type = ReactionMProduct
#    variable = CO32-
#    v = UO2CO322-
#    Reaction_rate = kP
#    Num = 2
#    Activation_energy = DelH
#    Saturation = Sat_UO2CO322m #Unit: mol/m3
#    T = T
#  [../]


### Zeroth Order Chemical Reactions
# Q reactions
  [./UO22+_Q]
    block = 'PotentialZone Alpha Solution'
    type = ReactionQ
    variable = UO22+
    Reaction_rate = kQ
    Num = 1
    Activation_energy = DelH
    T = T
  [../]
  [./UO32H2O_Q]
    block = 'PotentialZone Alpha Solution'
    type = ReactionQ
    variable = UO32H2O
    Reaction_rate = kQ
    Num = -1
    Activation_energy = DelH
    T = T
  [../]
  [./H+_Q]
    block = 'PotentialZone Alpha Solution'
    type = ReactionQ
    variable = UO32H2O
    Reaction_rate = kQ
    Num = -2
    Activation_energy = DelH
    T = T
  [../]

#R reactions
  [./UO22+_R]
    block = 'PotentialZone Alpha Solution'
    type = ReactionQ
    variable = UO22+
    Reaction_rate = kR
    Num = 1
    Activation_energy = DelH
    T = T
  [../]
  [./H2O2_R]
    block = 'PotentialZone Alpha Solution'
    type = ReactionQ
    variable = H2O2
    Reaction_rate = kR
    Num = 1
    Activation_energy = DelH
    T = T
  [../]
  [./UO2O24H2O_R]
    block = 'PotentialZone Alpha Solution'
    type = ReactionQ
    variable = UO2O24H2O
    Reaction_rate = kR
    Num = -1
    Activation_energy = DelH
    T = T
  [../]
  [./H+_R]
    block = 'PotentialZone Alpha Solution'
    type = ReactionQ
    variable = H+
    Reaction_rate = kR
    Num = -2
    Activation_energy = DelH
    T = T
  [../]


##S reactions
#  [./UO2CO322-_S]
#    block = 'PotentialZone Alpha Solution'
#    type = ReactionZerothOrder
#    variable = UO2CO322-
#    Reaction_rate = 8.6E-6
#    Num = 1
#    Activation_energy = -6E4
#    T = T
#  [../]
#  [./UO32H2O_S]
#    block = 'PotentialZone Alpha Solution'
#    type = ReactionZerothOrder
#    variable = UO32H2O
#    Reaction_rate = 8.6E-6
#    Num = -1
#    Activation_energy = -6E4
#    T = T
#  [../]
#  [./CO32-_S]
#    block = 'PotentialZone Alpha Solution'
#    type = ReactionZerothOrder
#    variable = CO32-
#    Reaction_rate = 8.6E-6
#    Num = -2
#    Activation_energy = -6E4
#    T = T
#  [../]
#  [./H+_S]
#    block = 'PotentialZone Alpha Solution'
#    type = ReactionZerothOrder
#    variable = H+
#    Reaction_rate = 8.6E-6
#    Num = -2
#    Activation_energy = -6E4
#    T = T
#  [../]
#
##T reactions
#  [./UO2CO322-_T]
#    block = 'PotentialZone Alpha Solution'
#    type = ReactionZerothOrder
#    variable = UO2CO322-
#    Reaction_rate = 8.6E-6
#    Num = 1
#    Activation_energy = -6E4
#    T = T
#  [../]
#  [./H2O2_T]
#    block = 'PotentialZone Alpha Solution'
#    type = ReactionZerothOrder
#    variable = H2O2
#    Reaction_rate = 8.6E-6
#    Num = 1
#    Activation_energy = -6E4
#    T = T
#  [../]
#  [./UO2O24H2O_T]
#    block = 'PotentialZone Alpha Solution'
#    type = ReactionZerothOrder
#    variable = UO2O24H2O
#    Reaction_rate = 8.6E-6
#    Num = -1
#    Activation_energy = -6E4
#    T = T
#  [../]
#  [./CO32-_T]
#    block = 'PotentialZone Alpha Solution'
#    type = ReactionZerothOrder
#    variable = CO32-
#    Reaction_rate = 8.6E-6
#    Num = -2
#    Activation_energy = -6E4
#    T = T
#  [../]
#
### Second order reactions
## U reactions
#  [./H2O2_U]
#    type = PreDis2React
#    variable = H2O2
#    Reaction_rate = 6.9E-2
#    Num = -1
#    Activation_energy = -6E4
#    T = T
#    v = Fe2+
#  [../]
#  [./Fe2+_U]
#    type = PreDis2React
#    variable = Fe2+
#    Reaction_rate = 6.9E-2
#    Num = -2
#    Activation_energy = -6E4
#    T = T
#    v = H2O2
#  [../]
#  [./Fe2O3_U]
#    type = PreDis2Product
#    variable = Fe2O3
#    Reaction_rate = 6.9E-2
#    Num = 1
#    Activation_energy = -6E4
#    T = T
#    v = H2O2
#    w = Fe2+
#  [../]
#
## V reactions
#  [./O2_V]
#    type = PreDis2React
#    variable = O2
#    Reaction_rate = 5.9E-1
#    Num = -1
#    Activation_energy = -6E4
#    T = T
#    v = Fe2+
#  [../]
#  [./Fe2+_V]
#    type = PreDis2React
#    variable = Fe2+
#    Reaction_rate = 5.9E-1
#    Num = -4
#    Activation_energy = -6E4
#    T = T
#    v = Fe2+
#  [../]
#  [./Fe2O3_V]
#    type = PreDis2Product
#    variable = Fe2O3
#    Reaction_rate = 5.9E-1
#    Num = 2
#    Activation_energy = -6E4
#    T = T
#    v = O2
#    w = Fe2+
#  [../]
#  [./OH-_V]
#    type = PreDis2Product
#    variable = OH-
#    Reaction_rate = 5.9E-1
#    Num = -8
#    Activation_energy = -6E4
#    T = T
#    v = O2
#    w = Fe2+
#  [../]
#
## W reactions
#  [./UO22+_W]
#    type = PreDis2ReactU
#    variable = UO22+
#    Reaction_rate = 1E-2
#    Num = -1
#    Activation_energy = -6E4
#    T = T
#    v = Fe2+
#    Saturation = Sat_UO22p
#  [../]
#  [./Fe2+_W]
#    type = PreDis2ReactV
#    variable = Fe2+
#    Reaction_rate = 1E-2
#    Num = -2
#    Activation_energy = -6E4
#    T = T
#    v = UO22+
#    Saturation = Sat_UO22p
#  [../]
#  [./UO2_precip_W]
#    type = PreDis2Product2
#    variable = UO2_precip
#    Reaction_rate = 1E-2
#    Num = 1
#    Activation_energy = -6E4
#    T = T
#    v = UO22+
#    w = Fe2+
#    Saturation = Sat_UO22p
#  [../]
#  [./Fe2O3_W]
#    type = PreDis2Product2
#    variable = Fe2O3
#    Reaction_rate = 1E-2
#    Num = 1
#    Activation_energy = -6E4
#    T = T
#    v = UO22+
#    w = Fe2+
#    Saturation = Sat_UO22p
#  [../]
#  [./OH-_W]
#    type = PreDis2Product2
#    variable = OH-
#    Reaction_rate = 1E-2
#    Num = -6
#    Activation_energy = -6E4
#    T = T
#    v = UO22+
#    w = Fe2+
#    Saturation = Sat_UO22p
#  [../]
#
## X reactions
#  [./UO2CO322-_X]
#    type = PreDis2ReactU
#    variable = UO2CO322-
#    Reaction_rate = 1E-3
#    Num = -1
#    Activation_energy = -6E4
#    T = T
#    v = Fe2+
#    Saturation = Sat_UO2CO322m
#  [../]
#  [./Fe2+_X]
#    type = PreDis2ReactV
#    variable = Fe2+
#    Reaction_rate = 1E-3
#    Num = -2
#    Activation_energy = -6E4
#    T = T
#    v = UO2CO322-
#    Saturation = Sat_UO2CO322m
#  [../]
#  [./UO2_precip_X]
#    type = PreDis2Product2
#    variable = UO2_precip
#    Reaction_rate = 1E-3
#    Num = 1
#    Activation_energy = -6E4
#    T = T
#    v = UO2CO322-
#    w = Fe2+
#    Saturation = Sat_UO2CO322m
#  [../]
#  [./CO32-_X]
#    type = PreDis2Product2
#    variable = CO32-
#    Reaction_rate = 1E-3
#    Num = 2
#    Activation_energy = -6E4
#    T = T
#    v = UO2CO322-
#    w = Fe2+
#    Saturation = Sat_UO2CO322m
#  [../]
#  [./Fe2O3_X]
#    type = PreDis2Product2
#    variable = Fe2O3
#    Reaction_rate = 1E-3
#    Num = 1
#    Activation_energy = -6E4
#    T = T
#    v = UO2CO322-
#    w = Fe2+
#    Saturation = Sat_UO2CO322m
#  [../]
#  [./OH-_X]
#    type = PreDis2Product2
#    variable = OH-
#    Reaction_rate = 1E-3
#    Num = -6
#    Activation_energy = -6E4
#    T = T
#    v = UO2CO322-
#    w = Fe2+
#    Saturation = Sat_UO2CO322m
#  [../]




[]




[Materials]
  [./Corrosion_Potential]
    block = 'PotentialZone'
    type = UO2Potential
    C1 = CO32-
    C2 = H2
    C3 = H2O2
    C4 = O2
    T = T
    
    aA = aA
    aB = aB
    aC = aC
    aD = aD
    aE = aE
    aF = aF
    aG = aG
    aH = aH
    aI = aI
    aJ = aJ
    aK = aK

    EA = EA
    EB = EB
    EC = EC
    ED = ED
    EE = EE
    EF = EF
    EG = EG
    EH = EH
    EI = EI
    EJ = EJ
    EK = EK

    nA = nA
    nB = nB
    nC = nC
    nD = nD
    nE = nE
    nF = nF
    nG = nG
    nH = nH
    nI = nI
    nJ = nJ
    nK = nK
    
    kA = kA
    kB = kB
    kC = kC
    kD = kD
    kE = kE
    kF = kF
    kG = kG
    kH = kH
    kI = kI
    kJ = kJ
    kK = kK
    
    Porosity = eps
    NMP_fraction = f
    DelH = DelH
    
    Tol = 5E-7
    DelE = 0.5E-5

    outputs = exodus

  [../]
  [./Sat_Property]
    block = 'PotentialZone Alpha Solution'
    type = UO2PropertyCollectionYear
    UO22p = 1E-2
    UO2CO322m = 1E-1
    UOH4 = 4E-7
    Fe2p = 5E-3

#    EA_value = -0.453
#    EB_value = 0.5115
#    EC_value = 0.6568
#    ED_value = 0.049
#    EE_value = 0.4
#    EF_value = 0.9797
#    EG_value = 0.4752
#    EH_value = 0.049
#    EI_value = 0.4
#    EJ_value = 0.9797
#    EK_value = 0.4752


    outputs = exodus 


  [../]
[]


[ChemicalReactions]
  [./Network]
    block = 'PotentialZone Alpha Solution'
    species = 'H2O2 O2 ConsumedH2O2'
    track_rates = False

    equation_constants = 'Ea R T_Re'
    equation_values = '-6E4 8.314 298.15'
    equation_variables = 'T'
   
    reactions = '
  H2O2 -> O2 : {7.1*exp(Ea/R*(1/T_Re-1/T))}
  H2O2 -> ConsumedH2O2 : {7.1*exp(Ea/R*(1/T_Re-1/T))}
'

  [../]
[]



[BCs]
   [./BC_UO22+_ProductionA]
    type = ReactionA
    variable = UO22+
    boundary = 'UO2'
    Porosity = eps
    Kinetic = kA
    DelH = DelH
    Corrosion_potential = Ecorr
    Temperature = T
    Alpha = aA
    Standard_potential = EA
    fraction = f
  [../]

#  [./BC_UO2CO322-_ProductionB]
#    type = ReactionBProduct
#    variable = UO2CO322-
#    boundary = 'UO2'
#    Num = 1
#    Porosity = eps
#    Kinetic = kB
#    DelH = DelH
#    Corrosion_potential = Ecorr
#    Temperature = T
#    v = CO32-    
#    Alpha = aB
#    Standard_potential = EB # Eqauilibrium potentials... -> Have to check the standard potential later!
#    fraction = f #UO2 = 0.99, And NMP = 0.01. Assumed portion of NMP is 1%
#  [../]

#  [./BC_UO2CO334-_ProductionC]
#    type = ReactionCProduct
#    variable = UO2CO334-
#    boundary = 'UO2'
#    Num = 1
#    Kinetic = kC
#    Porosity = eps
#    DelH = DelH #J/mol => Have to check the unit later!
#    Corrosion_potential = Ecorr
#    Temperature = T
#    v = CO32-    
#    Alpha = aC
#    Standard_potential = aB # Eqauilibrium potentials... -> Have to check the standard potential later!
#    fraction = f #UO2 = 0.99, And NMP = 0.01. Assumed portion of NMP is 1%
#  [../]

#  [./BC_CO32-_Consumption_B]
#    type =ReactionBReactant
#    variable = CO32-
#    boundary = 'UO2'
#    Num = -2
#    Porosity = eps
#    Kinetic1 = kB
#    DelH = DelH #J/mol => Have to check the unit later!
#    Corrosion_potential = Ecorr
#    Temperature = T
#    v = UO2CO322-
#    Alpha1 = aB
#    Standard_potential1 = EB # Eqauilibrium potentials... -> Have to check the standard potential later!
#    fraction = f #NMP = 0.01. Assumed portion of NMP is 1%
#  [../]
#  [./BC_CO32-_Consumption_C]
#    type = ReactionCReactant
#    variable = CO32-
#    boundary = 'UO2'
#    Num = -3
#    Porosity = eps
#    Kinetic1 = kC #mol/(m2s)
#    DelH = DelH #J/mol => Have to check the unit later!
#    Corrosion_potential = Ecorr
#    Temperature = T
#    Alpha1 = aC
#    Standard_potential1 = EC # Eqauilibrium potentials... -> Have to check the standard potential later!
#    fraction = f #NMP = 0.01. Assumed portion of NMP is 1%
#  [../]


  [./BC_H2_Consumption_D]
    type = ReactionDReactant
    variable = H2
    boundary = 'UO2'
    Num = -1
    Porosity = eps
    Kinetic1 = kD
    DelH = DelH #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Alpha1 = aD
    Standard_potential1 = ED # Eqauilibrium potentials... -> Have to check the standard potential later!
    fraction = f #NMP = 0.01. Assumed portion of NMP is 1%
  [../]
  [./BC_H2_Consumption_H]
    type = ReactionHReactant
    variable = H2
    boundary = 'UO2'
    Num = -1
    Porosity = eps
    Kinetic1 = kH
    DelH = DelH #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Alpha1 = aH
    Standard_potential1 = EH # Eqauilibrium potentials... -> Have to check the standard potential later!
    fraction = f #NMP = 0.01. Assumed portion of NMP is 1%
  [../]
  [./BC_Hp_Production_D]
    type = ReactionDProduct
    variable = H+
    v = H2
    boundary = 'UO2'
    Num = 2
    Porosity = eps
    Kinetic1 = kD
    DelH = DelH #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Alpha1 = aD
    Standard_potential1 = ED # Eqauilibrium potentials... -> Have to check the standard potential later!
    fraction = f #NMP = 0.01. Assumed portion of NMP is 1%
  [../]
  [./BC_Hp_Production_H]
    type = ReactionHProduct
    variable = H+
    v = H2
    boundary = 'UO2'
    Porosity = eps
    Num = 2
    Kinetic1 = kH
    DelH = DelH #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Alpha1 = aH
    Standard_potential1 = EH # Eqauilibrium potentials... -> Have to check the standard potential later!
    fraction = f #NMP = 0.01. Assumed portion of NMP is 1%
  [../]


# E,F,G,I,J,K -> For fuel surface and noble metal particles surface
  
  [./BC_H2O2_Consumption_E]
    type = ReactionDReactant
    variable = H2O2
    boundary = 'UO2'
    Num = -1
    Porosity = eps
    Kinetic1 = kE
    DelH = DelH #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Alpha1 = aE
    Standard_potential1 = EE
    fraction = f #NMP = 0.01. Assumed portion of NMP is 1%
  [../]
  [./BC_H2O2_Consumption_I]
    type = ReactionHReactant
    variable = H2O2
    boundary = 'UO2'
    Num = -1
    Porosity = eps
    Kinetic1 = kI
    DelH = DelH #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Alpha1 = aI
    Standard_potential1 = EI
    fraction = f #NMP = 0.01. Assumed portion of NMP is 1%
  [../]
  [./BC_O2_Production_E]
    type = ReactionDProduct
    variable = O2
    v = H2
    boundary = 'UO2'
    Num = 1
    Porosity = eps
    Kinetic1 = kE
    DelH = DelH #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Alpha1 = aE
    Standard_potential1 = EE # Eqauilibrium potentials... -> Have to check the standard potential later!
    fraction = f #NMP = 0.01. Assumed portion of NMP is 1%
  [../]
  [./BC_O2_Production_I]
    type = ReactionHProduct
    variable = O2
    v = H2
    boundary = 'UO2'
    Num = 1
    Porosity = eps
    Kinetic1 = kI #mol/(m2s)
    DelH = DelH #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Alpha1 = aI
    Standard_potential1 = EI # Eqauilibrium potentials... -> Have to check the standard potential later!
    fraction = f #NMP = 0.01. Assumed portion of NMP is 1%
  [../]
  [./BC_H+_Production_E]
    type = ReactionDProduct
    variable = H+
    v = H2
    boundary = 'UO2'
    Num = 2
    Porosity = eps
    Kinetic1 = kE
    DelH = DelH #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Alpha1 = aE
    Standard_potential1 = EE # Eqauilibrium potentials... -> Have to check the standard potential later!
    fraction = f #NMP = 0.01. Assumed portion of NMP is 1%
  [../]
  [./BC_H+_Production_I]
    type = ReactionHProduct
    variable = H+
    v = H2
    boundary = 'UO2'
    Num = 2
    Porosity = eps
    Kinetic1 = kI
    DelH = DelH #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Alpha1 = aI
    Standard_potential1 = EI # Eqauilibrium potentials... -> Have to check the standard potential later!
    fraction = f #NMP = 0.01. Assumed portion of NMP is 1%
  [../]

  [./BC_H2O2_Consumption_F]
    type = ReactionDReactant
    variable = H2O2
    boundary = 'UO2'
    Num = -1
    Porosity = eps
    Kinetic1 = kF
    DelH = DelH #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Alpha1 = aF
    Standard_potential1 = EF
    fraction = f #NMP = 0.01. Assumed portion of NMP is 1%
  [../]
  [./BC_H2O2_Consumption_J]
    type = ReactionHReactant
    variable = H2O2
    boundary = 'UO2'
    Num = -1
    Porosity = eps
    Kinetic1 = kJ
    DelH = DelH #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Alpha1 = aJ
    Standard_potential1 = EJ
    fraction = f #NMP = 0.01. Assumed portion of NMP is 1%
  [../]
  [./BC_OH-_Production_F]
    type = ReactionDProduct
    variable = OH-
    v = H2O2
    boundary = 'UO2'
    Num = -2
    Porosity = eps
    Kinetic1 = kF
    DelH = DelH #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Alpha1 = aF
    Standard_potential1 = EF # Eqauilibrium potentials... -> Have to check the standard potential later!
    fraction = f #NMP = 0.01. Assumed portion of NMP is 1%
  [../]
  [./BC_OH-_Production_J]
    type = ReactionHProduct
    variable = OH-
    v = H2O2
    boundary = 'UO2'
    Num = -2
    Porosity = eps
    Kinetic1 = kJ
    DelH = DelH #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Alpha1 = aJ
    Standard_potential1 = EJ # Eqauilibrium potentials... -> Have to check the standard potential later!
    fraction = f #NMP = 0.01. Assumed portion of NMP is 1%
  [../]

  [./BC_H2O2_Consumption_G]
    type = ReactionDReactant
    variable = O2
    boundary = 'UO2'
    Num = -1
    Porosity = eps
    Kinetic1 = kG
    DelH = DelH #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Alpha1 = aG
    Standard_potential1 = EG
    fraction = f #NMP = 0.01. Assumed portion of NMP is 1%
  [../]
  [./BC_H2O2_Consumption_K]
    type = ReactionHReactant
    variable = O2
    boundary = 'UO2'
    Num = -1
    Porosity = eps
    Kinetic1 = kK
    DelH = DelH #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Alpha1 = aK
    Standard_potential1 = EK
    fraction = f #NMP = 0.01. Assumed portion of NMP is 1%
  [../]

  [./BC_OH-_Production_G]
    type = ReactionDProduct
    variable = OH-
    v = O2
    boundary = 'UO2'
    Num = -4
    Porosity = eps
    Kinetic1 = kG
    DelH = DelH #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Alpha1 = aK
    Standard_potential1 = EK # Eqauilibrium potentials... -> Have to check the standard potential later!
    fraction = f #NMP = 0.01. Assumed portion of NMP is 1%
  [../]
  [./BC_OH-_Production_K]
    type = ReactionHProduct
    variable = OH-
    v = O2
    boundary = 'UO2'
    Num = -4
    Porosity = eps
    Kinetic1 = kK
    DelH = DelH #J/mol => Have to check the unit later!
    Corrosion_potential = Ecorr
    Temperature = T
    Alpha1 = aK
    Standard_potential1 = EK # Eqauilibrium potentials... -> Have to check the standard potential later!
    fraction = f #NMP = 0.01. Assumed portion of NMP is 1%
  [../]



  [./BC_OH-_ProductionL]
    type = ReactionL
    variable = UOH4
    boundary = 'UO2'
    Num = 1
    Porosity = eps
    Kinetic = kL
    DelH = DelH
    Temperature = T
    fraction = f #UO2 = 0.99, And NMP = 0.01. Assumed portion of NMP is 1%
    Saturation = Sat_UOH4
  [../]

  [./BC_Right_CO32m]
    type = DirichletBC
    boundary = 'Boundary'
    variable = CO32-
    value = 0
  [../]
  [./BC_Right_O2]
    type = DirichletBC
    boundary = 'Boundary'
    variable = O2
    value = 0
  [../]
  [./BC_Right_H2]
    type = DirichletBC
    boundary = 'Boundary'
    variable = H2
    value = 0
  [../]
  [./BC_Right_Fe2p]
    type = DirichletBC
    boundary = 'Boundary'
    variable = Fe2+
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
  start_time = 0 #[hr]
  end_time = 1E5 #[hr]
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
#  verbose = true

  [./TimeStepper]
    type = IterationAdaptiveDT
    cutback_factor = 0.9
    dt = 1e-1
    growth_factor = 1.005
  [../]
[]

[Preconditioning]
  [./smp]
    type = SMP
    full = true
  [../]
[]

#[Debug]
#  show_var_residual_norms = true
#[]

[Outputs]
  exodus = true
#  file_base = residual_debug
#  [./console]
#  type = Console
#  output_linear = true
#  output_nonlinear = true
#  [../]
[]

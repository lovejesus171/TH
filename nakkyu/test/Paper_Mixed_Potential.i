[Mesh]
  file = 'Half_e.msh'
  construct_side_list_from_node_list = true
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
  [./T]
    block = 'Solution'
    order = FIRST
    family = LAGRANGE
    initial_condition = 298.15 #[K]
  [../]
  [./Cl-]
    block = 'Solution'
    order = FIRST
    initial_condition = 0.1E3 #[mol/m3]
  [../]
  [./CuCl2-]
    block = 'Solution'
    order = FIRST
    initial_condition = 0 #[mol/m3]
  [../]
  [./Cu2S]
    block = 'Solution'
    order = FIRST
    initial_condition = 0
  [../]
[]

[AuxVariables]
  [./E]
    block = 'Solution'
    order = FIRST
    family = LAGRANGE
  [../]
[]


[AuxKernels]
  [./Calculate_Corrosion_Potential]
    block = 'Solution'
    type = Test
    variable = E
    Reactant = HS-
    Reaction_order = 1
    AlphaE = 0.5
    AlphaS = 0.5
    AlphaS12 = 0.5
    AlphaS3 = 0.5
    PotentialE = -0.1005
    PotentialS12 = -0.747
    PotentialE3 = -0.747
    CoefE = 1
    CoefS = 1
    Kinetic_coefE = 7.2E-6
    Kinetic_coefS = 216
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
  [./dCl-_dt]
    block = 'Solution'
    type = TimeDerivative
    variable = Cl-
  [../]
  [./dCuCl2-_dt]
    block = 'Solution'
    type = TimeDerivative
    variable = CuCl2-
  [../]
  [./dCu2S_dt]
    block = 'Solution'
    type = TimeDerivative
    variable = Cu2S
  [../]


# Diffusion terms
  [./DgradHS]
    block = 'Solution'
    type = CoefDiffusion
    coef = 26316e-10 #[m2/s]
    variable = HS-
  [../]
  [./DgradH2O]
    block = 'Solution'
    type = CoefDiffusion
    coef = 8316e-9 #[m2/s], at 25C
    variable = H2O
  [../]
  [./DgradHp]
    block = 'Solution'
    type = CoefDiffusion
    coef = 3628.8e-8 #[m2/s], at 25C
    variable = H+
  [../]
  [./DgradOHm]
    block = 'Solution'
    type = CoefDiffusion
    coef = 17352e-9 #[m2/s], at 25C
    variable = OH-
  [../]
  [./DgradH2O2]
    block = 'Solution'
    type = CoefDiffusion
    coef = 17352e-9 #[m2/s], to be added
    variable = H2O2
  [../]
  [./DgradSO42m]
    block = 'Solution'
    type = CoefDiffusion
    coef = 17352e-9 #[m2/s], to be added
    variable = SO42-
  [../]
  [./DgradO2]
    block = 'Solution'
    type = CoefDiffusion
    coef = 7200e-9 #[m2/s], to be added
    variable = O2
  [../]
  [./DgradCl-]
    block = 'Solution'
    type = CoefDiffusion
    coef = 7200e-9 #[m2/s], to be added
    variable = Cl-
  [../]
  [./DgradCuCl2-]
    block = 'Solution'
    type = CoefDiffusion
    coef = 7200e-9 #[m2/s], to be added
    variable = CuCl2-
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


[BCs]
#  [./copper_boundary1]
#    type = DirichletBC
#    variable = HS-
#    boundary = Copper_top
#    value = 0 #[mol/m2]
#  [../]
#  [./copper_boundary2]
#    type = DirichletBC
#    variable = HS-
#    boundary = Copper_side
#    value = 0 #[mol/m2]
#  [../]
  [./BC_HS-]
    type = ES2
    variable = HS-
#    boundary = 'Copper_top Copper_side'
    boundary = 'Copper_top'
#    boundary = left
    Faraday_constant = 96485
    Kinetic = 216 #m4mol/hr at 25C
    AlphaS = 0.5
    Corrosion_potential = E
#    Temperature = T
    AlphaS3 = 0.5
    Standard_potential2 = -0.747 
    Standard_potential3 = -0.747
    Num = -1
 [../]
 [./BC_Cu2S]
    type = Cu2S
    variable = Cu2S
    Reactant1 = HS-
#    boundary = 'Copper_top Copper_side'
    boundary = 'Copper_top'
#    boundary = left
    Faraday_constant = 96485
    Kinetic = 216 #m4mol/hr at 25C
    AlphaS = 0.5
    Corrosion_potential = E
#    Temperature = T
    AlphaS3 = 0.5
    Standard_potential2 = -0.747 
    Standard_potential3 = -0.747
    Num = 1
 [../]
 [./BC_Cl-]
   type = Clm
   variable = Cl-
   Reactant1 = CuCl2-
#   boundary = 'Copper_top Copper_side'
   boundary = Copper_top
   Corrosion_potential = E
   Temperature = 298.15
   kF = 1.188E-4
   kB = 5.112E-1
   StandardPotential = -0.105
   TransferCoef = 0.5
   Num  = -2
 [../]
 [./BC_CuCl2-]
   type = CuCl2m
   variable = CuCl2-
   Reactant1 = Cl-
#   boundary = 'Copper_top Copper_side'
   boundary = Copper_top
   Corrosion_potential = E
   Temperature = 298.15
   kF = 1.188E-4
   kB = 5.112E-1
   StandardPotential = -0.105
   TransferCoef = 0.5
   Num  = 1
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


[Postprocessors]
  [./Consumed_HS_mol_per_s]
    type = SideFluxIntegral
    variable = HS-
    diffusivity = 26316e-10 #m2/hr
##    boundary = left
    boundary = Copper_top
  [../]
  [./Volume_integetral_of_HS-]
    type = ElementIntegralVariablePostprocessor
    block = 'Solution'
    variable = HS-
  [../]
  [./Volume_integetral_of_Cu2S]
    type = ElementIntegralVariablePostprocessor
    block = 'Solution'
    variable = Cu2S
  [../]
[]

[Outputs]
#  file_base = 2020_12_30_Sibal
#  sync_times = '0 1e-1 1 10 100 1000 1e4 2e4 3e4 4e4 5e4 6e4 7e4 8e4 9e4 1e5 2e5 3e5 4e5 5e5 6e5 7e5 8e5 9e5 1e6 2e6 3e6 4e6 5e6 6e6 6048000'
  exodus = true
[]

[Mesh]
  file = '2D_Experiment_02_01.msh'
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
  [./CuCl2-]
    block = 'Solution'
    order = FIRST
    initial_condition = 0 #[mol/m3]
  [../]
  [./Cu2+]
    block = 'Solution'
    order = FIRST
    initial_condition = 0 #[mol/m3]
  [../]
  [./Cl-]
    block = 'Solution'
    order = FIRST
    initial_condition = 0.1E3 #[mol/m3]
  [../]
  [./T]
    block = 'Solution'
    order = FIRST
    family = LAGRANGE
    initial_condition = 298.15 #[K]
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
    type = CorrosionPotential
    variable = E
    C0 = O2
    C1 = CuCl2-
    C3 = Cu2+
    C6 = Cl-
    C9 = HS-

    aS = 0.5
    aC = 0.5
    aD = 0.5
    aE = 0.5
    aF = 0.5
    aS3 = 0.5

    EA = -0.105
    ES12 = -0.747
    ES3 = -0.747
    EC = 0.16
    ED = 0.223
    EE = -1.005
    EF = -0.764

    nA = 1
    nD = 1
    nE = 1
    nF = 1
    nO = 4
    nS = 1

    kA = 1.188E-4 #m4/mol/hr
    kC = 6.12E-7 #m/hr
    kD = 7.2E-6 #m/hr
    kE = 7.2E-6 #m/hr
    kS = 2.16E2 #m4/mol/hr
    kF = 2.4444E-3 #mol/m2/hr

    T = T
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
  [./dCuCl2-_dt]
    block = 'Solution'
    type = TimeDerivative
    variable = CuCl2-
  [../]
  [./dCu2+_dt]
    block = 'Solution'
    type = TimeDerivative
    variable = Cu2+
  [../]
  [./dCl-_dt]
    block = 'Solution'
    type = TimeDerivative
    variable = Cl-
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
  [./DgradCuCl2-]
    block = 'Solution'
    type = CoefDiffusion
    coef = 7200e-9 #[m2/s], to be added
    variable = CuCl2-
  [../]
  [./DgradCu2+]
    block = 'Solution'
    type = CoefDiffusion
    coef = 7200e-9 #[m2/s], to be added
    variable = Cu2+
  [../]
  [./DgradCl-]
    block = 'Solution'
    type = CoefDiffusion
    coef = 7200e-9 #[m2/s], to be added
    variable = Cl-
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

#unit = 1/hour
#[ChemicalReactions]
# [./Network]
#   block = 'Solution'
#   species = 'H+ OH- H2O H2O2 SO42- O2 HS-'
#   track_rates = False
#
#   equation_constants = 'Ea R T_Re'
#   equation_values = '20 8.314 298.15'
#   equation_variables = 'T'

#   reactions = 'H2O -> OH- + H+ : {2.5e-5*exp(-45.4e3/R*(1/T_Re-1/T))}                OH- + H+ -> H2O : {1.4e8*exp(-12.2e3/R*(1/T_Re-1/T))}                HS- + H2O2 + H2O2 + H2O2 + H2O2 -> OH- + H+ + H+ + SO42- : {5.5e-4*exp(-51.3e3/R*(1/T_Re-1/T))}        HS- + O2 -> SO42- + H+ : {3.6*10^(11.78-3000/T)}'
#[../]
#[]

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

  [./Cl-BCs]
   type = Clm
   boundary = 'Copper_top Copper_side'
   variable = Cl-
   Temperature = T
   Corrosion_potential = E
   kF = 1.1880E-4 #m4/mol/hr
   kB = 5.112E-1 #m/hr
   Reactant1 = CuCl2-
   StandardPotential = -0.105 #V
   Num = 2
  [../]
  [./CuCl2-BCs]
   type = CuCl2m
   boundary = 'Copper_top Copper_side'
   variable = CuCl2-
   Temperature = T
   Corrosion_potential = E
   kF = 1.1880E-4 #m4/mol/hr
   kB = 5.112E-1 #m/hr
   Reactant1 = Cl-
   StandardPotential = -0.105 #V
   Num = 1
  [../]
  [./e-_from_CuCl2-_formation]
   type = CuCl2m
   boundary = 'Copper_top Copper_side'
   variable = e-
   Temperature = T
   Corrosion_potential = E
   kF = 1.1880E-4 #m4/mol/hr
   kB = 5.112E-1 #m/hr
   Reactant1 = Cl-
   StandardPotential = -0.105 #V
   Num = 1
  [./]







  [./BC_HS-]
    type = ES2
    variable = HS-
    boundary = 'Copper_top Copper_side'
#    boundary = 'Copper_top'
    Faraday_constant = 1
    Charge_number = -1
    Kinetic = 2160000E-4 #m4mol/hr at 25C
    AlphaS = 0.5
    Corrosion_potential = E
    T = 298.15
    AlphaS3 = 0.5
    Standard_potential2 = -0.747 
    Standard_potential3 = -0.747
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
  end_time = 1680 #[hr]
  solve_type = 'PJFNK'
#  l_abs_tol = 1e-12
#  l_tol = 1e-7 #default = 1e-5
#  nl_abs_tol = 1e-12
  nl_rel_tol = 1e-4 #default = 1e-7
  l_max_its = 10
  nl_max_its = 30
  dtmax = 100000 

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


[Postprocessors]
  [./Consumed_HS_mol_per_s]
    type = SideFluxIntegral
    variable = HS-
    diffusivity = 26316e-10 #m2/hr
    boundary = Copper_top
  [../]
#  [./Volume_tegetral_of_HS-]
#    type = ElementIntegralVariablePostprocessor
#    block = 'Solution'
#    variable = HS-
#  [../]
[]

[Outputs]
#  file_base = 2020_12_30_Sibal
#  sync_times = '0 1e-1 1 10 100 1000 1e4 2e4 3e4 4e4 5e4 6e4 7e4 8e4 9e4 1e5 2e5 3e5 4e5 5e5 6e5 7e5 8e5 9e5 1e6 2e6 3e6 4e6 5e6 6e6 6048000'
  exodus = true
[]

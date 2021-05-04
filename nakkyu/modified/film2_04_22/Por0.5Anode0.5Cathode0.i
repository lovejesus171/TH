[Mesh]
  file = 'Line3.msh'
  construct_side_list_from_node_list = true
[]
#[UserObjects]
#  [./changeID]
#    block = 'Film Solution Copper'
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
  [./H+]
   block = 'Film Solution Copper'
   order = FIRST
   initial_condition = 1.0079e-8 #[mol/m3] at 25 C with 1mol/l of HS- in solution (Na2S)
  [../]
  [./OH-]
   block = 'Film Solution Copper'
   order =FIRST
   initial_condition = 1.0001 #[mol/m3]
  [../]
  [./H2O]
   block = 'Film Solution Copper'
   order = FIRST
   initial_condition = 55347 #[mol/m3] at 25 C
  [../]
  [./HS-]
    block = 'Film Solution Copper'
    order = FIRST
    initial_condition = 1 #[mol/m3]
  [../]
  [./H2O2]
    block = 'Film Solution Copper'
    order = FIRST
    initial_condition = 0  #[mol/m3]
  [../]
  [./SO42-]
    block = 'Film Solution Copper'
    order = FIRST
    initial_condition = 0 #[mol/m3]
  [../]
  [./O2]
    block = 'Film Solution Copper'
    order = FIRST
    initial_condition = 0 #[mol/m3]
  [../]
  [./T]
    block = 'Film Solution Copper'
    order = FIRST
    family = LAGRANGE
    initial_condition = 298.15 #[K]
  [../]
  [./Cl-]
    block = 'Film Solution Copper'
    order = FIRST
    initial_condition = 0.1E3 #[mol/m3]
  [../]
  [./CuCl2-]
    block = 'Film Solution Copper'
    order = FIRST
    initial_condition = 0 #[mol/m3]
  [../]
  [./Cu2S]
    block = 'Film Solution Copper'
    order = FIRST
    initial_condition = 0
  [../]
[]

[Kernels]
# dCi/dt
  [./dHS_dt]
    block = 'Film Solution Copper'
    type = TimeDerivative
    variable = HS-
  [../]
  [./dH2O_dt]
    block = 'Film Solution Copper'
    type = TimeDerivative
    variable = H2O
  [../]
  [./dHp_dt]
    block = 'Film Solution Copper'
    type = TimeDerivative
    variable = H+
  [../]
  [./dOHm_dt]
    block = 'Film Solution Copper'
    type = TimeDerivative
    variable = OH-
  [../]
  [./dH2O2_dt]
    block = 'Film Solution Copper'
    type = TimeDerivative
    variable = H2O2
  [../]
  [./dSO42m_dt]
    block = 'Film Solution Copper'
    type = TimeDerivative
    variable = SO42-
  [../]
  [./dO2_dt]
    block = 'Film Solution Copper'
    type = TimeDerivative
    variable = O2
  [../]
  [./dCl-_dt]
    block = 'Film Solution Copper'
    type = TimeDerivative
    variable = Cl-
  [../]
  [./dCuCl2-_dt]
    block = 'Film Solution Copper'
    type = TimeDerivative
    variable = CuCl2-
  [../]
  [./dCu2S_dt]
    block = 'Film Solution Copper'
    type = TimeDerivative
    variable = Cu2S
  [../]


# Diffusion terms
  [./DgradHSF]
    block = 'Film'
    type = CoefDiffusion
    coef = 3.3705e-8 #[m2/hr], assumption: 1/100 to bulk (tortuosity 0.1, porosity: 0.1)
    variable = HS-
  [../]
  [./DgradHSS]
    block = 'Solution Copper'
    type = CoefDiffusion
    coef = 3.3705E-6 #[m2/hr], from the Smith experimental data, I used KouteckyLevich to extract diffusion coefficient.
    variable = HS-
  [../]

  [./DgradH2O]
    block = 'Film Solution Copper'
    type = CoefDiffusion
    coef = 8316e-9 #[m2/s], at 25C
    variable = H2O
  [../]
  [./DgradHp]
    block = 'Film Solution Copper'
    type = CoefDiffusion
    coef = 3628.8e-8 #[m2/s], at 25C
    variable = H+
  [../]
  [./DgradOHm]
    block = 'Film Solution Copper'
    type = CoefDiffusion
    coef = 17352e-9 #[m2/s], at 25C
    variable = OH-
  [../]
  [./DgradH2O2]
    block = 'Film Solution Copper'
    type = CoefDiffusion
    coef = 17352e-9 #[m2/s], to be added
    variable = H2O2
  [../]
  [./DgradSO42m]
    block = 'Film Solution Copper'
    type = CoefDiffusion
    coef = 17352e-9 #[m2/s], to be added
    variable = SO42-
  [../]
  [./DgradO2]
    block = 'Film Solution Copper'
    type = CoefDiffusion
    coef = 7200e-9 #[m2/s], to be added
    variable = O2
  [../]
  [./DgradCl-]
    block = 'Film Solution Copper'
    type = CoefDiffusion
    coef = 7.3152E-6 #[m2/hr], from the handbook original: 2.032E-5 cm2/s
    variable = Cl-
  [../]
  [./DgradCuCl2-_SC]
    block = 'Solution Copper'
    type = CoefDiffusion
    coef = 4.6692E-6 #[m2/hr], from the paper : 1.297E-9 m2/s
    variable = CuCl2-
  [../]
  [./DgradCuCl2-_F]
    block = 'Film'
    type = CoefDiffusion
    coef = 4.6692E-8 #[m2/hr], assumption: 1/100 to the CuCl2- in solution
    variable = CuCl2-
  [../]
  [./DgradCu2S]
    block = 'Film Copper'
    type = CoefDiffusion
    coef = 0.5e-16 #[m2/hr], to be added
    variable = Cu2S
  [../]


# HeatConduction terms
  [./heat]
    block = 'Film Solution Copper'
    type = HeatConduction
    variable = T
  [../]
  [./ie]
    block = 'Film Solution Copper'
    type = HeatConductionTimeDerivative
    variable = T
  [../]

[]

[Materials]
  [./Test]
    block = 'Copper Film'
    type = ECorr
    C1 = CuCl2-
    C6 = Cl-
    C9 = HS-
    Tol = 0.5E-3
    T = T
    DelE = 0.1E-5
    outputs = exodus
    kF = 0
    Porosity = 0.5
    AnodeAreaValue = 0.5
    Area = 0
    nS = 1
  [../]
[]



[BCs]
  [./BC_HS-]
    type = ADES2
    variable = HS-
#    boundary = 'Copper_top Copper_side'
    boundary = 'Copper_top'
#    boundary = Interface
    Faraday_constant = 96485
    Kinetic = 216 #m4mol/hr at 25C
    AlphaS = 0.5
    Corrosion_potential = Ecorr
#    Temperature = T
    AlphaS3 = 0.5
    Standard_potential2 = -0.747 
    Standard_potential3 = -0.747
    Num = -1
    Porosity = 1
    Area = AnodeArea  #Anodic Surface Area
 [../]
 [./BC_Cu2S]
    type = ADCu2S
    variable = Cu2S
    Reactant1 = HS-
#    boundary = 'Copper_top Copper_side'
    boundary = 'Copper_top'
#    boundary = Interface
    Faraday_constant = 96485
    Kinetic = 216 #m4mol/hr at 25C
    AlphaS = 0.5
    Corrosion_potential = Ecorr
#    Temperature = T
    AlphaS3 = 0.5
    Standard_potential2 = -0.747 
    Standard_potential3 = -0.747
    Num = 1
    Porosity = 1
    Area = AnodeArea
 [../]
 [./BC_Cl-]
   type = ADClm
   variable = Cl-
   Reactant1 = CuCl2-
   boundary = 'Copper_top'
   Corrosion_potential = Ecorr
   Temperature = 298.15
   kF = 1.188E-4
   kB = 0.5112
   StandardPotential = -0.105
   Num = -2
   Porosity = 1
   Area = AnodeArea
 [../]
 [./BC_CuCl2-]
   type = ADCuCl2m
   variable = CuCl2-
   Reactant1 = Cl-
   boundary = 'Copper_top'
   Corrosion_potential = Ecorr
   Temperature = 298.15
   kF = 1.188E-4
   kB = 0.5112
   StandardPotential = -0.105
   Num = 1
   Porosity = 1
   Area = AnodeArea
 [../]



 [./Isolated_H+]
   type = NeumannBC
   boundary = Isolated
   value = 0
   variable = H+
 [../]
 [./Isolated_OH-]
   type = NeumannBC
   boundary = Isolated
   value = 0
   variable = OH-
 [../]
 [./Isolated_H2O]
   type = NeumannBC
   boundary = Isolated
   value = 0
   variable = H2O
 [../]
 [./Isolated_HS-]
   type = NeumannBC
   boundary = Isolated
   value = 0
   variable = HS-
 [../]
 [./Isolated_H2O2]
   type = NeumannBC
   boundary = Isolated
   value = 0
   variable = H2O2
 [../]
 [./Isolated_SO42-]
   type = NeumannBC
   boundary = Isolated
   value = 0
   variable = SO42-
 [../]
 [./Isolated_O2]
   type = NeumannBC
   boundary = Isolated
   value = 0
   variable = O2
 [../]
 [./Isolated_T]
   type = NeumannBC
   boundary = Isolated
   value = 0
   variable = T
 [../]
 [./Isolated_Cl-]
   type = NeumannBC
   boundary = Isolated
   value = 0
   variable = Cl-
 [../]
 [./Isolated_CuCl2-]
   type = NeumannBC
   boundary = Isolated
   value = 0
   variable = CuCl2-
 [../]
 [./Isolated_Cu2S]
   type = NeumannBC
   boundary = Isolated
   value = 0
   variable = Cu2S
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
    diffusivity = 6.2316E-6 #m2/hr
#    boundary = left
    boundary = Copper_top
#    boundary = Interface
  [../]
  [./Volume_integetral_of_HS-]
    type = ElementIntegralVariablePostprocessor
    block = 'Film Solution Copper'
    variable = HS-
  [../]
  [./Volume_integetral_of_Cu2S]
    type = ElementIntegralVariablePostprocessor
    block = 'Film Solution Copper'
    variable = Cu2S
  [../]
#  [./Anodic_Cur]
#    type = AN
#    C6 = Cl-
#    C9 = HS-
#    C1 = CuCl2-
#    T  = T
#    Ecorr = Ecorr
#    Porosity = 0.05
#  [../]


[]

[Outputs]
#  file_base = 2020_12_30_Sibal
#  sync_times = '0 1e-1 1 10 100 1000 1e4 2e4 3e4 4e4 5e4 6e4 7e4 8e4 9e4 1e5 2e5 3e5 4e5 5e5 6e5 7e5 8e5 9e5 1e6 2e6 3e6 4e6 5e6 6e6 6048000'
  exodus = true
[]

#Geometry is micro-meter scale! (1um)
[Mesh]
  file = 'untitled.msh'
  construct_side_list_from_node_list = true
[]
[UserObjects]
#  [./changeID]
#    block = 'Film Solution'
#    type = Film
#    type = ActivateElementsCoupled
#    execute_on = timestep_begin
#    coupled_var = Cu2S
#    activate_value = 2.437E-3
#    activate_type = above
#    active_subdomain_id = 1
#    expand_boundary_name = Interface
#  [../]
#  [./changeID]
#     type = CoupledVarThresholdElementSubdomainModifier
#     coupled_var = 'Cu2S'
#     criterion_type = ABOVE
#     threshold = 2.437E-6
#     subdomain_id = 1
#     complement_subdomain_id = 2
#     moving_boundary_name = Interface
#     execute_on = 'TIMESTEP_END'
#  [../]
[]


[Variables]
  # Name of chemical species
  [./H+]
   block = 'Film Solution'
   order = FIRST
   initial_condition = 1.0079E-26 #[mol/m3] at 25 C with 1mol/l of HS- in solution (Na2S)
  [../]
  [./OH-]
   block = 'Film Solution'
   order =FIRST
   initial_condition = 1.0001E-18 #[mol/m3]
  [../]
  [./H2O]
   block = 'Film Solution'
   order = FIRST
   initial_condition = 5.5347E-14 #[mol/m3] at 25 C
  [../]
  [./HS-]
   block = 'Film Solution'
    order = FIRST
    initial_condition = 1E-18 #[mol/m3]
  [../]
  [./H2O2]
   block = 'Film Solution'
    order = FIRST
    initial_condition = 0  #[mol/m3]
  [../]
  [./SO42-]
   block = 'Film Solution'
    order = FIRST
    initial_condition = 0 #[mol/m3]
  [../]
  [./O2]
   block = 'Film Solution'
    order = FIRST
    initial_condition = 0 #[mol/m3]
  [../]
  [./T]
   block = 'Film Solution'
    order = FIRST
    family = LAGRANGE
    initial_condition = 298.15 #[K]
  [../]
  [./Cl-]
   block = 'Film Solution'
    order = FIRST
    initial_condition = 1E-16 #[mol/m3]
  [../]
  [./CuCl2-]
   block = 'Film Solution'
    order = FIRST
    initial_condition = 0 #[mol/m3]
  [../]
  [./Cu2S]
   block = 'Film Solution'
    order = FIRST
    initial_condition = 0
  [../]
[]

[Kernels]
# dCi/dt
  [./dHS_dt]
   block = 'Film Solution'
    type = TimeDerivative
    variable = HS-
  [../]
  [./dH2O_dt]
   block = 'Film Solution'
    type = TimeDerivative
    variable = H2O
  [../]
  [./dHp_dt]
   block = 'Film Solution'
    type = TimeDerivative
    variable = H+
  [../]
  [./dOHm_dt]
   block = 'Film Solution'
    type = TimeDerivative
    variable = OH-
  [../]
  [./dH2O2_dt]
   block = 'Film Solution'
    type = TimeDerivative
    variable = H2O2
  [../]
  [./dSO42m_dt]
   block = 'Film Solution'
    type = TimeDerivative
    variable = SO42-
  [../]
  [./dO2_dt]
   block = 'Film Solution'
    type = TimeDerivative
    variable = O2
  [../]
  [./dCl-_dt]
   block = 'Film Solution'
    type = TimeDerivative
    variable = Cl-
  [../]
  [./dCuCl2-_dt]
   block = 'Film Solution'
    type = TimeDerivative
    variable = CuCl2-
  [../]
  [./dCu2S_dt]
   block = 'Film Solution'
    type = TimeDerivative
    variable = Cu2S
  [../]


# Diffusion terms
  [./DgradHSF]
    block = 'Film'
    type = CoefDiffusion
    coef = 3.3705E4 #[m2/hr], assumption: 1/100 to bulk (tortuosity 0.1, porosity: 0.1)
    variable = HS-
  [../]
  [./DgradHSS]
    block = 'Solution'
    type = CoefDiffusion
    coef = 3.3705E6 #[m2/hr], from the Smith experimental data, I used KouteckyLevich to extract diffusion coefficient.
    variable = HS-
  [../]

  [./DgradH2O]
   block = 'Film Solution'
    type = CoefDiffusion
    coef = 8.316E6 #[m2/s], at 25C
    variable = H2O
  [../]
  [./DgradHp]
   block = 'Film Solution'
    type = CoefDiffusion
    coef = 3.6288E7 #[m2/s], at 25C
    variable = H+
  [../]
  [./DgradOHm]
   block = 'Film Solution'
    type = CoefDiffusion
    coef = 1.7352E7 #[m2/s], at 25C
    variable = OH-
  [../]
  [./DgradH2O2]
   block = 'Film Solution'
    type = CoefDiffusion
    coef = 1.7352E7 #[m2/s], to be added
    variable = H2O2
  [../]
  [./DgradSO42m]
   block = 'Film Solution'
    type = CoefDiffusion
    coef = 1.7352E7 #[m2/s], to be added
    variable = SO42-
  [../]
  [./DgradO2]
   block = 'Film Solution'
    type = CoefDiffusion
    coef = 7.3152E6 #[m2/s], to be added
    variable = O2
  [../]
  [./DgradCl-]
   block = 'Film Solution'
    type = CoefDiffusion
    coef = 4.6692E6 #[m2/hr], from the handbook original: 2.032E-5 cm2/s
    variable = Cl-
  [../]
  [./DgradCuCl2-_SC]
    block = 'Solution'
    type = CoefDiffusion
    coef = 4.6692E6 #[m2/hr], from the paper : 1.297E-9 m2/s
    variable = CuCl2-
  [../]
  [./DgradCuCl2-_F]
    block = 'Film'
    type = CoefDiffusion
    coef = 4.6692E4 #[m2/hr], assumption: 1/100 to the CuCl2- in solution
    variable = CuCl2-
  [../]
  [./DgradCu2S]
    block = 'Film Solution'
    type = CoefDiffusion
    coef = 5E-5 #[m2/hr], to be added
    variable = Cu2S
  [../]


# HeatConduction terms
  [./heat]
   block = 'Film Solution'
    type = HeatConduction
    variable = T
  [../]
  [./ie]
   block = 'Film Solution'
    type = HeatConductionTimeDerivative
    variable = T
  [../]

[]

[Materials]
  [./Test]
    block = 'Film Solution'
    type = ECorr_mm_Scale
    C1 = CuCl2-
    C6 = Cl-
    C9 = HS-
    Tol = 0.5
    T = T
    DelE = 0.1E-5
    outputs = exodus
    kF = 0
    Porosity = 0.1
    AnodeAreaValue = 0.1
    Area = 2.5
    nS = 1
    kA = 1.188E20
    kS = 2.16E26
    kE = 7.2
    kD = 7.2
    kC = 6.12E-1
    
  [../]
[]



[BCs]
  [./BC_HS-]
    type = ADES22
    variable = HS-
#    boundary = 'Copper_top Copper_side'
    boundary = 'Copper_top'
#    boundary = Interface
    Faraday_constant = 96485
    Kinetic = 2.16E26 #m4mol/hr at 25C
    AlphaS = 0.5
    Corrosion_potential = Ecorr
#    Temperature = T
    AlphaS3 = 0.5
    Standard_potential2 = -0.747 
    Standard_potential3 = -0.747
    Num = -1
    Porosity = 1
#    Area = AnodeArea  #Anodic Surface Area
 [../]
 [./BC_Cu2S]
    type = ADCu2S2
    variable = Cu2S
    Reactant1 = HS-
#    boundary = 'Copper_top Copper_side'
    boundary = 'Copper_top'
#    boundary = Interface
    Faraday_constant = 96485
    Kinetic = 2.16E26 #m4mol/hr at 25C
    AlphaS = 0.5
    Corrosion_potential = Ecorr
#    Temperature = T
    AlphaS3 = 0.5
    Standard_potential2 = -0.747 
    Standard_potential3 = -0.747
    Num = 1
    Porosity = 1
#    Area = AnodeArea
 [../]
 [./BC_Cl-]
   type = ADClm2
   variable = Cl-
   Reactant1 = CuCl2-
   boundary = 'Copper_top'
   Corrosion_potential = Ecorr
   Temperature = 298.15
   kF = 2.44E-15
   kB = 511200
   StandardPotential = -0.105
   Num = -2
   Porosity = 1
#   Area = AnodeArea
 [../]
 [./BC_CuCl2-]
   type = ADCuCl2m2
   variable = CuCl2-
   Reactant1 = Cl-
   boundary = 'Copper_top'
   Corrosion_potential = Ecorr
   Temperature = 298.15
   kF = 2.44E-15
   kB = 511200
   StandardPotential = -0.105
   Num = 1
   Porosity = 1
#   Area = AnodeArea
 [../]
  [./BC_HS-_Constant]
    type = DirichletBC
    boundary = Bulk
    variable = HS-
    value = 1E-18
  [../]
[]

  


 [Materials]
  [./hcm]
    type = HeatConductionMaterial
    temp = T
    specific_heat  = 75.309 #[J/(mol*K)]
    thermal_conductivity  = 6.145E-7 #[W/(mm*K)]
  [../]
  [./density]
    type = GenericConstantMaterial
    prop_names = density
    prop_values = 9.971E-16 #[kg/mm3]
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
  nl_rel_tol = 1E-1 #default = 1e-7
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
#  [./Consumed_HS_mol_per_s]
#    type = SideFluxIntegral
#    variable = HS-
#    diffusivity = 6.2316E-6 #m2/hr
#    boundary = left
#    boundary = Copper_top
#    boundary = Interface
#  [../]
  [./Volume_integetral_of_HS-]
    type = ElementIntegralVariablePostprocessor
   block = 'Film Solution'
    variable = HS-
  [../]
  [./Volume_integetral_of_Cu2S]
    type = ElementIntegralVariablePostprocessor
   block = 'Film Solution'
    variable = Cu2S
  [../]
[]

[Outputs]
#  file_base = 2020_12_30_Sibal
#  sync_times = '0 1e-1 1 10 100 1000 1e4 2e4 3e4 4e4 5e4 6e4 7e4 8e4 9e4 1e5 2e5 3e5 4e5 5e5 6e5 7e5 8e5 9e5 1e6 2e6 3e6 4e6 5e6 6e6 6048000'
  exodus = true
[]

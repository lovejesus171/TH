[Mesh]
  file = 'Line7.msh'
  construct_side_list_from_node_list = true
[]
#[UserObjects]
#  [./changeID]
#    block = 'Film Solution'
#    type = SulfideFilm
##    execute_on = timestep_begin
##    execute_on = 'timestep_end'
#    execute_on = 'initial timestep_begin timestep_end'
#    CoupledVar = FilmV
#    activate_value = 0
#    activate_type = BELOW
#    active_subdomain_id = 1
#    expand_boundary_name = Interface
#  [../]
#  [./changeID]
#    block = 'Solution Film'
#    type = CoupledVarThresholdElementSubdomainModifier
#    coupled_var = 'Cu2S_Pre'
#    criterion_type = ABOVE
#    threshold = 0
#    subdomain_id = 1
##    complement_subdomain_id = 1
#    moving_boundary_name = Interface
##    apply_initial_conditions = True
#    execute_on = 'TIMESTEP_BEGIN'
#  [../]
#[]


[Variables]
  # Name of chemical species
  [./HS-]
    block = 'Film Solution'
    order = FIRST
    initial_condition = 1 #[mol/m3]
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
    initial_condition = 0.1E3 #[mol/m3]
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
  [./Cu2S_Pre]
    block = 'Film Solution'
    order = FIRST
    initial_condition = 0
  [../]
[]

[AuxVariables]
  [./FilmV]
    block = 'Film Solution'
    order = FIRST
    family = MONOMIAL
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
  [./dCu2S_precipitation_dt]
    block = 'Film Solution'
    type = TimeDerivative
    variable = Cu2S_Pre
  [../]


# Diffusion terms
  [./DgradHSF]
    block = 'Film'
    type = CoefDiffusion
    coef = 9.70244e-8 #[m2/hr], from SKI report and I assumed Cu+ ion diffusion coef = HS- diffusion coefficient in Cu2S
    variable = HS-
  [../]
  [./DgradHSS]
    block = 'Solution'
    type = CoefDiffusion
    coef = 6.2316e-6 #[m2/hr], from hand book, original: 1.731E-5 [cm2/s]
    variable = HS-
  [../]
  [./DgradCl-]
    block = 'Film Solution'
    type = CoefDiffusion
    coef = 7.3152E-6 #[m2/hr], from the handbook original: 2.032E-5 cm2/s
    variable = Cl-
  [../]
  [./DgradCuCl2-_SC]
    block = 'Solution'
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
#  [./DgradCu2S]
#    block = 'Film Solution'
#    type = CoefDiffusion
#    coef = 6.2316e-1 #[m2/hr], from hand book, original: 1.731E-5 [cm2/s]
#    variable = Cu2S
#  [../]

## Precipitation of Cu2S to Cu2S_Precip
#  [./Precipiation_Cu2S]
#    block = 'Film Solution'
#    type = Cu2SPrecipitation
#    variable = Cu2S_Pre
#    Kinetic = 1
#    Saturation = 0.03518
#    v = Cu2S
#  [../]
#  [./Remove_Cu2S]
#    block = 'Film Solution'
#    type = Cu2SRemove
#    variable = Cu2S
#    Kinetic = 1
#    Saturation = 0.03518
#  [../]

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

[AuxKernels]
  [./Film_Variable_Cal]
    type = FilmVariable
    block = 'Film Solution'
    variable = FilmV
    pp = FilmThickness_of_Cu2S
  [../]
[]


[Materials]
  [./Test]
    block = 'Film Solution'
    type = ECorrCu2S
    C1 = CuCl2-
    C6 = Cl-
    C9 = HS-
    Tol = 1E-4
    T = T
    DelE = 0.1E-5
    outputs = exodus
    kF = 0
    Porosity = 1
    AnodeAreaValue = 1
    Area = 1
    Cu2SVar = Cu2S
  [../]
[]



[BCs]
  [./BC_HS-]
    type = HS
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
    Area = AnodeArea  #Anodic Surface Area
 [../]
 [./BC_Cu2S]
    type = Cu2S
    variable = Cu2S
    Reactant1 = HS-
#    boundary = 'Copper_top Copper_side'
    boundary = 'Copper_top'
#    boundary = Interface
    Faraday_constant = 96485
    Kinetic = 216 #m4mol/hr at 25C
    AlphaS = 0.5
    Corrosion_potential = Ecorr
    Temperature = T
    AlphaS3 = 0.5
    Standard_potential2 = -0.747 
    Standard_potential3 = -0.747
    Num = 1
    Area = AnodeArea  #Anodic Surface Area
 [../]

 [./BC_Cl-]
   type = Clm
   variable = Cl-
   Reactant1 = CuCl2-
   boundary = 'Copper_top'
   Corrosion_potential = Ecorr
   Temperature = 298.15
   kF = 1.188E-4
   kB = 2.4444E-3
   StandardPotential = -0.105
   Num = -2
   Area = AnodeArea
 [../]
 [./BC_CuCl2-]
   type = CuCl2m
   variable = CuCl2-
   Reactant1 = Cl-
   boundary = 'Copper_top'
   Corrosion_potential = Ecorr
   Temperature = 298.15
   kF = 1.188E-4
   kB = 2.4444E-3
   StandardPotential = -0.105
   Num = 1
   Area = AnodeArea
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
#  solve_type = 'NEWTON'
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
  [./Volume_integetral_of_Precipitated_Cu2S]
    type = ElementIntegralVariablePostprocessor
    block = 'Film Solution'
    variable = Cu2S_Pre
  [../]
  [./FilmThickness_of_Cu2S]
    type = FilmThickness
    block = 'Film Solution'
    variable = Cu2S
    Density = 31666
  [../]


[]

[Outputs]
#  file_base = 2020_12_30_Sibal
#  sync_times = '0 1e-1 1 10 100 1000 1e4 2e4 3e4 4e4 5e4 6e4 7e4 8e4 9e4 1e5 2e5 3e5 4e5 5e5 6e5 7e5 8e5 9e5 1e6 2e6 3e6 4e6 5e6 6e6 6048000'
  exodus = true
[]

[Mesh]
   type = GeneratedMesh
   dim = 3
   xmin = 0
   xmax = 1
   ymin = 0
   ymax = 1
   zmin = 0
   zmax = 1
   nx = 1
   ny = 1
   nz = 1
[]

[Variables]
  # Name of chemical species
  [./HS]
    order = FIRST
    initial_condition = 4.66 #[mol/m3]
  [../]
  [./Cu2S]
    order = FIRST
    initial_condition = 0
  [../]
  [./SO4]
    order = FIRST
    initial_condition = 0
  [../]
  [./SO4_By_O2]
    order= FIRST
    initial_condition = 0
  [../]
  [./H2O2]
    order = FIRST
    initial_condition = 0 #[mol/m3]
  [../]
  [./O2]
    order = FIRST
    initial_condition = 0.203 #[mol/m3]
  [../]
  [./T]
    order = FIRST
    family = LAGRANGE
    initial_condition = 313.15 #[K]
  [../]
  [./pH]
    order = FIRST
    family = LAGRANGE
    initial_condition = 10 #[pH = log(H+)]
  [../]
[]


[Kernels]
  # dCi/dt
  [./dHS_dt]
    type = TimeDerivative
    variable = HS
  [../]
  [./dCu2S_dt]
    type = TimeDerivative
    variable = Cu2S
  [../]
  [./dSO4_dt]
    type = TimeDerivative
    variable = SO4
  [../]
  [./dSO4_by_O2_dt]
    type = TimeDerivative
    variable = SO4_By_O2
  [../]
  [./dH2O2_dt]
    type = TimeDerivative
    variable = H2O2
  [../]
  [./dpH_dt]
    type = TimeDerivative
    variable = pH
  [../]
  [./dO2_dt]
    type = TimeDerivative
    variable = O2
  [../]
# Diffusion terms
  [./DgradHS]
    type = CoefDiffusion
    coef = 2.32e-9 #[m2/s]
    variable = HS
  [../]
  [./DgradH2O2]
    type = CoefDiffusion
    coef = 1.18e-9 #[m2/s], at 30C
    variable = H2O2
  [../]
  [./DgradO2]
    type = CoefDiffusion
    coef = 2e-9 #[m2/s], at 293K
    variable = O2
  [../]
# HeatConduction terms
  [./heat]
    type = HeatConduction
    variable = T
  [../]
  [./ie]
    type = HeatConductionTimeDerivative
    variable = T
  [../]
[]


[ChemicalReactions]
 [./Network]
   block = 0
   species = 'HS H2O2 SO4 SO4_By_O2'
   track_rates = True

   equation_constants = 'Ea R O2_C'
   equation_values = '300 8.314 0.203'
   equation_variables = 'T pH H2O2'

   reactions = 'HS  -> SO4_By_O2 : {1/(3600*1000)*10^(10.5+0.16*pH-3000/T)*O2_C}'
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
    prop_values = 995.65 #[kg/m3]
  [../]
[]

[Executioner]
  type = Transient
  start_time = 0 #[s]
  end_time = 960 #[s]
  solve_type = 'NEWTON'
  l_abs_tol = 1e-13
  nl_abs_tol = 1e-13
  dtmax = 30
#  steady_state_detection = true
#  steady_state_tolerance = 1e-9
  [./TimeStepper]
    type = IterationAdaptiveDT
    cutback_factor = 0.9
    dt = 0.1
    growth_factor = 1.2
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

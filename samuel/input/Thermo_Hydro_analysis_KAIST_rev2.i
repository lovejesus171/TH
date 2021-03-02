# Reference paper: An anlysis of the Thermal and Mechanical Behavior of Engineered Barriers in a High-level Radioactive Waste Repository
# Reference Paper: Numerical Analysis of Coupled Thermo-Hydro-Mechanical Behavior at Korean Reference Disposal System Using TOUGH2-MP/FLAC3D Simulator
# Reference Paper:  Thermal-hydro-mechanical properties of reference bentonite buffer for a korean HLW repository
[Mesh]
  file = 'DGR_3D_9_24_rev2.msh'
[]

[GlobalParams]
  PorousFlowDictator = dictator
[]

[Variables]
  [./temp]
   order = FIRST
   family = LAGRANGE
  [../]
  [./porepressure]
  [../]
  [./H2O]
   order = FIRST
   family = LAGRANGE
  [../]

#Chemcal species
#  [./O2]
#   order = FIRST
#   family = LAGRANGE
#  [../]
#  [./Cu]
#   order = FIRST
#   family = LAGRANGE
#  [../]
#  [./OH-]
#   order = FIRST
#   family = LAGRANGE
#  [../]
#  [./Cu2O]
#   order = FIRST
#   family = LAGRANGE
#  [../]
#  [./e]
#   order = FIRST
#   family = LAGRANGE
#  [../]
#  [./H+]
#   order = FIRST
#   family = LAGRANGE
#  [../]
#  [./Cu2+]
#   order = FIRST
#   family = LAGRANGE
#  [../]
#  [./Cu+]
#   order = FIRST
#   family = LAGRANGE
#  [../]
#  [./HS-]
#   order = FIRST
#   family = LAGRANGE
#  [../]
#  [./Cu2S]
#   order = FIRST
#   family = LAGRANGE
#  [../]
#  [./H2]
#   order = FIRST
#   family = LAGRANGE
#  [../]
[]

[ICs]
# Temperature initial condition
  [./IC_T_hostrock]
    type = FunctionIC
    variable = temp
    function = tempy
    block = 'hostrock'
  [../]
  [./IC_T_bentonite]
    type = FunctionIC
    variable = temp
    function = tempy
    block = 'bentonite'
  [../]
  [./IC_T_backfill]
    type = FunctionIC
    variable = temp
    function = tempy
    block = 'backfill'
  [../]

# Groundwater initial condition
  [./IC_H2O_Hostrock]
    type = ConstantIC
    variable = H2O
    value = 100 # degree of saturation
    block = 'hostrock'
  [../]
  [./IC_H2O_bentonite]
    type = ConstantIC
    variable = H2O
    value = 59
    block = 'bentonite'
  [../]
  [./IC_H2O_backfill]
    type = ConstantIC
    variable = H2O
    value = 59
    block = 'backfill'
  [../]

# Pressure initial condition
  [IC_Press_Hostrock]
    type = FunctionIC
    variable = porepressure
    function = hydro_static # hydrostatic pressure 7MPa + swelling pressure 7MPa [Pa]
    block = 'hostrock'
  [../]
  [IC_Press_bentonite]
    type = ConstantIC
    variable = porepressure
    value = 1E5 # hydrostatic pressure 7MPa + swelling pressure 7MPa [Pa]
    block = 'bentonite'
  [../]
  [IC_Press_backfill]
    type = ConstantIC
    variable = porepressure
    value = 1E5 # hydrostatic pressure 7MPa + swelling pressure 7MPa [Pa]
    block = 'backfill'
  [../]
#  [./IC_T_copper]
#    type = FunctionIC
#    variable = T
#    function = tempy
#    block = 'copper'
#  [../]
[]

####### Darcy Flow related terms #######
[PorousFlowBasicTHM]
  porepressure = porepressure
  coupling_type = Hydro
  gravity = '0 0 -9.81'
  fp = the_simple_fluid
[]

[Modules]
  [./FluidProperties]
    [./the_simple_fluid]
      type = SimpleFluidProperties
      bulk_modulus = 2.1E9 # [Pa]
      viscosity = 8.9E-4
      density0 = 1000
    [../]
  [../]
[]

[UserObjects]
  [./PorousFlow]
    type = PorousFlowDictator
    porous_flow_vars = porepressure
    number_fluid_phases = 1
    number_fluid_components = 1
  [../]
# Van Genuchten capillary pressure
  [./Suction_pressure_bentonite]    
    type = PorousFlowCapillaryPressureVG
    alpha = 1E-7
    m = 0.2941
    block = 'bentonite'
  [../]
  [./Suction_pressure_backfill]    
    type = PorousFlowCapillaryPressureVG
    alpha = 2.5E-7
    m = 0.5
    block = 'backfill'
  [../]
  [./Suction_pressure_hostrock]    
    type = PorousFlowCapillaryPressureVG
    alpha = 6.6666667E-7
    m = 0.6
    block = 'hostrock'
  [../]
[]
#############################################

[Kernels]
# HeatConduction terms
  [./hc_bentonite]
    type = HeatConduction
    variable = temp
    block = 'bentonite'
  [../]
  [./hct_bentonite]
    type = HeatConductionTimeDerivative
    variable = temp
    block = 'bentonite'
  [../]
  [./hc_hostrock]
    type = HeatConduction
    variable = temp
    block = 'hostrock'
  [../]
  [./hct_hostrock]
    type = HeatConductionTimeDerivative
    variable = temp
    block = 'hostrock'
  [../]
  [./hc_backfill]
    type = HeatConduction
    variable = temp
    block = 'backfill'
  [../]
  [./hct_backfill]
    type = HeatConductionTimeDerivative
    variable = temp
    block = 'backfill'
  [../]

##### Darcy Flow terms before saturation driving force
  [./Darcy_H2O_hostrock]
    type = PorousFlowBasicAdvection
    variable = H2O
    block = 'hostrock'
  [../]
  [./Darcy_H2O_bentonite]
    type = PorousFlowBasicAdvection
    variable = H2O
    block = 'bentonite'
  [../]
  [./Darcy_H2O_backfill]
    type = PorousFlowBasicAdvection
    variable = H2O
    block = 'backfill'
  [../]

##### Water diffusion terms after saturation driving force
  [./dH2O_dt_hostrock]
    type = TimeDerivative
    variable = H2O
    block = 'hostrock'
  [../] 
  [./Diff_H2O_hostrock]
    type = CoefDiffusion
    coef = 9.5E-4  # m/s * 365 * 24 * 3600s diffusion coeff = 3E-10
    variable = H2O
    block = 'hostrock'
  [../]
  [./dH2O_dt_bentonite]
    type = TimeDerivative
    variable = H2O
    block = 'bentonite'
  [../] 
  [./Diff_H2O_bentonite]
    type = CoefDiffusion
    coef = 9.5E-4  # m^2/s * 365 * 24 * 3600s diffusion coeff = 3E-10
    variable = H2O
    block = 'bentonite'
  [../]
  [./dH2O_dt_backfill]
    type = TimeDerivative
    variable = H2O
    block = 'backfill'
  [../] 
  [./Diff_H2O_backfill]
    type = CoefDiffusion
    coef = 9.5E-4  # m^2/s * 365 * 24 * 3600s diffusion coeff = 3E-10
    variable = H2O
    block = 'backfill'
  [../]
#  [./hc_copper]
#    type = HeatConduction
#    variable = T
#    block = 'copper'
#  [../]
#  [./hct_copper]
#    type = HeatConductionTimeDerivative
#    variable = T
#    block = 'copper'
#  [../]
[]

#[ChemicalReactions]
# [./Network]
#   block = 0
#   species = ''
#   reaction_coefficient_format = 'rate'
#   track_rates = True
#   reaction = ''
# [../]
#[]

[BCs]
# Thermal Boundary Conditions
  [./canister_heatflux_BC]
    type = FunctionNeumannBC
    variable = temp
    boundary = 'spent_fuel'
    function = Decay_fn
  [../] 
#  [./hostrock_T_BC]
#    type = DirichletBC
#    variable = temp
#    boundary = 'top'
#    value = 283.15 #[k]
#  [../] 

# Pressure Boundary Conditions
  [./hostrock_Pressure_BC]
    type = FunctionDirichletBC
    variable = porepressure
    function = hydro_static
    boundary = 'right'
  [../]
[]

[Functions]
  [./tempy]
    type = ParsedFunction
    value = '283.15 - 0.03 * y' #[k]
  [../]
  [./Decay_fn]
    type = ParsedFunction
    vars = 'a b c d f g h i j k l m n ta tb tc td tf tg th ti tj tk tl tm tn r P0 yts'
    vals = '0.453566432 0.025684564 -0.003857903 0.01012861 0.001756896 0.000646827 0.00085657 -9.65E-05 0.000140484 0.00010715 9.76E-06 -8.92E-06 9.43E-06 1 3 10 30 100 300 1000 3000 10000 30000 100000 300000 1000000 0.61 159000 31536000'
    value = '2.683 * (10^4) * yts * ((t+30)^-0.758) / (2 * pi * r * 4.83 + 2 * pi * r * r)'
#   value = '2 * P0 * yts  * (a * exp(-t / ta) + b * exp(-t / tb) + c * exp(-t / tc) + d * exp(-t / td) + f * exp(-t / tf) + g * exp(-t / tg) + h * exp(-t / th) + i * exp(-t / ti) + j * exp(-t / tj) + k * exp(-t / tk) + l * exp(-t / tl) + m * exp(-t / tm) + n * exp(-t / tn)) / (2 * pi * r * 4.83 + 2 * pi * r * r)' #[W/m^2]
  [../]
  [./hydro_static]
    type = ParsedFunction
    value = '(-1000 * 9.81 * y)'  #[Pa]
  [../]
[]

[Materials]
# Heat Conduction Material Properties
# Gyeongju Bentonite type KJ II
  [./Bentonite_thermal_conductivity]
    type = ParsedMaterial
    f_name = thermal_conductivity
    args = 'H2O'
    function = '(0.72 + (0.48 * H2O/100)) * 365 * 24 * 3600' #[Wyr/mk]
    block = 'bentonite'
  [../]
  [./Bentonite_thermal_conductivity_dT]
    type = DerivativeParsedMaterial
    f_name = thermal_conductivity_dT
    args = 'H2O'
    function = '0' #[Wyr/mk]
    derivative_order = 1
    block = 'bentonite'
  [../]
  [./Bentonite_specific_heat]
    type = ParsedMaterial
    f_name = specific_heat
    args = 'H2O'
    function = '966' #[J/kgK]
    block = 'bentonite'
  [../]
  [./Bentonite_specific_heat_dT]
    type = DerivativeParsedMaterial
    f_name = specific_heat_dT
    args = 'H2O'
    function = '0' #[J/kgK]
    derivative_order = 1
    block = 'bentonite'
  [../]
  [./Bentonite_density]
    type = GenericConstantMaterial
    prop_names = density
    prop_values = 2740 #[kg/m^3]
    block = 'bentonite'
  [../]
  [./hostrock_heatcond]
    type = HeatConductionMaterial
    specific_heat  = 820
    thermal_conductivity  = 9.98E7
    block = 'hostrock'
  [../]
  [./hostrock_density]
    type = GenericConstantMaterial
    prop_names = density
    prop_values = 2650
    block = 'hostrock'
  [../]
  [./Backfill_thermal_conductivity]
    type = ParsedMaterial
    f_name = thermal_conductivity
    args = 'H2O'
    function = '(1.09 + (1.059 * H2O/100)) * 365 * 24 * 3600' #[Wyr/mk]
    block = 'backfill'
  [../]
  [./Backfill_thermal_conductivity_dT]
    type = DerivativeParsedMaterial
    f_name = thermal_conductivity_dT
    args = 'H2O'
    function = '0' #[Wyr/mk]
    derivative_order = 1
    block = 'backfill'
  [../]
  [./Backfill_specific_heat]
    type = ParsedMaterial
    f_name = specific_heat
    args = 'H2O'
    function = '981' #[J/kgK]
    block = 'backfill'
  [../]
  [./Backfill_specific_heat_dT]
    type = DerivativeParsedMaterial
    f_name = specific_heat_dT
    args = 'H2O'
    function = '0' #[J/kgK]
    derivative_order = 1
    block = 'backfill'
  [../]
  [./backfill_density]
    type = GenericConstantMaterial
    prop_names = density
    prop_values = 2680
    block = 'backfill'
  [../]

# Hydraulic Material Properties
  [./bentonite_permeability]
    type = PorousFlowPermeabilityConst
    block = 'bentonite'
# You need to use intrinsic permeability [m^2] 
# intrinsic permeability = hydraulic conductivity * dynamic viscosity /(density of water * gravity accelerator)
    permeability = '1.5E-20 0 0    0 1.5E-20 0    0 0 1.5E-20'   # hydraulic conductivity = 1E-13 [m/s]
  [../]
  [./backfill_permeability]
    type = PorousFlowPermeabilityConst
    block = 'backfill'
    permeability = '1.6E-19 0 0    0 1.6E-19 0    0 0 1.6E-19'
  [../]
  [./hostrock_permeability]
    type = PorousFlowPermeabilityConst
    block = 'hostrock'
    permeability = '1E-18 0 0    0 1E-18 0    0 0 1E-18'
  [../]
  [./porosity_bentonite]
    type = PorousFlowPorosity
    porosity_zero = 0.4 #reference by SKB report
    block = 'bentonite'
  [../]
  [./porosity_backfill]
    type = PorousFlowPorosity
    porosity_zero = 0.41 #reference by SKB report
    block = 'backfill'
  [../]
  [./porosity_hostrock]
    type = PorousFlowPorosity
    porosity_zero = 0.01 #reference by SKB report
    block = 'hostrock'
  [../]
  [./biot_modulus_bentonite]
    type = PorousFlowConstantBiotModulus
    biot_coefficient = 1
    block = 'bentonite'
    solid_bulk_compliance = 2E-7
  [../]
  [./biot_modulus_backfill]
    type = PorousFlowConstantBiotModulus
    biot_coefficient = 1
    block = 'backfill'
    solid_bulk_compliance = 2E-7
  [../]
  [./biot_modulus_hostrock]
    type = PorousFlowConstantBiotModulus
    biot_coefficient = 1
    block = 'hostrock'
    solid_bulk_compliance = 2E-7
  [../]
  [./darcy_velocity_qp_bentonite]
    type = PorousFlowDarcyVelocityMaterial
    gravity = '0 0 -9.81'
    block = 'bentonite'
  [../]
  [./darcy_velocity_qp_backfill]
    type = PorousFlowDarcyVelocityMaterial
    gravity = '0 0 -9.81'
    block = 'backfill'
  [../]
  [./darcy_velocity_qp_hostrock]
    type = PorousFlowDarcyVelocityMaterial
    gravity = '0 0 -9.81'
    block = 'hostrock'
  [../]
[]

[Executioner]
  type = Transient
  start_time = 0
  end_time = 200
  solve_type = 'PJFNK'
  l_abs_tol = 1e-15
  nl_abs_tol = 1e-15
#  dt = 0.0001
  

  petsc_options_iname = '-pc_type -pc_hypre_type' 
  petsc_options_value = 'hypre    boomeramg'
  [./TimeStepper]
    type = IterationAdaptiveDT
    cutback_factor = 0.9
    dt = 0.1
    growth_factor = 1.1
  [../]
[]

[Preconditioning]
  [./smp]
    type = SMP
    full = true
  [../]
[]

[Outputs]
 [./out]
  type = Exodus
 [../]
[]

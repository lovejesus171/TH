[Mesh]
   file = 'test.msh'
[]

[Variables]
  # Name of chemical species
  [./Cu]
    block = 'Solution Copper'
    order = FIRST
  [../]
  [./HS]
    block = 'Solution Copper'
    order = FIRST
    initial_condition = 1 #[mol/m3]
  [../]
  [./Cu2S]
    block = 'Solution Copper'
    order = FIRST
    initial_condition = 0
  [../]
  [./SO4]
    block = 'Solution Copper'
    order = FIRST
    initial_condition = 0
  [../]
  [./H2O2]
    block = 'Solution Copper'
    order = FIRST
    initial_condition = 0 #[mol/m3]
  [../]
  [./T]
    block = 'Solution Copper'
    order = FIRST
    family = LAGRANGE
    initial_condition = 303.15 #[K]
  [../]
  [./pH]
    block = 'Solution Copper'
    order = FIRST
    family = LAGRANGE
    initial_condition = 7 #[pH = log(H+)]
  [../]
[]

[ICs]
  [./Copper_block]
    type = ConstantIC
    block = 'Copper'
    variable = Cu
    value = 141000.22
  [../]
  [./Solution_block]
    type = ConstantIC
    block = 'Solution'
    variable = Cu
    value = 0
   [../]
[]

[Kernels]
  # dCi/dt
  [./dHS_dt]
    block = 'Solution Copper'
    type = TimeDerivative
    variable = HS
  [../]
  [./dCu2S_dt]
    block = 'Solution Copper'
    type = TimeDerivative
    variable = Cu2S
  [../]
  [./dSO4_dt]
    block = 'Solution Copper'
    type = TimeDerivative
    variable = SO4
  [../]
  [./dH2O2_dt]
    block = 'Solution Copper'
    type = TimeDerivative
    variable = H2O2
  [../]
  [./dCu_dt]
    block = 'Solution Copper'
    type = TimeDerivative
    variable = Cu
  [../]
  [./dpH_dt]
    block = 'Solution Copper'
    type = TimeDerivative
    variable = pH
  [../]
# Diffusion terms
  [./DgradHS_S]
    block = 'Solution Copper'
    type = CoefDiffusion
    coef = 7.31e-10 #[m2/s]
    variable = HS
  [../]
  [./DgradHS_C]
    block = 'Solution Copper'
    type = MatDiffusion
    diffusivity = D_HS_C #[m2/s]
    variable = HS
  [../]
  [./DgradH2O2]
    block = 'Solution Copper'
    type = CoefDiffusion
    coef = 1.18e-9 #[m2/s], at 30C
    variable = H2O2
  [../]
# HeatConduction terms
  [./heat]
    block = 'Solution Copper'
    type = HeatConduction
    variable = T
  [../]
  [./ie]
    block = 'Solution Copper'
    type = HeatConductionTimeDerivative
    variable = T
  [../]
[]


[ChemicalReactions]
 [./Network]
   block = 'Solution Copper'
   species = 'HS H2O2 SO4 Cu Cu2S'
   track_rates = True

   equation_constants = 'Ea R'
   equation_values = '300 8.314'
   equation_variables = 'T pH'

   reactions = 'HS + H2O2 -> SO4 : {10^(12.04-2641/T-0.186*pH)/60}
                Cu + Cu + HS -> Cu2S : 1e-10'
 [../]
[]

#[BCs]
#  [./right_chemical]
#    type = DirichletBC
#    variable = HS
#    boundary = Copper_top
#    value = 0 #[mol/m2]
#  [../]
#[]

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
  [./Diff_HS_In_Copper]
    block = 'Solution Copper'
    type = ParsedMaterial
    f_name = D_HS_C
    args = 'T'
    function = '7.31e-10' #[m2/s]
#    function = '38.7/10^4*exp(-5600/(T-273.15))' # [m2/s]
    outputs = exodus
  [../]

[]

[Executioner]
  type = Transient
  start_time = 0 #[s]
  end_time = 100 #[s]
  solve_type = 'NEWTON'
  l_abs_tol = 1e-10
  nl_abs_tol = 1e-10
  dtmax = 1000 
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


#[Postprocessors]
#  [./Consumed_HS_mol_per_s]
#    type = SideFluxIntegral
#    variable = HS
#    diffusivity = 7.31e-10 #m2/s
#    boundary = Copper_top
#  [../]
#  [./Volume_tegetral_of_HS-]
#    type = ElementIntegralVariablePostprocessor
#    block = 'Solution'
#    variable = HS
#  [../]
#[]

[Outputs]
  exodus = true
[]

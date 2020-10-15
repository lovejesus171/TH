[Mesh]
   file = '3D_Real_Circle_Copper.msh'
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
   initial_condition = 55347.32377 #[mol/m3] at 25 C
  [../]
#  [./Cu]
#    block = 'Solution'
#    order = FIRST
#  [../]
  [./HS-]
    block = 'Solution'
    order = FIRST
    initial_condition = 1 #[mol/m3]
  [../]
#  [./Cu2S]
#    block = 'Solution'
#    order = FIRST
#    initial_condition = 0
#  [../]
#  [./SO42-]
#    block = 'Solution'
#    order = FIRST
#   initial_condition = 0
#  [../]
#  [./H2O2]
#    block = 'Solution'
#    order = FIRST
#    initial_condition = 0 #[mol/m3]
#  [../]
  [./T]
    block = 'Solution'
    order = FIRST
    family = LAGRANGE
    initial_condition = 298.15 #[K]
  [../]
#  [./pH]
#    block = 'Solution'
#    order = FIRST
#    family = LAGRANGE
#    initial_condition = 11.00 #[pH = log(H+)]
#  [../]
[]

#[ICs]
#  [./Solution_block]
#    type = ConstantIC
#    block = 'Solution'
#    variable = Cu
#    value = 0
#   [../]
#[]

[Kernels]
  # dCi/dt
  [./dHS_dt]
    block = 'Solution'
    type = TimeDerivative
    variable = HS-
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
  [./H2O_dt]
    block = 'Solution'
    type = TimeDerivative
    variable = H2O
  [../]
#  [./dCu2S_dt]
#    block = 'Solution'
#    type = TimeDerivative
#    variable = Cu2S
#  [../]
#  [./dSO4_dt]
#    block = 'Solution'
#    type = TimeDerivative
#    variable = SO42-
#  [../]
#  [./dH2O2_dt]
#    block = 'Solution'
#    type = TimeDerivative
#    variable = H2O2
#  [../]
#  [./dCu_dt]
#    block = 'Solution'
#    type = TimeDerivative
#    variable = Cu
#  [../]
#  [./dpH_dt]
#    block = 'Solution'
#    type = TimeDerivative
#    variable = pH
#  [../]
# Diffusion terms
  [./DgradHS]
    block = 'Solution'
    type = CoefDiffusion
    coef = 7.31e-10 #[m2/s]
    variable = HS-
  [../]
  [./DgradHp]
    block = 'Solution'
    type = CoefDiffusion
    coef = 7.31e-10 #[m2/s]
    variable = H+
  [../]
  [./DgradOHm]
    block = 'Solution'
    type = CoefDiffusion
    coef = 7.31e-10 #[m2/s]
    variable = OH-
  [../]
  [./DgradH2O]
    block = 'Solution'
    type = CoefDiffusion
    coef = 7.31e-10 #[m2/s]
    variable = H2O
  [../]
  


#  [./DgradHS_C]
#    block = 'Solution Copper'
#    type = MatDiffusion
#    diffusivity = D_HS_C #[m2/s]
#    variable = HS-
#  [../]
#  [./DgradH2O2]
#    block = 'Solution'
#    type = CoefDiffusion
#    coef = 1.18e-9 #[m2/s], at 30C
#    variable = H2O2
#  [../]
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


[ChemicalReactions]
 [./Network]
   block = 'Solution'
   species = 'H+ OH- H2O'
  track_rates = True

   equation_constants = 'Ea R'
   equation_values = '300 8.314'
   equation_variables = 'T'

   reactions = 'H2O -> OH- + H+ : {2.54972e-5}
                OH- + H+ -> H2O : {1.4e8}
                '
 [../]
[]

[BCs]
  [./right_chemical]
    type = DirichletBC
    variable = HS-
    boundary = Copper_top
    value = 0 #[mol/m2]
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
#  [./Diff_HS_In_Copper]
#    block = 'Solution'
#    type = ParsedMaterial
#    f_name = D_HS_C
#    args = 'T'
#    function = '7.31e-10' #[m2/s]
#    function = '38.7/10^4*exp(-5600/(T-273.15))' # [m2/s]
#    outputs = exodus
#  [../]

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


[Postprocessors]
  [./Consumed_HS_mol_per_s]
    type = SideFluxIntegral
    variable = HS-
    diffusivity = 7.31e-10 #m2/s
    boundary = Copper_top
  [../]
  [./Volume_tegetral_of_HS-]
    type = ElementIntegralVariablePostprocessor
    block = 'Solution'
    variable = HS-
  [../]
[]

[Outputs]
  exodus = true
[]

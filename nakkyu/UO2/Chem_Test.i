[Mesh]
  file = 'UO2.msh'
  construct_side_list_from_node_list = true
[]


[Variables]
  # Name of chemical species
  [./UO22+]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./UO32H2O]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./H2O2]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./UO2O24H2O]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./H2]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 1E-6 #mol/m3
  [../]
  [./H+]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 1E-4 #mol/m3
  [../]
  [./UO2CO322-]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./CO32-]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 1E-6 #mol/m3
  [../]
  [./Fe2+]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 1E-6 #mol/m3
  [../]
  [./OH-]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 1E-4 #mol/m3
  [../]
  [./Fe2O3]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./UO2_precip]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./O2]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 1E-3 #mol/m3
  [../]
  [./H2O]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 55314 #mol/m3
  [../]
  [./UOH4]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./UO2CO334-]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]



  [./T]
    block = 'Alpha Solution'
    order = FIRST
    family = LAGRANGE
    initial_condition = 298.15 #[K]
  [../]
  [./ConsumedH2O2]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./ConsumedFe2+]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
[]


[Functions]
  [H2O2_produce]
    type = ParsedFunction
    value = '1.02E-4 * 1E3 * (0.99883 - 11833.90869 * x)^(-1/-0.13308)' #1.02E-4 mol/m3/Gy * 1000 Gy/s
  []
[]

[Kernels]
# dCi/dt
  [./dUO22+_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = UO22+
  [../]
  [./dUO32H2O_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = UO32H2O
  [../]
  [./dH2O2_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = H2O2
  [../]
  [./dUO2O24H2O_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = UO2O24H2O
  [../]
  [./dH2_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = H2
  [../]
  [./dH+_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = H+
  [../]
  [./dUO2CO322-_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = UO2CO322-
  [../]
  [./dCO32-_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = CO32-
  [../]
  [./dFe2+_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = Fe2+
  [../]
  [./dOH-_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = OH-
  [../]
  [./dFe2O3_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = Fe2O3
  [../]
  [./dUO2_precip_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = UO2_precip
  [../]
  [./dO2_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = O2
  [../]
  [./dH2O_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = H2O
  [../]
  [./dUOH4_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = UOH4
  [../]
  [./dUO2CO334-_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = UO2CO334-
  [../]
  [./dConsumedH2O2_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = ConsumedH2O2
  [../]
  [./dConsumedFe2+_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = ConsumedFe2+
  [../]




# Diffusion terms
  [./DgradH2O]
    block = 'Alpha Solution'
    type = CoefDiffusion
    coef = 2.31E-9 #[m2/s], at 25C
    variable = H2O
  [../]
  [./DgradHp]
    block = 'Alpha Solution'
    type = CoefDiffusion
    coef = 1.01E-8 #[m2/s], at 25C
    variable = H+
  [../]
  [./DgradOHm]
    block = 'Alpha Solution'
    type = CoefDiffusion
    coef = 4.82E-9 #[m2/s], at 25C
    variable = OH-
  [../]
  [./DgradH2O2]
    block = 'Alpha Solution'
    type = CoefDiffusion
    coef = 1.9E-9 #[m2/s], to be added
    variable = H2O2
  [../]
  [./DgradO2]
    block = 'Alpha Solution'
    type = CoefDiffusion
    coef = 2.5E-9 #[m2/s], to be added
    variable = O2
  [../]

  [./DgradUO22+]
    block = 'Alpha Solution'
    type = CoefDiffusion
    coef = 7.59e-10 #[m2/s], to be added
    variable = UO22+
  [../]
  [./DgradUO2CO322-]
    block = 'Alpha Solution'
    type = CoefDiffusion
    coef = 6.67E-10 #[m2/s], to be added
    variable = UO2CO322-
  [../]
  [./DgradUOH4]
    block = 'Alpha Solution'
    type = CoefDiffusion
    coef = 6E-10 #[m2/s], to be added
    variable = UOH4
  [../]
  [./DgradCO32-]
    block = 'Alpha Solution'
    type = CoefDiffusion
    coef = 8.12E-10 #[m2/s], to be added
    variable = CO32-
  [../]
  [./DgradFe2+]
    block = 'Alpha Solution'
    type = CoefDiffusion
    coef = 7.19E-10 #[m2/s], to be added
    variable = Fe2+
  [../]
  [./DgradH2]
    block = 'Alpha Solution'
    type = CoefDiffusion
    coef = 6E-9 #[m2/s], to be added
    variable = H2
  [../]
  [./DgradUO2CO334-]
    block = 'Alpha Solution'
    type = CoefDiffusion
    coef = 6.67E-10 #[m2/s], assumed same as UO2CO322-
    variable = UO2CO334-
  [../]




# HeatConduction terms
  [./heat]
    block = 'Alpha Solution'
    type = HeatConduction
    variable = T
  [../]
  [./ie]
    block = 'Alpha Solution'
    type = HeatConductionTimeDerivative
    variable = T
  [../]

## Radiolysis source
# H2O2 production
  [./H2O2_Radiolysis_product]
    block = 'Alpha'
    type = FunctionSource
    variable = H2O2
    Function_Name = H2O2_produce
  [../]



[]


[ChemicalReactions]
  [./Network]
    block = 'Alpha Solution'
    species = 'H2O2 O2 ConsumedH2O2'
    track_rates = False

    equation_constants = 'Ea R T_Re'
    equation_values = '-6E4 8.314 298.15'
    equation_variables = 'T'
   
    reactions = '
  H2O2 -> O2 : {2.25E-7*exp(Ea/R*(1/T_Re-1/T))}
  H2O2 -> ConsumedH2O2 : {2.25E-7*exp(Ea/R*(1/T_Re-1/T))}
'

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
  nl_rel_tol = 1e-2 #default = 1e-7
  l_max_its = 10
  nl_max_its = 30
  dtmax = 100

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

[Outputs]
  exodus = true
[]

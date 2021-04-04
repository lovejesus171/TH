[Mesh]
  file = 'Line3.msh'
  construct_side_list_from_node_list = true
[]
[UserObjects]
  [./changeID]
    block = 'Film Solution Copper'
    type = ActivateElementsCoupled
    execute_on = timestep_begin
    coupled_var = Cu2S
    activate_value = 2.487
    activate_type = above
    active_subdomain_id = 3
    expand_boundary_name = Interface
  [../]
[]


[Variables]
  # Name of chemical species
  [./H+]
   block = 'Film Solution Copper'
   order = FIRST
  [../]
  [./OH-]
   block = 'Film Solution Copper'
   order =FIRST
  [../]
  [./H2O]
   block = 'Film Solution Copper'
   order = FIRST
  [../]
  [./HS-]
    block = 'Film Solution Copper'
    order = FIRST
  [../]
  [./H2O2]
    block = 'Film Solution Copper'
    order = FIRST
  [../]
  [./SO42-]
    block = 'Film Solution Copper'
    order = FIRST
  [../]
  [./O2]
    block = 'Film Solution Copper'
    order = FIRST
  [../]
  [./T]
    block = 'Film Solution Copper'
    order = FIRST
    family = LAGRANGE
  [../]
  [./Cl-]
    block = 'Film Solution Copper'
    order = FIRST
  [../]
  [./CuCl2-]
    block = 'Film Solution Copper'
    order = FIRST
  [../]
  [./Cu2S]
    block = 'Film Solution Copper'
    order = FIRST
  [../]
  [./HO2-]
    block = 'Film Solution Copper'
    order = FIRST
  [../]
  [./eaq-]
    block = 'Film Solution Copper'
    order = FIRST
  [../]
  [./OH]
    block = 'Film Solution Copper'
    order = FIRST
  [../]
  [./O-]
    block = 'Film Solution Copper'
    order = FIRST
  [../]
  [./HO2]
    block = 'Film Solution Copper'
    order = FIRST
  [../]
  [./O2-]
    block = 'Film Solution Copper'
    order = FIRST
  [../]
  [./H]
    block = 'Film Solution Copper'
    order = FIRST
  [../]
[]

[ICs]
  [./CS_H+]
    block = 'Copper Solution'
    type = ConstantIC
    variable = H+
    value = 1E-5
  [../]
  [./CS_OH-]
    block = 'Copper Solution'
    type = ConstantIC
    variable = OH-
    value = 1E-5
  [../]
  [./CS_H2O]
    block = 'Copper Solution'
    type = ConstantIC
    variable = H2O
    value = 55347
  [../]
  [./CS_HS-]
    block = 'Copper Solution'
    type = ConstantIC
    variable = HS-
    value = 1
  [../]
  [./CS_H2O2]
    block = 'Copper Solution'
    type = ConstantIC
    variable = H2O2
    value = 0
  [../]
  [./CS_SO42-]
    block = 'Copper Solution'
    type = ConstantIC
    variable = SO42-
    value = 0
  [../]
  [./CS_O2]
    block = 'Copper Solution'
    type = ConstantIC
    variable = O2
    value = 0
  [../]
  [./CS_Cl-]
    block = 'Copper Solution'
    type = ConstantIC
    variable = Cl-
    value = 0.5E3
  [../]
  [./CS_CuCl2-]
    block = 'Copper Solution'
    type = ConstantIC
    variable = CuCl2-
    value = 1E-10
  [../]
  [./CS_Cu2S]
    block = 'Copper Solution'
    type = ConstantIC
    variable = Cu2S
    value = 0
  [../]
  [./CS_HO2-]
    block = 'Copper Solution'
    type = ConstantIC
    variable = HO2-
    value = 0
  [../]
  [./CS_eaq-]
    block = 'Copper Solution'
    type = ConstantIC
    variable = eaq-
    value = 0
  [../]
  [./CS_OH]
    block = 'Copper Solution'
    type = ConstantIC
    variable = OH
    value = 0
  [../]
  [./CS_O-]
    block = 'Copper Solution'
    type = ConstantIC
    variable = O-
    value = 0
  [../]
  [./CS_HO2]
    block = 'Copper Solution'
    type = ConstantIC
    variable = HO2
    value = 0
  [../]
  [./CS_O2-]
    block = 'Copper Solution'
    type = ConstantIC
    variable = O2-
    value = 0
  [../]
  [./CS_H]
    block = 'Copper Solution'
    type = ConstantIC
    variable = H
    value = 0
  [../]

  [./Film_H+]
    block = 'Film'
    type = ConstantIC
    variable = H+
    value = 0
  [../]
  [./Film_OH-]
    block = 'Film'
    type = ConstantIC
    variable = OH-
    value = 0
  [../]
  [./Film_H2O]
    block = 'Film'
    type = ConstantIC
    variable = H2O
    value = 0
  [../]
  [./Film_HS-]
    block = 'Film'
    type = ConstantIC
    variable = HS-
    value = 0
  [../]
  [./Film_H2O2]
    block = 'Film'
    type = ConstantIC
    variable = H2O2
    value = 0
  [../]
  [./Film_SO42-]
    block = 'Film'
    type = ConstantIC
    variable = SO42-
    value = 0
  [../]
  [./Film_O2]
    block = 'Film'
    type = ConstantIC
    variable = O2
    value = 0
  [../]
  [./Film_Cl-]
    block = 'Film'
    type = ConstantIC
    variable = Cl-
    value = 0
  [../]
  [./Film_CuCl2-]
    block = 'Film'
    type = ConstantIC
    variable = CuCl2-
    value = 0
  [../]
  [./Film_Cu2S]
    block = 'Film'
    type = ConstantIC
    variable = Cu2S
    value = 0
  [../]
  [./Film_HO2-]
    block = 'Film'
    type = ConstantIC
    variable = HO2-
    value = 0
  [../]
  [./Film_eaq-]
    block = 'Film'
    type = ConstantIC
    variable = eaq-
    value = 0
  [../]
  [./Film_OH]
    block = 'Film'
    type = ConstantIC
    variable = OH
    value = 0
  [../]
  [./Film_O-]
    block = 'Film'
    type = ConstantIC
    variable = O-
    value = 0
  [../]
  [./Film_HO2]
    block = 'Film'
    type = ConstantIC
    variable = HO2
    value = 0
  [../]
  [./Film_O2-]
    block = 'Film'
    type = ConstantIC
    variable = O2-
    value = 0
  [../]
  [./Film_H]
    block = 'Film'
    type = ConstantIC
    variable = H
    value = 0
  [../]

[]


[AuxVariables]
  [./Ecorr]
    block = 'Film Solution Copper'
    order = FIRST
    family = LAGRANGE
  [../]
[]


[AuxKernels]
  [./Calculate_Corrosion_Potential]
    block = 'Film Solution Copper'
    type = TT   #exclude O2 reduction reaction
    variable = Ecorr
#    C0 = O2
    C1 = CuCl2-
#    C3 = Cu2+  #default: 0
    C6 = Cl-
    C9 = HS-
    Porosity = 0.15 # Porosity of film
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

  [./HO2-_dt]
    block = 'Film Solution Copper'
    type = TimeDerivative
    variable = HO2-
  [../]
  [./eaq-_dt]
    block = 'Film Solution Copper'
    type = TimeDerivative
    variable = eaq-
  [../]
  [./OH_dt]
    block = 'Film Solution Copper'
    type = TimeDerivative
    variable = OH
  [../]
  [./O-_dt]
    block = 'Film Solution Copper'
    type = TimeDerivative
    variable = O-
  [../]
  [./HO2_dt]
    block = 'Film Solution Copper'
    type = TimeDerivative
    variable = HO2
  [../]
  [./O2-_dt]
    block = 'Film Solution Copper'
    type = TimeDerivative
    variable = O2-
  [../]
  [./H_dt]
    block = 'Film Solution Copper'
    type = TimeDerivative
    variable = H
  [../]

# Diffusion terms
  [./DgradHSF]
    block = 'Film'
    type = CoefDiffusion
    coef = 9.70244e-8 #[m2/hr], from SKI report and I assumed Cu+ ion diffusion coef = HS- diffusion coefficient in Cu2S
    variable = HS-
  [../]
  [./DgradHSS]
    block = 'Solution Copper'
    type = CoefDiffusion
    coef = 6.2316e-6 #[m2/hr], from hand book, original: 1.731E-5 [cm2/s]
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
  
  [./DgradHO2-]
    block = 'Film Solution Copper'
    type = CoefDiffusion
    coef = 17352e-9 #[m2/s], to be added
    variable = HO2-
  [../]
  [./Dgradeaq-]
    block = 'Film Solution Copper'
    type = CoefDiffusion
    coef = 17352e-9 #[m2/s], to be added
    variable = eaq-
  [../]
  [./DgradOH]
    block = 'Film Solution Copper'
    type = CoefDiffusion
    coef = 17352e-9 #[m2/s], to be added
    variable = OH
  [../]
  [./DgradO-]
    block = 'Film Solution Copper'
    type = CoefDiffusion
    coef = 17352e-9 #[m2/s], to be added
    variable = O-
  [../]
  [./DgradHO2]
    block = 'Film Solution Copper'
    type = CoefDiffusion
    coef = 17352e-9 #[m2/s], to be added
    variable = HO2
  [../]
  [./DgradO2-]
    block = 'Film Solution Copper'
    type = CoefDiffusion
    coef = 17352e-9 #[m2/s], to be added
    variable = O2-
  [../]
  [./DgradH]
    block = 'Film Solution Copper'
    type = CoefDiffusion
    coef = 17352e-9 #[m2/s], to be added
    variable = H
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

[ChemicalReactions]
  [./Network]
    block = 'Solution Copper Film'
    species = 'HS- H2O OH- H+'
    track_rates = False

    equation_constants = 'aE aF F R EE EF Porosity kE kF T_Re k2 CH2O k3 k4 k5 k6'
    equation_values = '0.5 0.15 96485 8.314 -1.005 -0.764 0.15 7.2E-6 2.44E-3 298.15 10^-15.7 55347 10^-11.65 10^-11.9 10^-4.57 10^-9.77'
    equation_variables = 'T'
    reactions = '
H+ + OH- -> H2O : {1.4E11/1000}
H2O -> H+ + OH- : {1.4E11*k2/CH2O}
'
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
 [../]
 [./BC_Cl-]
   type = ADClm
   variable = Cl-
   Reactant1 = CuCl2-
#   boundary = 'Copper_top Copper_side'
   boundary = 'Copper_top'
#   boundary = Interface
   Corrosion_potential = Ecorr
   Temperature = 298.15
   kF = 1.188E-4
   kB = 2.4444E-3
   StandardPotential = -0.105
   Num  = -2
 [../]
 [./BC_CuCl2-]
   type = ADCuCl2m
   variable = CuCl2-
   Reactant1 = Cl-
#   boundary = 'Copper_top Copper_side'
   boundary = 'Copper_top'
#   boundary = Interface
   Corrosion_potential = Ecorr
   Temperature = 298.15
   kF = 1.188E-4
   kB = 2.4444E-3
   StandardPotential = -0.105
   Num  = 1
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
 [./Isolated_HO2-]
   type = NeumannBC
   boundary = Isolated
   value = 0
   variable = HO2-
 [../]
 [./Isolated_eaq-]
   type = NeumannBC
   boundary = Isolated
   value = 0
   variable = eaq-
 [../]
 [./Isolated_OH]
   type = NeumannBC
   boundary = Isolated
   value = 0
   variable = OH
 [../]
 [./Isolated_O-]
   type = NeumannBC
   boundary = Isolated
   value = 0
   variable = O-
 [../]
 [./Isolated_HO2]
   type = NeumannBC
   boundary = Isolated
   value = 0
   variable = HO2
 [../]
 [./Isolated_O2-]
   type = NeumannBC
   boundary = Isolated
   value = 0
   variable = O2-
 [../]
 [./Isolated_H]
   type = NeumannBC
   boundary = Isolated
   value = 0
   variable = H
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
  nl_rel_tol = 1e-5 #default = 1e-7
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
[]

[Outputs]
#  file_base = 2020_12_30_Sibal
#  sync_times = '0 1e-1 1 10 100 1000 1e4 2e4 3e4 4e4 5e4 6e4 7e4 8e4 9e4 1e5 2e5 3e5 4e5 5e5 6e5 7e5 8e5 9e5 1e6 2e6 3e6 4e6 5e6 6e6 6048000'
  exodus = true
[]

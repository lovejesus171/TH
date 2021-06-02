[Mesh]
  file = 'UO2.msh'
  construct_side_list_from_node_list = true
[]


[Variables]
  [./UO22+]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./UO23+]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
[]

[AuxVariables]
  [./AB]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./ABC]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
  [./ABCD]
   block = 'Alpha Solution'
   order = FIRST
   initial_condition = 0 #mol/m3
  [../]
[]

[Kernels]
# dCi/dt
  [./dUO22+_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = UO22+
  [../]
  [./dUO23+_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = UO23+
  [../]
# Diffusion terms
  [./DgradUO22+]
    block = 'Alpha Solution'
    type = CoefDiffusion
    coef = 3.19E-1 #[m2/s], at 25C
    variable = UO22+
  [../]
  [./DgradUO23+]
    block = 'Alpha Solution'
    type = CoefDiffusion
    coef = 3.19E-1 #[m2/s], at 25C
    variable = UO23+
  [../]

  [./UO22+Source]
    block = 'Alpha Solution'
    type = Source
    variable = UO22+
    Source = 1E-9
  [../]


  [./UO2precipReaction_Consumption]
    block = 'Alpha Solution'
    type = RT
    variable = UO22+
    Num = -1
    Sat = 2.2E-9
    k = 1E-3
  [../]

  [./UO23+Generation]
    block = 'Alpha Solution'
    type = RT2
    variable = UO23+
    Num = 1
    k = 1E-10
    UO2precip = IAA
  [../]
  

[]

[AuxKernels]
  [./AB_Reaction]
    type = AuxPre
    variable = AB
    v = UO22+
    k = 1
    Sign = 1
  [../]
  [./AB_ReactionAccumulation]
    type = AuxPre2
    variable = ABC
    v = AB
  [../]

# Load postprocessor value by the following auxkernel!
  [./ABCD]
    type = PostprocessorAux
    pp = fuck_cumulative
    variable = ABCD
  [../]
[]

[Materials]
  [./UO2Precip]
    block = 'Alpha Solution'
    type = MT
    C1 = UO22+
    Sat = 2.2E-9
    outputs = exodus
  [../]
  [./UO2Precip2]
    block = 'Alpha Solution'
    type = MT2
    C1 = ABC
    Sat = 1
    outputs = exodus
  [../]
[]


[Executioner]
  type = Transient
  start_time = 0 #[hr]
  end_time = 100 #[hr]
  solve_type = 'PJFNK'
#  l_abs_tol = 1e-12
#  l_tol = 1e-7 #default = 1e-5
#  nl_abs_tol = 1e-12
  nl_rel_tol = 1e-1 #default = 1e-7
#  l_rel_tol = 1e-35
  l_max_its = 50
  nl_max_its = 5
  dtmax = 1

  automatic_scaling = true
  compute_scaling_once = false

  [./TimeStepper]
    type = IterationAdaptiveDT
    cutback_factor = 0.99
    dt = 1
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
  [./fuck]
    type = PT
    variable = UO22+ #Coupled Variable from auxkernel or kernel variables
    Saturation = 5E-8
    k1 = 1
  [../]
  [./fuck_cumulative]
    type = CumulativeValuePostprocessor
    postprocessor = fuck
  [../]


[]


[Outputs]
  exodus = true
[]

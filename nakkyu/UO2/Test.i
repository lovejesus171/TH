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
[]



[Kernels]
# dCi/dt
  [./dUO22+_dt]
    block = 'Alpha Solution'
    type = TimeDerivative
    variable = UO22+
  [../]
# Diffusion terms
  [./DgradUO22+]
    block = 'Alpha Solution'
    type = CoefDiffusion
    coef = 7.59e-10 #[m2/s], to be added
    variable = UO22+
  [../]
[]




[Materials]
  [./Corrosion_Potential]
     block = 'Alpha Solution'
     type = TestMat
     outputs = exodus
  [../]
[]

[Executioner]
  type = Transient
  start_time = 0 #[hr]
  end_time = 1000 #[hr]
  solve_type = 'PJFNK'
#  l_abs_tol = 1e-12
#  l_tol = 1e-7 #default = 1e-5
#  nl_abs_tol = 1e-12
  nl_rel_tol = 1e-3 #default = 1e-7
#  l_rel_tol = 1e-35
  l_max_its = 30
  nl_max_its = 10
  dtmax = 100

  scheme = crank-nicolson  
  line_search = bt

  automatic_scaling = true
  compute_scaling_once = false
  verbose = true

  [./TimeStepper]
    type = IterationAdaptiveDT
    cutback_factor = 1
    dt = 1
    growth_factor = 1
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

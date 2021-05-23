[Mesh]
  type = GeneratedMesh
  dim = 1
  xmin = 0
  xmax = 10
  nx = 30
[]

[Variables]
  [./a]
    order = FIRST
    family = LAGRANGE
    initial_condition = 1
  [../]
  [./b]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[Kernels]
  [./da]
    type = TimeDerivative
    variable = a
  [../]
  [./db]
    type = TimeDerivative
    variable = b
  [../]
  [./diffa]
    type = Diffusion
    variable = a
  [../]
  [./diffb]
    type = Diffusion
    variable = b
  [../]
[]

[BCs]
  [./bottom] # arbitrary user-chosen name
    type = DiffusionPBC
    variable = b
    Reactant1 = a
    boundary = 'left' # This must match a named boundary in the mesh file
    Diffusion_coef = 1
    Num = 1
  [../]
[]

[Executioner]
  type = Transient
  start_time = 0
  end_time = 50
  solve_type = 'NEWTON'
  dt = 0.1
  rel_nl_tol = 1e-3
[]

[Outputs]
  execute_on = 'timestep_end'
  exodus = true
[]

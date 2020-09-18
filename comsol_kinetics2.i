[Mesh]
  # 'Dummy' mesh - a mesh is always needed to run MOOSE, but
  # scalar variables do not exist on the mesh.
  type = GeneratedMesh
  dim = 1
  xmin = 0
  xmax = 1
  nx = 1
[]

[Variables]
  # ODE variables
  [./A]
    family = SCALAR
    order = FIRST
    initial_condition = 1
  [../]

  [./B]
    family = SCALAR
    order = FIRST
    initial_condition = 0
  [../]
  [./C]
    family = SCALAR
    order = FIRST
    initial_condition = 0
  [../]
[]

[ScalarKernels]
  # Time derivatives
  [./dA_dt]
    type = ODETimeDerivative
    variable = A
  [../]
  [./dB_dt]
    type = ODETimeDerivative
    variable = B
  [../]
  [./dC_dt]
    type = ODETimeDerivative
    variable = C
  [../]
[]

[ChemicalReactions]
  [./ScalarNetwork]
    species = 'A B C'
    reaction_coefficient_format = 'rate'
    track_rates = True
    reactions = 'A + A -> B             : {1.32*10^19 * exp((-140*10^3)/(8.314*283.15))}
                 B -> C                 : {1.09*10^13 * exp((-90*10^3)/(8.314*283.15))}'
  [../]
[]

[Executioner]
  type = Transient
  start_time = 0
  end_time = 3600
  dt = 0.1
  solve_type = newton
  scheme = crank-nicolson
[]

[Preconditioning]
  [./smp]
    type = SMP
    full = true
  [../]
[]

[Outputs]
  csv = true
  [./console]
    type = Console
    # execute_scalars_on = 'none'
  [../]
[]

[Mesh]
  type = GeneratedMesh
  dim = 2
  xmin = 0
  xmax = 10
  ymin = 0
  ymax = 10
  nx = 15
  ny = 15
[]

[Variables]
  # Name of chemical species
  [./A]
    order = FIRST
    initial_condition = 0
  [../]
  [./B]
    order = FIRST
    initial_condition = 0
  [../]
  [./C]
    order = FIRST
    initial_condition = 0
  [../]
  [./D]
    order = FIRST
    initial_condition = 0
  [../]
[]



[Kernels]
  # dCi/dt
  [./dA_dt]
    type = TimeDerivative
    variable = A
  [../]
  [./dB_dt]
    type = TimeDerivative
    variable = B
  [../]
  [./dC_dt]
    type = TimeDerivative
    variable = C
  [../]
  [./dD_dt]
    type = TimeDerivative
    variable = D
  [../]
 # Diffusion terms
  [./D_A]
    block = 0
    type = CoefDiffusion
    coef = 1
    variable = A
  [../]
  [./D_B]
    block = 0
    type = CoefDiffusion
    coef = 1
    variable = B
  [../]
  [./D_C]
    block = 0
    type = CoefDiffusion
    coef = 1
    variable = C
  [../]
  [./D_D]
    block = 0
    type = CoefDiffusion
    coef = 1
    variable = D
  [../]

[]

[ChemicalReactions]
 [./Network]
   block = 0
   species = 'A B C D'
   reaction_coefficient_format = 'rate'
   track_rates = True
   reactions = 'A -> B : 1
                A -> C : 1
                A + B + C + A -> D : 1
                D -> C : 1'
 [../]
[]

[BCs]
  [./left]
   type = NeumannBC
   variable = A
   boundary = left
   value = 10
  [../]
[]


[Executioner]
  type = Transient
  start_time = 0
  end_time = 100
  dt = 1
  solve_type = newton
  scheme = crank-nicolson
 
  automatic_scaling = true

  petsc_options_iname = '-pc_type -pc_hypre_type'
  petsc_options_value = 'hypre boomeramg'
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

[Mesh]
  # 'Dummy' mesh - a mesh is always needed to run MOOSE, but
  # scalar variables do not exist on the mesh.
  type = GeneratedMesh
  dim = 1
  xmin = 0
  xmax = 9.6198E-8 # unit: m
  nx = 100
[]

[Variables]
  [./phi]
    order = FIRST
    initial_condition = 0
  [../]
  [./A]
    order = FIRST
    initial_condition = 1 # unit: mol/m3
  [../]
  [./B]
    order = FIRST
    initial_condition = 1 # unit: mol/m3
  [../]
  
[]

[Kernels]
  # Time derivatives
  [./dphi_dt]
    type = TimeDerivative
    variable = phi
  [../]
  [./dA_dt]
    type = TimeDerivative
    variable = A
  [../]
  [./dB_dt]
    type = TimeDerivative
    variable = B
  [../]
  # Diffusion Terms
  [./D_A]
    type = CoefDiffusion
    coef = 1e-9 #unit: mol/m2
    variable = A
  [../]
   [./D_B]
    type = CoefDiffusion
    coef = 1e-9 unit: mol/m2
    variable = B
  [../]
  # Electrical Field
  [./EP_C]
    type = ElectricEP
    variable = phi
    CS1 = A
    CS2 = B
    Charge1 = 1 
    Charge2 = -1
  [../]
[]

[ChemicalReactions]
  [./ScalarNetwork]
    species = 'A B C'
    reaction_coefficient_format = 'rate'
    track_rates = True
    reactions = 'A + A -> B             : 0.001
                 B -> C                 : 0.0015'
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

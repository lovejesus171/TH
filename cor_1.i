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
  # Name of chemical species, unit: mol/m3
  [./HS-]
    order = FIRST
    initial_condition = 1
  [../]
[]



[Kernels]
  # dCi/dt
  [./dHS-_dt]
    block = 0
    type = TimeDerivative
    variable = HS-
  [../]
  #Diffusion terms
  [./DgradHS-]
    block = 0
    type = CoefDiffusion
    coef = 5.87E-12
    variable = HS-
  [../]
[]

[ChemicalReactions]
 [./Network]
   block = 0
   species = 'A B C D E F'
   reaction_coefficient_format = 'rate'
   track_rates = True
   reactions = 'A + B  -> C + D  : 0.1
                C + C + D + D -> E + F : 1E-2
                C + D + E + F -> A + B : 0.3
                B + D + E -> F : 0.005                   
                A + B + C + D -> E : 0.5'
 [../]
[]

[BCs]
  [./right]
    type = DirichletBC
    variable = HS-
    boundary = right
    value = 1E-7
  [../]
  [./left]
    type = DirichletBC
    variable = HS-
    boundary = left
    value = 0
  [../]
[]

[Executioner]
  type = Transient
  start_time = 0
  end_time = 100
  solve_type = NEWTON
  dt = 0.1
#  [./TimeStepper]
#    type = IterationAdaptiveDT
#    cutback_factor = 0.9
#    dt = 0.1
#    growth_factor = 1.3
#  [../]
[]

[Preconditioning]
  [./smp]
    type = SMP
    full = true
  [../]
[]

[Postprocessors]
  [./flux_A_at_the_surface]
    type = SideFluxIntegral
    variable = A
    diffusivity = 5e-9
    boundary = left
  [../]
[]

[Outputs]
  exodus = true
[]

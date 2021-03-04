[Mesh]
  file = '2D_Moving.msh'
[]

[Variables]
  # Name of chemical species
  [./A]
    order = FIRST
    initial_condition = 0
  [../]
#  [./B]
#    order = FIRST
#    initial_condition = 0
#  [../]
#  [./C]
#    order = FIRST
#    initial_condition = 0
#  [../]
[]


[Kernels]
  # dCi/dt
  [./dA_dt]
    block = '1 2'
    type = TimeDerivative
    variable = A
  [../]
#  [./dB_dt]
#    block = '1 2'
#    type = TimeDerivative
#    variable = B
#  [../]
#  [./dC_dt]
#    block = '1 2'
#    type = TimeDerivative
#    variable = C
#  [../]
  #Diffusion terms
  [./DgradA1]
    block = '1'
    type = CoefDiffusion
    coef = 5
    variable = A
  [../]
  [./DgradA2]
    block = '2'
    type = CoefDiffusion
    coef = 0.5
    variable = A
  [../]
#  [./DgradB]
#    block = '1 2'
#    type = CoefDiffusion
#    coef = 2e-1
#    variable = B
#  [../]
#  [./DgradC]
#    block = '1 2'
#    type = CoefDiffusion
#    coef = 4e-1
#    variable = C
#  [../]
[]

[UserObjects]
  [./changeid]
    block = '1 2'
    type = ActivateElementsCoupled
    execute_on = timestep_begin
    coupled_var = A
    activate_value = 0.001
    activate_type = above
    active_subdomain_id = 1
    expand_boundary_name = Interface
  [../]
[]


#[ChemicalReactions]
# [./Network]
#   block = '1 2'
#   species = 'A B C'
#   track_rates = false

#   equation_constants = 'Ea R'
#   equation_values = '300 8.314'
#   equation_variables = 'T'

#   reactions = 'A + B  -> C : 1E2'
# [../]
#[]

[BCs]
#  [./right_chemical]
#    type = NeumannBC
#    type = DirichletBC
#    variable = B
#    boundary = right
#    value = 0.01
#  [../]
  [./left_chemical]
    type = NeumannBC
#    type = DirichletBC
    variable = A
    boundary = left
    value = 0.01
  [../]
[]


[Executioner]
  type = Transient
  start_time = 0
  end_time = 3
  solve_type = 'PJFNK'
  dt = 0.1
 
  nl_rel_tol = 0.1

#  [./TimeStepper]
#    type = IterationAdaptiveDT
#    cutback_factor = 0.99
#    dt = 0.1
#    growth_factor = 1.01
#  [../]
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

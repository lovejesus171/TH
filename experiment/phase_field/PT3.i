#
# KKS simple example in the split form
#

[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 100
  ny = 200
  xmax = 20
  ymax = 50
  elem_type = TRI3
[]

[AuxVariables]
  [./Fglobal]
    order = CONSTANT
    family = MONOMIAL
  [../]
[]

[Variables]
  # order parameter
  [./eta]
    order = FIRST
    family = LAGRANGE
    initial_condition = 1
  [../]

  [./c]
    order = FIRST
    family = LAGRANGE
    initial_condition = 1
  [../]
  
  # chemical potential
  [./w]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[BCs]
  [./top_eta]
    type = DirichletBC
    variable = eta
    boundary = 'top'
    value = 0
  [../]
  [./top_c]
    type = DirichletBC
    variable = c
    boundary = 'top'
    value = 0
  [../]
  
[]

[Materials]
  # Free energy of the liquid
  [./f_total]
    type = DerivativeParsedMaterial
    f_name = f_chem
    args = 'c eta'
    material_property_names = 'A csat csolid ww'
    function = 'A*(c-csat/csolid)^2*(-2*eta^3+3*eta^2)+A*(c-csolid/csolid)^2*(1-(-2*eta^3+3*eta^2))+ww*(eta^2*(1-eta)^2)'
  [../]

  # constant properties
  [./constants]
    type = GenericConstantMaterial
    prop_names  = 'A        csat csolid  M           L     kappa       ww'
    prop_values = '5.35e-11 5.1  143     7.94393e-12 2e18  3.00641e-12 2.07889e-12'
  [../]
[]


[Kernels]
  #WBM Model, Cahn-Hilliard Eqaution.
  [./dcdt]
    type = CoupledTimeDerivative
    variable = w
    v = c
  [../]
  [./ckernel]
    type = SplitCHWRes
    mob_name = M
    variable = w
  [../]
  [./chem_pot]
    type = SplitCHParsed
    variable = c
    kappa_name = kappa
    w = w
    f_name = f_chem   
    args = 'eta' 
  [../]
  
  #Allen-Cahn Equation.
  [./deta1dt]
    type = TimeDerivative
    variable = eta
  [../]
  
  [./Interface]
    type = ACInterface
    variable = eta
    kappa_name = kappa
    mob_name = L
  [../]

  [./AC_B]
    type = AllenCahn
    variable = eta
    f_name = f_chem
    mob_name = L
    args = 'c'
  [../]
[]


[Executioner]
  type = Transient
  solve_type = 'PJFNK'

  petsc_options_iname = '-pc_type -sub_pc_type -sub_pc_factor_shift_type'
  petsc_options_value = 'asm      ilu          nonzero'

  l_max_its = 100
  nl_max_its = 100
#  nl_abs_tol = 1e-10
  nl_rel_tol = 1e-1  

  start_time = 0
  end_time = 20
  [./TimeStepper]
   type = IterationAdaptiveDT
   dt = 0.05
   growth_factor = 1.5
   optimal_iterations = 7
  [../]
[]

#
# Precondition using handcoded off-diagonal terms
#
[Preconditioning]
  [./full]
    type = SMP
    full = true
  [../]
[]
[Outputs]
  exodus = true
  console = true
  gnuplot = true
[]

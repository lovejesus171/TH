#
# Ostwald ripening, This model base on the WBM (Equal concentration of the phases at its point.)
#

[Mesh]
  type = GeneratedMesh
  dim = 2
  elem_type = TRI3
  nx = 1000
  ny = 100
  xmin = 0
  xmax = 200e-6
  ymin = 0
  ymax = 200e-6
  
[]

[AuxVariables]
  [./Fglobal]
    order = CONSTANT
    family = MONOMIAL
  [../]
[]

[Variables]
  # Define the concentration
  [./c]
    order = FIRST
    family = LAGRANGE
    initial_condition = 1
  [../]
  # Define the eta
  [./eta]
    order = FIRST
    family = LAGRANGE
    initial_condition = 1
  [../]
  # Define the chemical potential to avoid the 4th order differentiation in the residual calculation.
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
    boundary = top
    value = 0
  [../]
  [./topcs]
    type = DirichletBC
    variable = cs
    boundary = top
    value = 0
  [../]
[]

[Kernels]
  #Cahn-Hilliard Eqaution.
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
    kappa_name = kappa_c
    w = w
    f_name = fc  
  [../]
  
  #Allen-Cahn Equation.
  [./deta_1dt]
    type = TimeDerivative
    variable = eta
  [../]
  
  [./Interface_1]
    type = ACInterface
    variable = eta
    kappa_name = kappa_c
  [../]

  [./AC_B_1]
    type = AllenCahn
    variable = eta
    f_name = fa
    mob_name = L
    args = 'eta c'
  [../]


[]

[Materials]
   #for the Allen-Cahn
  [./f_namea]
    type = DerivativeParsedMaterial
    f_name = fa
    material_property_names = 'A cle cse'
    args = 'c eta'
    function = '(-2*eta^3+3*eta^2)*csolid*A*(c+(-2*eta^3+3*eta^2-1)*(cle-cse))^2+(1+2*eta^3-3*eta^2)*csat*A*(c+(-2*eta^3+3*eta^2)*(cle-cse))^2+w*eta^2*(1-eta)^2'
  [../]
   #for the Cahn-Hilliard
  [./f_namec]
    type = DerivativeParsedMaterial
    f_name = fc
    material_property_names = 'A cle cse'
    args = 'c eta'
    function = '(-2*eta^3+3*eta^2)*A*(c+(-2*eta^3+3*eta^2-1)*(cle-cse))^2+(1+2*eta^3-3*eta^2)*A*(c+(-2*eta^3+3*eta^2)*(cle-cse))^2+w*eta^2*(1-eta)^2'
  [../]


  [./switch1]
    type = SwitchingFunctionMaterial
    function_name = h
    eta = eta
    h_order = SIMPLE
  [../]

  [./barr1]
    type = BarrierFunctionMaterial
    function_name = g
    eta = eta
    h_order = SIMPLE
  [../]

  # constant properties
  [./constants]
    type = GenericConstantMaterial
    prop_names  = 'M            L kappa_eta  kappa_c   w           alpha     A       cse  cle      csolid csat'
    prop_values = '7.94393e-18  2 3.00641e-6 0         2078893.937 5.35e7  1    0.03566  143000 5100'
  [../]
[]

[Executioner]
  type = Transient
  solve_type = 'PJFNK'

  petsc_options_iname = '-pc_type -sub_pc_type -sub_pc_factor_shift_type'
  petsc_options_value = 'asm      ilu          nonzero'

  l_max_its = 100
  nl_max_its = 100
  nl_abs_tol = 1e-10
  
  start_time = 0
  end_time = 10
  [./TimeStepper]
   type = IterationAdaptiveDT
   dt = 0.05
   growth_factor = 1.3
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

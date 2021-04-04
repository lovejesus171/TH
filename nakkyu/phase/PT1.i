#
# KKS simple example in the split form
#

[Mesh]
  type = GeneratedMesh
  dim = 1
#  nx = 10
  ny = 200
#  xmax = 10
  ymax = 1000
#  elem_type = TRI3
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
    initial_conditions = 1
  [../]

  [./c]
    order = FIRST
    family = LAGRANGE
    initial_conditions = 1
  [../]

  # chemical potential
  [./w]
    order = FIRST
    family = LAGRANGE
  [../]

  # Electrolyte concentration
  [./cl]
    order = FIRST
    family = LAGRANGE
  [../]
  # Solid concentration
  [./cs]
    order = FIRST
    family = LAGRANGE
  [../]
[]

#[ICs]
#  [./IC_c]
#    type = BoundingBoxIC
#    variable = c
#    x1 = 0
#    x2 = 100
#    y1 = 0
#    y2 = 200
#    inside = 1
#    outside = 0
#  [../]
#
#  [./IC_eta]
#    type = BoundingBoxIC
#    variable = eta
#    x1 = 0
#    x2 = 100
#    y1 = 0
#    y2 = 200
#    inside = 1
#    outside = 0
#  [../]
#[]


[BCs]
  [./top_eta]
    type = DirichletBC
    variable = eta
    boundary = 'right'
    value = 0
  [../]
  [./top_c]
    type = DirichletBC
    variable = c
    boundary = 'right'
    value = 1
  [../]
  
[]

[Materials]
  # Free energy of the liquid
  [./fl]
    type = DerivativeParsedMaterial
    f_name = fl
    args = 'cl'
    material_property_names = 'A csat csolid'
    function = 'A*(cl-csat)^2'
  [../]

  # Free energy of the solid
  [./fs]
    type = DerivativeParsedMaterial
    f_name = fs
    args = 'cs'
    material_property_names = 'A csolid'
    function = 'A*(cs-csolid)^2'
  [../]

  # h(eta)
  [./h_eta]
    type = SwitchingFunctionMaterial
    h_order = SIMPLE # h(eta) SIMPLE is -2*eta^3+3*eta^2
    eta = eta
  [../]

  # g(eta)
  [./g_eta]
    type = BarrierFunctionMaterial
    g_order = SIMPLE #g(eta) SIMPLE is eta^2*(1-eta)^2
    eta = eta
  [../]

  # constant properties
  [./constants]
    type = GenericConstantMaterial
    prop_names  = 'A          csat csolid  M           L     kappa_phi'
    prop_values = '2.38839e-9 5.1  143     1.77944e11  2e18  3.00641e-12'
  [../]
[]

[Kernels]
  # enforce c = (1-h(eta))*cl + h(eta)*cs, Hence this kernel calculate the concentration(c) from interpolation from cs and cl
  [./PhaseConc]
    type = KKSPhaseConcentration
    variable = cs
    ca       = cl
    c        = c
    eta      = eta
  [../]

  # enforce pointwise equality of chemical potentials
  # This kernel use one of KKS Model principle: dFa/dca = dFb/dcb, equality of phase chemical potential
  [./ChemPotSolute]
    type = KKSPhaseChemicalPotential
    variable = cl
    cb       = cs
    fa_name  = fl
    fb_name  = fs
  [../]

  #
  # Cahn-Hilliard Equation
  #
  [./CHBulk]
    type = KKSSplitCHCRes
    variable = c
    ca       = cl
    cb       = cs
    fa_name  = fl
    fb_name  = fs
    w        = w #Name of chemical potential
  [../]

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

  #
  # Allen-Cahn Equation
  #
  ##This part calculates the local free energy only
  [./ACBulkF]
    type = KKSACBulkF
    variable = eta
    w        = 2.07889e-12 #Double well height parameter
    g_name = g
    fa_name = fl
    fb_name = fs
    args = 'cl cs'
  [../]
  [./ACBulkC]
    type = KKSACBulkC
    variable = eta
    ca       = cl
    cb       = cs
    fa_name  = fl
    fb_name  = fs
  [../]
  #This part calculates the remain terms
  [./ACInterface]
    type = ACInterface
    variable = eta
    kappa_name = kappa_phi
  [../]
  [./detadt]
    type = TimeDerivative
    variable = eta
  [../]
[]


[Executioner]
  type = Transient
  solve_type = 'PJFNK'

  petsc_options_iname = '-pc_type -sub_pc_type -sub_pc_factor_shift_type'
  petsc_options_value = 'asm      ilu          nonzero'

  l_max_its = 100
  nl_max_its = 100
#  nl_abs_tol = 1e-22
  nl_rel_tol = 1e-2

  start_time = 0
  end_time = 0.005
  dt = 1e-5
#  [./TimeStepper]
#   type = IterationAdaptiveDT
#   dt = 1e-5
##   growth_factor = 1.5
#   optimal_iterations = 7
#  [../]
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

#
# KKS corrosion trial
#

[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 1000
  ny = 5
  xmax = 50
  ymax = 5
#  elem_type = QUAD4
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

  # solid phase concentration (metal)
  [./cs]
    order = FIRST
    family = LAGRANGE
  [../]
  # liquid phase concentration (electrolyte)
  [./cl]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[BCs]
    [./right_c]
      type = DirichletBC
      variable = 'c'
      boundary = 'right'
      value = 0
    [../]
    [./right_eta]
      type = DirichletBC
      variable = 'eta'
      boundary = 'right'
      value = 0
    [../]
[]

[Materials]
  # Free energy of the liquid
  [./fl]
    type = DerivativeParsedMaterial
    f_name = fl
    args = 'cl'
    function = '(cl-0.036)^2'
  [../]

  # Free energy of the metal
  [./fs]
    type = DerivativeParsedMaterial
    f_name = fs
    args = 'cs'
    function = '(cs-1)^2'
  [../]

  # h(eta)
  [./h_eta]
    type = SwitchingFunctionMaterial
    h_order = SIMPLE
    eta = eta
  [../]

  # g(eta)
  [./g_eta]
    type = BarrierFunctionMaterial
    g_order = SIMPLE
    eta = eta
  [../]

  # constant properties
  [./constants]
    type = GenericConstantMaterial
    prop_names  = 'M   L   kappa'
    prop_values = '0.7 0.7 0.4  '
  [../]
[]

[Kernels]
  # full transient
  active = 'PhaseConc ChemPotVacancies CHBulk ACBulkF ACBulkC ACInterface dcdt detadt ckernel'

  # enforce c = (1-h(eta))*cm + h(eta)*cd
  [./PhaseConc]
    type = KKSPhaseConcentration
    ca       = cs
    variable = cl
    c        = c
    eta      = eta
  [../]

  # enforce pointwise equality of chemical potentials
  [./ChemPotVacancies]
    type = KKSPhaseChemicalPotential
    variable = cs
    cb       = cl
    fa_name  = fs
    fb_name  = fl
  [../]

  #
  # Cahn-Hilliard Equation
  #
  [./CHBulk]
    type = KKSSplitCHCRes
    variable = c
    ca       = cs
    cb       = cl
    fa_name  = fs
    fb_name  = fl
    w        = w
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
  [./ACBulkF]
    type = KKSACBulkF
    variable = eta
    fa_name  = fs
    fb_name  = fl
    args     = 'cs cl'
    w        = 0.4
  [../]
  [./ACBulkC]
    type = KKSACBulkC
    variable = eta
    ca       = cs
    cb       = cl
    fa_name  = fs
    fb_name  = fl
  [../]
  [./ACInterface]
    type = ACInterface
    variable = eta
    kappa_name = kappa
  [../]
  [./detadt]
    type = TimeDerivative
    variable = eta
  [../]
[]

[AuxKernels]
  [./GlobalFreeEnergy]
    variable = Fglobal
    type = KKSGlobalFreeEnergy
    fa_name = fs
    fb_name = fl
    w = 0.4
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
  nl_rel_tol =1e-3 
  start_time = 0
  end_time = 3
  [./TimeStepper]
   type = IterationAdaptiveDT
   dt = 1e-3
   growth_factor = 1.3
   optimal_iterations = 7
  [../]
  [./Adaptivity]
    coarsen_fraction = 0.1
    refine_fraction = 0.7
    max_h_level = 2
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
  file_base = kks_corrosion_trials
  exodus = true
[]

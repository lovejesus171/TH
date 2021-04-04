[Mesh]
  type = GeneratedMesh
  dim = 2
  elem_type = QUAD4
  nx = 5
  ny = 500
  nz = 0
  xmin = 0
  xmax = 50e-6
  ymin = 0
  ymax = 200e-6
  zmin = 0
  zmax = 0
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

  # hydrogen concentration
  [./c]
    order = FIRST
    family = LAGRANGE
  [../]

  # chemical potential
  [./w]
    order = FIRST
    family = LAGRANGE
  [../]

  # Liquid phase solute concentration
  [./cl]
    order = FIRST
    family = LAGRANGE
  [../]
  # Solid phase solute concentration
  [./cs]
    order = FIRST
    family = LAGRANGE
    initial_condition = 1
  [../]
[]

[BCs]
  [./top_c]
    type = DirichletBC
    variable = 'c'
    boundary = 'top'
    value = 0
  [../]
  [./top_eta]
    type = DirichletBC
    variable = 'eta'
    boundary = 'top'
    value = 0
  [../]
[]

[Materials]
  # Free energy of the liquid
  [./fl]
    type = DerivativeParsedMaterial
    f_name = fl
    args = 'cl'
    material_property_names = 'A csat csolid'
    function = 'A*csat*(cl-csat/csolid)^2'
  [../]

  # Free energy of the solid
  [./fs]
    type = DerivativeParsedMaterial
    f_name = fs
    args = 'cs'
    material_property_names = 'A csat csolid'
    function = 'A*csolid*(cs-csolid/csolid)^2'
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
    prop_names  = 'Ms          Ml            L   kappa_phi    A      csat    csolid eps_sq'
    prop_values = '5.55519e-23 1.557631e-21  2   3.00641e-6   5.35e7 143000  5100 0.4'
  [../]
  
  [./Mobility_M]
    type = DerivativeParsedMaterial
    f_name = M
    args = 'eta'
    constant_property_names = 'Ms Ml'
    function = '5.55519e-23*(eta * eta *(-2 * eta + 3))+(1-(eta * eta * (-2 * eta +3)))*1.557631e-21'
  [../]
[]

[Kernels]
  # enforce c = (1-h(eta))*cl + h(eta)*cs
  [./PhaseConc]
    type = KKSPhaseConcentration
    ca       = cl
    variable = cs
    c        = c
    eta      = eta
  [../]

  # enforce pointwise equality of chemical potentials
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
    fa_name  = fl
    fb_name  = fs
    w        = 2078893.937
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
  [./ACInterface]
    type = ACInterface
    variable = eta
    kappa_name = eps_sq
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
    fa_name = fl
    fb_name = fs
    w = 2078893.937
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
  nl_rel_tol = 1e-2  

  end_time = 800
  dt = 1e-3
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

[Postprocessors]
  [./dofs]
    type = NumDOFs
  [../]
#  [./integral]
#    type = ElementL2Error
#    variable = eta
#    function = ic_func_eta
#  [../]
[]

[Outputs]
  exodus = true
  console = true
  gnuplot = true
[]

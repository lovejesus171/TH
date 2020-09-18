#
# Ostwald ripening, This model base on the WBM (Equal concentration of the phases at its point.)
#

[Mesh]
  type = GeneratedMesh
  dim = 2
  elem_type = TRI3
  nx = 100
  ny = 100
  xmin = 0
  xmax = 200
  ymin = 0
  ymax = 200
  
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
  [../]
  # Define the 4 different etas
  [./eta_1]
    order = FIRST
    family = LAGRANGE
  [../]
  [./eta_2]
    order = FIRST
    family = LAGRANGE
  [../]
  [./eta_3]
    order = FIRST
    family = LAGRANGE
  [../]
  [./eta_4]
    order = FIRST
    family = LAGRANGE
  [../]
  # Define the chemical potential to avoid the 4th order differentiation in the residual calculation.
  # chemical potential
  [./w]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[ICs]
  # Initial condition of the concentration
  [./IC_c]
    type = FunctionIC
    variable = c
    function = '0.5+0.01*(cos(0.105*x)*cos(0.11*y)+(cos(0.13*x)*cos(0.087*y))^2+cos(0.025*x-0.15*y)*cos(0.07*x-0.02*y))'
  [../]
  # Initial conditions of the etas
  [./IC_eta_1]
    type = FunctionIC
    variable = eta_1
    function = '0.1*(cos(0.01*1*x-4)*cos((0.007+0.01*1)*y)+cos((0.11+0.01*1)*x)*cos((0.11+0.01*1)*y)+1.5*(cos((0.046+0.001*1)*x+(0.0405+0.001*1)*y)*cos((0.031+0.001*1)*x-(0.004+0.001*1)*y))^2)^2'
  [../]
  [./IC_eta_2]
    type = FunctionIC
    variable = eta_2
    function = '0.1*(cos(0.01*2*x-4)*cos((0.007+0.01*2)*y)+cos((0.11+0.01*2)*x)*cos((0.11+0.01*2)*y)+1.5*(cos((0.046+0.001*2)*x+(0.0405+0.001*2)*y)*cos((0.031+0.001*2)*x-(0.004+0.001*2)*y))^2)^2'
  [../]
  [./IC_eta_3]
    type = FunctionIC
    variable = eta_3
    function = '0.1*(cos(0.01*3*x-4)*cos((0.007+0.01*3)*y)+cos((0.11+0.01*3)*x)*cos((0.11+0.01*3)*y)+1.5*(cos((0.046+0.001*3)*x+(0.0405+0.001*3)*y)*cos((0.031+0.001*3)*x-(0.004+0.001*3)*y))^2)^2'
  [../]
  [./IC_eta_4]
    type = FunctionIC
    variable = eta_4
    function = '0.1*(cos(0.01*4*x-4)*cos((0.007+0.01*4)*y)+cos((0.11+0.01*4)*x)*cos((0.11+0.01*4)*y)+1.5*(cos((0.046+0.001*4)*x+(0.0405+0.001*4)*y)*cos((0.031+0.001*4)*x-(0.004+0.001*4)*y))^2)^2'
  [../]
[]


[BCs]
# No flux conditions = Neumann boundary condition with zero flux.
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
  [../]
  
  #Allen-Cahn Equation.
  [./deta_1dt]
    type = TimeDerivative
    variable = eta_1
  [../]
  [./deta_2dt]
    type = TimeDerivative
    variable = eta_2
  [../]
  [./deta_3dt]
    type = TimeDerivative
    variable = eta_3
  [../]
  [./deta_4dt]
    type = TimeDerivative
    variable = eta_4
  [../]
  
  [./Interface_1]
    type = ACInterface
    variable = eta_1
    kappa_name = kappa
    mob_name = L
  [../]
  [./Interface_2]
    type = ACInterface
    variable = eta_2
    kappa_name = kappa
    mob_name = L
  [../]
  [./Interface_3]
    type = ACInterface
    variable = eta_3
    kappa_name = kappa
    mob_name = L
  [../]
  [./Interface_4]
    type = ACInterface
    variable = eta_4
    kappa_name = kappa
    mob_name = L
  [../]

  [./AC_B_1]
    type = AllenCahn
    variable = eta_1
    f_name = f_chem
    mob_name = L
    args = 'eta_2 eta_3 eta_4 c'
  [../]
  [./AC_B_2]
    type = AllenCahn
    variable = eta_2
    f_name = f_chem
    mob_name = L
    args = 'eta_1 eta_3 eta_4 c'
  [../]
  [./AC_B_3]
    type = AllenCahn
    variable = eta_3
    f_name = f_chem
    mob_name = L
    args = 'eta_1 eta_2 eta_4 c'
  [../]
  [./AC_B_4]
    type = AllenCahn
    variable = eta_4
    f_name = f_chem
    mob_name = L
   args = 'eta_1 eta_2 eta_3 c'
  [../]
[]

[Materials]
  [./falpha]
    type = DerivativeParsedMaterial
    f_name = fa
    material_property_names = 'curvature_c ca'
    args = 'c'
    function = 'curvature_c^2*(c-ca)^2'
  [../]
  [./fbeta]
    type = DerivativeParsedMaterial
    f_name = fb
    material_property_names = 'curvature_c cb'
    args = 'c'
    function = 'curvature_c^2*(cb-c)^2'
  [../]

  [./switch1]
    type = SwitchingFunctionMaterial
    function_name = h1
    eta = eta_1
    h_order = HIGH
  [../]
  [./switch2]
    type = SwitchingFunctionMaterial
    function_name = h2
    eta = eta_2
    h_order = HIGH
  [../]
  [./switch3]
    type = SwitchingFunctionMaterial
    function_name = h3
    eta = eta_3
    h_order = HIGH
  [../]
    [./switch4]
    type = SwitchingFunctionMaterial
    function_name = h4
    eta = eta_4
    h_order = HIGH
  [../]

  [./barr1]
    type = BarrierFunctionMaterial
    function_name = g1
    eta = eta_1
    h_order = HIGH
  [../]
  [./barr2]
    type = BarrierFunctionMaterial
    function_name = g2
    eta = eta_2
    h_order = HIGH
  [../]
  [./barr3]
    type = BarrierFunctionMaterial
    function_name = g3
    eta = eta_3
    h_order = HIGH
  [../]
  [./barr4]
    type = BarrierFunctionMaterial
    function_name = g4
    eta = eta_4
    h_order = HIGH
  [../]


  # constant properties
  [./constants]
    type = GenericConstantMaterial
    prop_names  = 'M L kappa w alpha curvature_c ca  cb'
    prop_values = '5 5 3     1 5     1.414214    0.3 0.7'
  [../]

  [./fchem]
   type = DerivativeParsedMaterial
   f_name = f_chem
   function = 'fa*(1-(h1+h2+h3+h4))+fb*(1-(h1+h2+h3+h4))+w*(g1+g2+g3+g4+2*alpha*((eta_1*eta_2)^2+(eta_1*eta_3)^2+(eta_1*eta_4)^2+(eta_2*eta_3)^2+(eta_2*eta_4)^2)+(eta_3*eta_4)^2)'
   args = 'eta_1 eta_2 eta_3 eta_4 c'
   material_property_names = 'curvature_c ca fa fb h1 h2 h3 h4 g1 g2 g3 g4 w alpha'
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
   dt = 1E-9
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

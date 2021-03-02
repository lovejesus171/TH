[Mesh]
  # 'Dummy' mesh - a mesh is always needed to run MOOSE, but
  # scalar variables do not exist on the mesh.
  type = GeneratedMesh
  dim = 2
  xmax = 10
  xmin = 0
  ymax = 10
  ymin = 0
  nx = 1
  ny = 1
[]

[Variables]
  # Name of chemical species
  # Chemical Species: roh ren rhcl ibu pd1 pd2 pd3 pd4 H+ H2O Cl- CO CO2 ester
  [./roh]
    order = FIRST
    initial_condition = 1.23
  [../]
  [./ren]
    order = FIRST
    initial_condition = 0
  [../]
  [./rhcl]
    order = FIRST
    initial_condition = 0
  [../]
  [./B]
    order = FIRST
    initial_condition = 0.1
  [../]
  [./ibu]
    order = FIRST
    initial_condition = 0
  [../]
  [./pd1]
    order = FIRST
    initial_condition = 0.0121
  [../]
  [./pd2]
    order = FIRST
    initial_condition = 0
  [../]
  [./pd3]
    order = FIRST
    initial_condition = 0
  [../]
  [./pd4]
    order = FIRST
    initial_condition = 0
  [../]
  [./H+]
    order = FIRST
    initial_condition = 0.2
  [../]
  [./H2O]
    order = FIRST
    initial_condition = 3
  [../]
  [./Cl-]
    order = FIRST
    initial_condition = 0.2
  [../]
  [./CO]
    order = FIRST
    initial_condition = 1.1
  [../]
  [./CO2]
    order = FIRST
    initial_condition = 0
  [../]
  [./ester]
    order = FIRST
    initial_condition = 0
  [../]
[]

[Kernels]
  # Name of chemical species
  # Chemical Species: roh ren rhcl ibu pd1 pd2 pd3 pd4 H+ H2O Cl- CO CO2 ester
  # dCi/dt
  [./droh_dt]
    type = TimeDerivative
    variable = roh
  [../]
  [./dren_dt]
    type = TimeDerivative
    variable = ren
  [../]
  [./dB_dt]
    type = TimeDerivative
    variable = B
  [../]
  [./drhcl_dt]
    type = TimeDerivative
    variable = rhcl
  [../]
  [./dibu_dt]
    type = TimeDerivative
    variable = ibu
  [../]
  [./dpd1_dt]
    type = TimeDerivative
    variable = pd1
  [../]
  [./dpd2_dt]
    type = TimeDerivative
    variable = pd2
  [../]
  [./dpd3_dt]
    type = TimeDerivative
    variable = pd3
  [../]
  [./dpd4_dt]
    type = TimeDerivative
    variable = pd4
  [../]
  [./dH+_dt]
    type = TimeDerivative
    variable = H+
  [../]
  [./dH2O_dt]
    type = TimeDerivative
    variable = H2O
  [../]
  [./dCl-_dt]
    type = TimeDerivative
    variable = Cl-
  [../]
  [./dCO_dt]
    type = TimeDerivative
    variable = CO
  [../]
  [./dCO2_dt]
    type = TimeDerivative
    variable = CO2
  [../]
  [./dester_dt]
    type = TimeDerivative
    variable = ester
  [../]
[]

[ChemicalReactions]
  [./Network]
    species = 'roh ren rhcl ibu pd1 pd2 pd3 pd4 H+ H2O Cl- CO CO2 B ester '
    reaction_coefficient_format = 'rate'
    track_rates = True
   #Track the production rates for each reaction
    reactions = 'roh + H+ -> ren + H2O + H+ : 0.00745
                ren + H+ + Cl- -> rhcl : 0.0125
                rhcl + B -> ren + H+ + Cl- + B : 0.0016
                pd1 + CO + H2O -> pd2 + Cl- + CO2 + H+ + H+ : 0.15
                pd2 + rhcl -> pd3 : 1.59
                pd3 + CO -> pd4 + Cl- : 0.214
                pd4 + H2O -> ibu + H+ + pd2 : 0.952
                roh + ibu + H+ -> ester + H+ + H2O : 0.5
                ester + H+ H2O -> roh + ibu + H+ : 0.01'
    block = 0
  [../]
[]

[Executioner]
  type = Transient
  end_time = 4e+4
  dtmin = 1e-15
  solve_type = NEWTON
  scheme = crank-nicolson
  petsc_options_iname = '-pc_type -pc_hypre_type'
  petsc_options_value = 'hypre  boomeramg'  

  [./TimeStepper]
    type = IterationAdaptiveDT
    cutback_factor = 0.9
    dt = 0.1
    growth_factor = 1.1
  [../]
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

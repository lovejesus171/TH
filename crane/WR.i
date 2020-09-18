# Chemical Kinetics example

# Effect of Molecular Hedrogen on Hydrogen Peroxide in Water Radiolysis

# Barbara Pastina and Jay A. LaVerne

# June 14, 2001

 

[Mesh]
type = GeneratedMesh
dim = 2
xmin = 0
xmax = 10
ymin = 0
ymax = 10
nx = 10
ny = 10
[]

 

# Chemical Species: H2O H2O2 OH HO2 H H+ OH- HO2- e O- O2- O2 O3- O3 H2 HO3

 

 [Variables]
  [./H2O]
   order = FIRST
   initial_condition = 55.342 
  [../]
  [./H2O2]
   order = FIRST
   initial_condition = 0
  [../]
  [./OH]
   order = FIRST
   initial_condition = 0
  [../]
  [./HO2]
   order = FIRST
   initial_condition = 0
  [../]
  [./H]
   order = FIRST
   initial_condition = 0
  [../]

 

[./H+]

order = FIRST

initial_condition = 0.000000316

[../]

 

[./OH-]

order = FIRST

initial_condition = 0.0000000316

[../]

 

[./HO2-]
order = FIRST

initial_condition = 0

[../]

 

[./e]
order = FIRST

initial_condition = 0

[../]

 

[./O-]
order = FIRST

initial_condition = 0

[../]

 

[./O2-]
order = FIRST

initial_condition = 0

[../]

 

[./O2]
order = FIRST

initial_condition = 0

[../]

 

[./O3-]
order = FIRST

initial_condition = 0

[../]

 

[./O3]
order = FIRST

initial_condition = 0

[../]

 

[./H2]
order = FIRST

initial_condition = 0

[../]

 

[./HO3]
order = FIRST

initial_condition = 0

[../]

[]

 

[Kernels]

[./dH2O_dt]

type = TimeDerivative

variable = H2O

[../]

 

[./dH2O2_dt]

type = TimeDerivative

variable = H2O2

[../]

 

[./dOH_dt]

type = TimeDerivative

variable = OH

[../]

 

[./dHO2_dt]

type = TimeDerivative

variable = HO2

[../]

 

[./dH_dt]

type = TimeDerivative

variable = H

[../]

 

[./dH+_dt]

type = TimeDerivative

variable = H+

[../]

 

[./dOH-_dt]

type = TimeDerivative

variable = OH-

[../]

 

[./dHO2-_dt]

type = TimeDerivative

variable = HO2-

[../]

 

[./de_dt]

type = TimeDerivative

variable = e

[../]

 

[./dO-_dt]

type = TimeDerivative

variable = O-

[../]

 

[./dO2-_dt]

type = TimeDerivative

variable = O2-

[../]

 

[./dO3-_dt]

type = TimeDerivative

variable = O3-

[../]

 

[./dO3_dt]

type = TimeDerivative

variable = O3

[../]

 

[./dH2_dt]

type = TimeDerivative

variable = H2

[../]

 

[./dHO3_dt]

type = TimeDerivative

variable = HO3

[../]

[]

 

[ChemicalReactions]

[./Network]
block = 0
species = 'H2O H2O2 OH HO2 H H+ OH- HO2- e O- O2- O2 O3- O3 H2 HO3'

reactions ='H2O -> H : 1.1039e+19

H2O -> H2 : 9.03194e+19

H2O -> H2O2 : 1.40497e+19

H2O -> H+ : 5.31881e+19

H2O -> OH : 5.41916e+19

H2O -> e : 5.31881e+19

H+ + OH- -> H2O : 1.4e+11

H2O -> H+ + OH- : 1.4e-3

H2O2 -> H+ + HO2- : 5e-1.65

H+ + HO2- -> H2O2 : 5e+10

H2O2 + OH- -> HO2- + H2O : 1.3e+10

HO2- + H2O -> H2O2 + OH- : 1.3e+7.65

e + H2O -> H + OH- : 1.9e+1

H + OH- -> e + H2O : 2.2e+7

H -> e + H+ : 2.3e+0.33

e + H+ -> H : 2.3e+10

OH + OH- -> O- + H2O : 1.3e+10

O- + H2O -> OH + OH- : 1.3e+7.9

OH -> O- + H+ : 1e-0.9

O- + H+ -> OH : 1e+11

HO2 -> O2- + H+ : 5e+5.43

O2- + H+ -> HO2 : 5e+10

HO2 + OH- -> O2- + H2O : 5e+10

O2- + H2O -> HO2 + OH- : 5e+0.57

e + OH -> OH- : 3e+10

e + H2O2 -> OH + OH- : 1.1e+10

e + O2- + H2O -> HO2- + OH-: 1.3e+10

e + HO2 -> HO2- : 2e+10

e + O2 -> O2- : 1.9e+10

e + H2O + e + H2O -> OH- + H2 + OH- : 5.5e+9

e + H + H2O -> H2 + OH- : 2.5e+10

e + HO2- -> O- + OH- : 3.5e+9

e + O- + H2O -> OH- + OH- : 2.2e+10

e + O3- + H2O -> O2 + OH- + OH- : 1.6e+10

e + O3 -> O3- : 3.6e+10

H + H2O -> H2 + OH : 1.1e+1

H + O- -> OH- : 1e+10

H + HO2- -> OH + OH- : 9e+7

H + O3- -> OH- + O2 : 1e+10

H + H -> H2 : 7.8e+9

H + OH -> H2O : 7e+9

H + H2O2 -> OH + H2O : 9e+7

H + O2 -> HO2 : 2.1e+10

H + HO2 -> H2O2 : 1.8e+10

H + O2- -> HO2- : 1.8e+10

H + O3 -> HO3 : 3.8e+10

OH + OH -> H2O2 : 3.6e+9

OH + HO2 -> H2O + O2 : 6e+9

OH + O2- -> OH- + O2 : 8.2e+9

OH + H2 -> H + H2O : 4.3e+7

OH + H2O2 -> HO2 + H2O : 2.7e+7

OH + O- -> HO2- : 2.5e+10

OH + HO2- -> HO2 + OH- : 7.5e+9

OH + O3- -> O3 + OH- : 2.6e+9

OH + O3- -> O2- + O2- + H+ : 6e+9

OH + O3 -> HO2 + O2 : 1.1e+8

HO2 + O2- -> HO2- + O2 : 8e+7

HO2 + HO2 -> H2O2 + O2 : 7e+5

HO2 + O- -> O2 + OH- : 6e+9

HO2 + H2O2 -> OH + O2 + H2O : 5e-1

HO2 + HO2- -> OH + O2 + OH- : 5e-1

HO2 + O3- -> O2 + O2 + OH- : 6e+9

HO2 + O3 -> HO3 + O2 : 5e+8

O2- + O2- + H2O + H2O -> H2O2 + O2 + OH- + OH-: 5e+1

O2- + O- + H2O -> O2 + OH- + OH-: 6e+8

O2- + H2O2 -> OH + O2 + OH-: 1.3e-1

O2- + HO2- -> O- + O2 + OH-: 1.3e-1

O2- + O3- + H2O -> O2 + O2 + OH- + OH-: 1e+4

O2- + O3 -> O3- + O2 : 1.5e+9

O- + O- + H2O -> HO2- + OH-: 1e+9

O- + O2 -> O3- : 3.6e+9

O- + H2 -> H + OH- : 8e+7

O- + H2O2 -> O2- + H2O : 5e+8

O- + HO2- -> O2- + OH- : 4e+8

O- + O3- -> O2- + O2- : 7e+8

O- + O3 -> O2- + O2 : 5e+9

O3- -> O2 + O- : 3.3e+3

O3- + H+ -> O2 + OH : 9e+10

HO3 -> O2 + OH : 1.1e+5 '

[../]

[]

 

 

[Executioner]
 type = Transient
 start_time = 1
 end_time = 1e+4
 solve_type = PJFNK
 dtmin = 1e-40
 dtmax = 10
 automatic_scaling = true

  petsc_options_iname = '-pc-type -pc_hypre_type'
  petsc_options_value = 'hypre boomeramg'

 [./TimeStepper]
  type = IterationAdaptiveDT
  cutback_factor = 0.9
  dt = 1e-37
  growth_factor = 1.01
 [../]

[]

#[Preconditioning]
#  [./smp]
#   type = SMP
#   full = true
#  [../]
#[]
 
 

[Outputs]

exodus = true

[]

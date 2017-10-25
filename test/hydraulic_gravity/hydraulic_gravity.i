[Mesh]
  type = GeneratedMesh
  dim = 3
  nx = 10
  ny = 10
  nz = 10
[]

[UserObjects]
  [./water_uo]
    type = TigerFluidConst     
  [../]
  [./rock_uo]
    type =  TigerPermeabilityRockConst
  [../]
[]

[Materials]
  [./water]
    type = TigerFluidMaterialTP
    pressure = 1.0e6
    temperature = 100.0
    fp_UO = water_uo
  [../]
  [./rock]
    type = TigerRockMaterial
    has_gravity = true
    gravity_acceleration = 9.81
    compressibility = 1.0e-9
    permeability_type = isotropic
    k0 = '1.0e-10'
    porosity = 0.4
    kf_UO = rock_uo
  [../]
[]

[BCs]
  [./front]
    type =  DirichletBC
    variable = pressure
    boundary = 'front'
    value = 0
  [../]
  #[./back]
  #  type =  DirichletBC
  #  variable = pressure
  #  boundary = 'back'
  #  value = 9810.0
  #[../]
[]

[AuxVariables]
  [./vx]
    family = MONOMIAL
    order = CONSTANT
  [../]
  [./vy]
    family = MONOMIAL
    order = CONSTANT
  [../]
  [./vz]
    family = MONOMIAL
    order = CONSTANT
  [../]
[]

[AuxKernels]
  [./vx_ker]
    type = TigerDarcyVelocityComponent
    gradient_variable = pressure
    variable =  vx
    component = x
  [../]
  [./vy_ker]
    type = TigerDarcyVelocityComponent
    gradient_variable = pressure
    variable =  vy
    component = y
  [../]
  [./vz_ker]
    type = TigerDarcyVelocityComponent
    gradient_variable = pressure
    variable =  vz
    component = z
  [../]
[]

[Variables]
  [./pressure]
  [../]
[]

[Kernels]
  [./diff]
    type = TigerKernelH
    variable = pressure
  [../]
  [./time]
    type = TimeDerivative
    variable = pressure
  [../]
[]

[Executioner]
  type = Transient
  dt = 0.01
  end_time = 1.2
  l_tol = 1e-10 #difference between first and last linear step
  nl_rel_step_tol = 1e-14 #machine percision
  solve_type = 'PJFNK'
  petsc_options_iname = '-pc_type -pc_hypre_type'
  petsc_options_value = 'hypre boomeramg'
[]

[Outputs]
  exodus = true
[]

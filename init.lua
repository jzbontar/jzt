require 'libjzt'
require 'nn'
require 'torch'
require 'cutorch'

include('util.lua')

include('Linear.lua')
include('Tanh.lua')
include('SpatialConvolution1.lua')
include('StereoJoin.lua')

include('ClassNLLCriterion.lua')
include('L1Cost.lua')
include('MSECost.lua')
include('HuberCost.lua')
include('KLDivergence.lua')

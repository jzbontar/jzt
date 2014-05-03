require 'Test'
require 'jzt'
require 'nn'
require 'image'
require 'cunn'
require 'prof-torch'

test = {}
function test.Linear()
   A = torch.CudaTensor(5, 3):normal()
   
   module = jzt.Linear(3, 4)
   print(testJacobian(module, A))
   print(testJacobianParameters(module, A))
end

function test.LinearTanh()
   A = torch.CudaTensor(5, 3):normal()

   net = nn.Sequential()
   net:add(jzt.Linear(3, 4))
   net:add(jzt.Tanh())
   net = net:cuda()

   print(testJacobian(net, A))
   print(testJacobianParameters(net, A))
end

function test.SpatialConvolution1()
   A = torch.CudaTensor(4, 3, 5, 5):normal()
   module = jzt.SpatialConvolution1(3, 4)

   print(testJacobian(module, A))
   print(testJacobianParameters(module, A))
end

function test.SpatialLogSoftMax()
   A = torch.CudaTensor(4, 3, 4, 4):normal()
   
   net = nn.Sequential()
   net:add(nn.SpatialConvolution(3, 4, 2, 2))
   net:add(jzt.SpatialLogSoftMax())
   net = net:cuda()
   
   print(testJacobian(net, A))
   print(testJacobianParameters(net, A))
end

function test.LinearRelu()
   A = torch.CudaTensor(5, 3):normal()

   net = nn.Sequential()
   net:add(jzt.Linear(3, 4))
   net:add(jzt.Relu())
   net = net:cuda()

   print(testJacobian(net, A))
   print(testJacobianParameters(net, A))
end

function test.SpatialBias()
   A = torch.CudaTensor(1, 5, 3):normal()

   net = jzt.SpatialBias(1, 5, 3)
   print(testJacobian(net, A))
   print(testJacobianParameters(net, A))
end

function test.StereoJoin()
   A = torch.CudaTensor(6, 8, 4, 12):normal()
   n = jzt.StereoJoin(3)
   print(testJacobian(n, A))
end

function test.L2Pooling()
   torch.manualSeed(42)
   A = torch.CudaTensor(6, 8, 12, 7):normal()
   n = jzt.L2Pooling(3, 2)

   print(testJacobian(n, A))
end

function test.L1Cost()
   A = torch.CudaTensor(5, 4, 3, 3):normal()
   n = jzt.L1Cost():cuda()

   print(testCriterion(n, A))
end

test = {}
function test.ConvSplit()
   x = image.rgb2y(image.lena()):resize(1, 1, 512, 512):cuda()
   n = jzt.ConvSplit(64, 5)
   n:forward(x)
end

for k, v in pairs(test) do
   print('Testing ' .. k)
   v()
end

local PairwiseDistance, parent = torch.class('jzt.PairwiseDistance','nn.Module')

-- Distance is L2^2

function PairwiseDistance:__init()
   parent.__init(self)
end

function PairwiseDistance:updateOutput(input)
   self.output:resize(input:size(1) / 2)
   jzt.PairwiseDistance_updateOutput(input, self.output)
   return self.output
end

function PairwiseDistance:updateGradInput(input, gradOutput)
   self.gradInput:resizeAs(input)
   jzt.PairwiseDistance_updateGradInput(input, gradOutput, self.gradInput)
   return self.gradInput
end

local StereoJoin2, parent = torch.class('jzt.StereoJoin2','nn.Module')

function StereoJoin2:__init(disp_max)
   parent.__init(self)
   self.disp_max = disp_max
end

function StereoJoin2:updateOutput(input)
   local bs = input:size(1)
   local h = input:size(3)
   local w = input:size(4)

   self.output:resize(bs / 2, self.disp_max + 1, h, w - self.disp_max)
   jzt.StereoJoin2_updateOutput(input, self.output)
   return self.output
end

function StereoJoin2:updateGradInput(input, gradOutput)
   self.gradInput:resizeAs(input)
   jzt.StereoJoin2_updateGradInput(input, gradOutput, self.gradInput)
   return self.gradInput
end

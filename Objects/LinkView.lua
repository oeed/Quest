Inherit = 'View'
Height = 2

OnLoad = function(self)
	if self.Text and #self.Text > 0 then
		self:AddObject({
			Y = 1,
			X = 1,
			Width = self.Width,
			Align = self.Align,
			Type = "Label",
			Text = self.Text,
			TextColour = self.TextColour,
			BackgroundColour = self.BackgroundColour
		})
	end
end

OnRecalculateStart = function(self)
	self:RemoveObject('UnderlineLabel')
end

OnRecalculateEnd = function(self, currentY)
	local underline = ''
	local len = self.Width
	if self.Text then
		len = #self.Text
	end

	for i = 1, len do
		underline = underline .. '-'
	end
	local ul = self:AddObject({
		Y = currentY,
		X = 1,
		Width = self.Width,
		Align = self.Align,
		Type = "Label",
		Name = "UnderlineLabel",
		Text = underline,
		TextColour = self.TextColour,
		BackgroundColour = self.BackgroundColour
	})	
	return currentY + 1
end

OnClick = function(self)
	self.Bedrock:GetObject('WebView'):GoToURL(self.URL)
end

-- AddObject = function (self, info, extra)
-- 	print(info.Y)
-- end
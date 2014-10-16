OnCreateObject = function(self, parentObject, y)
	return {
		Element = self,
		Y = y,
		X = 1,
		Width = self.Width,
		Height = self.Height,
		BackgroundColour = self.BackgroundColour,
		Type = "FloatView"
	}
end
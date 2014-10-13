Tag = nil
TextColour = colours.black
BackgroundColour = colours.transparent
URL = nil
Format = nil

Initialise = function(self, node)
	local new = {}    -- the new instance
	setmetatable( new, {__index = self} )
	local attr = node._attr
	new.Children = {}
	new.Tag = node._tag
	new.Attributes = attr

	if attr.src then
		new.URL = attr.src
	end

	if attr.type then
		new.Format = attr.type
	end

	if attr.height then
		new.Height = attr.height
	end

	if attr.width then
		new.Width = attr.width
	end

	return new
end

CreateObject = function(self, parentObject, y)
	return parentObject:AddObject({
		Element = self,
		Y = y,
		X = 1,
		Width = self.Width,
		Height = self.Height,
		URL = self.URL,
		Format = self.Format,
		Type = "WebImageView"
	})
end
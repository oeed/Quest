Text = nil
Value = nil
Tag = nil

Initialise = function(self, node)
	local new = {}    -- the new instance
	setmetatable( new, {__index = self} )
	local attr = node._attr
	new.Tag = node._tag
	new.Attributes = attr
	new.Children = {}

	if type(node[1]) == 'string' then
		new.Text = node[1]
	end
	
	if attr.colour then
		new.TextColour = self:ParseColour(attr.colour)
	elseif attr.color then
		new.TextColour = self:ParseColour(attr.color)
	end

	if attr.bgcolour then
		new.BackgroundColour = self:ParseColour(attr.bgcolour)
	elseif attr.bgcolor then
		new.BackgroundColour = self:ParseColour(attr.bgcolor)
	end

	if attr.value then
		new.Value = attr.value
	end

	return new
end

CreateObject = function(self, parentObject, y)
	-- printError('add')
	if parentObject.AddMenuItem then
		parentObject:AddMenuItem({
			Value = self.Value,
			Text = self.Text,
			Type = "Button"
		})
	end
	-- return parentObject:AddObject({
	-- 	Element = self,
	-- 	Y = y,
	-- 	X = 1,
	-- 	Width = "100%",
	-- 	Height = self.Height,
	-- 	BackgroundColour = self.BackgroundColour,
	-- 	-- Name = "GoodbyeButton",
	-- 	Type = "View"
	-- })
end
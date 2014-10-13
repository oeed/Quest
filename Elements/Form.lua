Children = nil
Tag = nil

Initialise = function(self, node)
	local new = {}    -- the new instance
	setmetatable( new, {__index = self} )
	local attr = node._attr
	new.Tag = node._tag
	new.Attributes = attr
	new.Children = {}
	return new
end

Submit = function(self)
	local values = {}
	
	local node = false
	node = function(elem)
		if (elem.Tag == 'input' or elem.Tag == 'select') and elem.InputName then
			if elem.UpdateValue then
				elem:UpdateValue()
			end

			if elem.Value then
				values[elem.InputName] = elem.Value
			end
		end

		if elem.Children then
			for i, child in ipairs(elem.Children) do
				node(child)
			end
		end
	end

	node(self)

	local url = false
	if self.Attributes.action and #self.Attributes.action > 0 then
		url = resolveQuestHostUrl(resolveFullUrl(self.Attributes.action))
	else
		url = getCurrentUrl()
	end
	local data = ''
	for k, v in pairs(values) do
		data = data .. textutils.urlEncode(k) .. '=' .. textutils.urlEncode(v) .. '&'
	end
	data = data:sub(1, #data - 1)

	if self.Attributes.method and self.Attributes.method:lower() == 'post' then
		goToUrl(url, data)
	else
		goToUrl(url .. '?' .. data)
	end
end

CreateObject = function(self, parentObject, y)
	return parentObject:AddObject({
		Element = self,
		Y = y,
		X = 1,
		Width = "100%",
		Height = self.Height,
		Type = "View"
	})
end
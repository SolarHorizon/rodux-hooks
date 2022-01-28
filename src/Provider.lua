local Roact = require(script.Parent.Parent.Roact)
local Context = require(script.Parent.Context)

local e = Roact.createElement

local function Provider(props)
	local context = props.context or Context

	return e(context.Provider, {
		value = props.store,
	}, props[Roact.Children])
end

return Provider

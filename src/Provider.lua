local Roact = require(script.Parent.Parent.Roact)
local Context = require(script.Parent.Context)

local e = Roact.createElement

local function Provider(props)
    return e(Context.Provider, {
        value = props.store,
    }, props[Roact.Children])
end

return Provider

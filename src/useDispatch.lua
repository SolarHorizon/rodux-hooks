local Context = require(script.Parent.Context)
local useCustomDispatch = require(script.Parent.useCustomDispatch)

local function useDispatch(hooks)
    return useCustomDispatch(hooks, Context)
end

return useDispatch

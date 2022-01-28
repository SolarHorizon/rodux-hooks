local Context = require(script.Parent.Context)

local function useStore(hooks)
    return hooks.useContext(Context)
end

return useStore

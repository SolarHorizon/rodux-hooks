local Context = require(script.Parent.Context)
local useCustomStore = require(script.Parent.useCustomStore)

local function useStore(hooks)
    return useCustomStore(hooks, Context)
end

return useStore

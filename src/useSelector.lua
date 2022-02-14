local Context = require(script.Parent.Context)
local useCustomSelector = require(script.Parent.useCustomSelector)

local function useSelector(
	hooks,
	selector: (state: table) -> any,
	equalityFn: ((newState: table, oldState: table) -> boolean)?
)
	return useCustomSelector(hooks, selector, equalityFn, Context)
end

return useSelector

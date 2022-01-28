local Context = require(script.Parent.Context)

local function defaultEqualityFn(newState, oldState)
	return newState == oldState
end

local function useSelector(
	hooks,
	selector: (state: table) -> any,
	equalityFn: (newState: table, oldState: table) -> boolean
)
	local store = hooks.useContext(Context)
	local mappedState, setMappedState = hooks.useState(selector(store:getState()))

	if equalityFn == nil then
		equalityFn = defaultEqualityFn
	end

	hooks.useEffect(function()
		local storeChanged = store.changed:connect(function(newState, _oldState)
			local newMappedState = selector(newState)

			if not equalityFn(newMappedState, mappedState) then
				setMappedState(newMappedState)
			end
		end)

		return function()
			storeChanged:disconnect()
		end
	end, {})

	return mappedState
end

return useSelector

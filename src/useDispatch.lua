local Context = require(script.Parent.Context)

local function useDispatch(hooks)
	local store = hooks.useContext(Context)

    return function(action)
        store:dispatch(action)
    end
end

return useDispatch

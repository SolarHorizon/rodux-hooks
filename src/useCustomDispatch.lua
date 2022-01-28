local function useCustomDispatch(hooks, context)
	local store = hooks.useContext(context)

    return function(action)
        store:dispatch(action)
    end
end

return useCustomDispatch

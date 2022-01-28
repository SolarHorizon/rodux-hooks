local function useStore(hooks, context)
    return hooks.useContext(context)
end

return useStore

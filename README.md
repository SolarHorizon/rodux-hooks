# rodux-hooks
A very simple bridge between Roact and Rodux via [roact-hooks](https://github.com/Kampfkarren/roact-hooks), inspired by [react-redux](https://react-redux.js.org/api/hooks).

# API
## Provider
Accesses your store via the `store` prop and makes it available to all of its children. There should never be more than one of these in your Roact tree at a time.

```lua
local function app(props, hooks)
    return e(RoactHooks.Provider, {
        store = store,
    }, {
        -- your app goes here
    })
end
```

## useSelector
This is the primary way to get data from a Rodux store with rodux-hooks.

Multiple useSelector hooks can be used in the same component, but you should try to limit your usage because they will trigger a re-render whenever the selector returns a new value.

By default, useSelector will directly compare the old and new value to each other. You can pass a function to `equalityFn` for more control over this.

`useSelector(hooks: RoactHooks, selector: (state: table), equalityFn: (oldState: table, newState: table) -> boolean) -> any`

### Example
```lua
local function ExampleLabel(props, hooks)
    local money = RoduxHooks.useSelector(hooks, function(state)
        return state.money
    end)

    return e("TextLabel", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(100, 50),
        Text = "Money: " .. money,
    })
end
```

## useDispatch
Returns the dispatch function of your Rodux store.

```lua
local function ExampleButton(props, hooks)
    local dispatch = RoduxHooks.useDispatch(hooks)

    return e("TextButton", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(100, 50),
        Text = "Click me for free money!",

        [Roact.Event.Activate] = function()
            dispatch({
                type = "moneyAdded",
                amount = 100,
            })
        end,
    })
end
```

## useStore
Returns the Rodux store. You will probably rarely ever need to use this.

```lua
local function BadExampleButton(props, hooks)
    local store = useStore(hooks)

    -- your component here
end
```

## shallowEqual
Does a shallow comparison of two values (usually tables). This is included as a helper function to be used with useSelector.

```lua
local shallowEqual = RoduxHooks.shallowEqual

local function AnotherExampleComponent(props, hooks)
    local items = RoduxHooks.useSelector(hooks, selector, shallowEqual)

    -- your component here
end
```

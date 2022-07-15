# rodux-hooks

A very simple bridge between Roact and Rodux via [roact-hooks](https://github.com/Kampfkarren/roact-hooks), inspired by [react-redux](https://react-redux.js.org/api/hooks).

# API

## Provider

Accesses your store via the `store` prop and makes it available to all of its children. Optionally takes a `context` prop if you're using a custom context.

```lua
local function app(props, hooks)
    return e(RoduxHooks.Provider, {
        store = store,
    }, {
        -- your app goes here
    })
end
```

## useSelector

This is the primary way to get data from a Rodux store with rodux-hooks. Multiple useSelector hooks can be used in the same component.

By default, useSelector will directly compare the previous value returned by `selector` to the most recent one. When the old and new values are not equal, the component will be re-rendered with the updated state. You can optionally pass a function to `equalityFn` for finer control over this.

```lua
useSelector(
    hooks: RoactHooks,
    selector: (state: table),
    equalityFn: ((oldState: table, newState: table) -> boolean)?
) -> any
```

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
useDispatch(hooks: RoactHooks) -> dispatch
```

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
useStore(hooks: RoactHooks) -> RoduxStore
```

## shallowEqual

Does a shallow comparison of two values (usually tables). This is included as a helper function to be used with useSelector.

```lua
shallowEqual(x: any, y: any) -> boolean
```

# Custom Context API

These functions are exposed in the event that you are using a custom context. You would probably only need to do this if you were using more than one store, which is generally frowned upon in Rodux.

## useCustomSelector

Like useSelector, but accepts a custom context.

```lua
useCustomSelector(
    hooks: RoactHooks,
    selector: (state: table),
    equalityFn: ((oldState: table, newState: table) -> boolean)?,
    customContext: RoactContext
) -> any
```

## useCustomDispatch

Like useDispatch, but accepts a custom context.

```lua
useCustomDispatch(
    hooks: RoactHooks,
    customContext: RoactContext
) -> dispatch
```

## Example

```lua
local CustomContext = Roact.createContext()

local function app(props, hooks)
    return e(RoduxHooks.Provider, {
        store = store,
        context = CustomContext,
    }, {
        -- a bunch of components
    })
end

-- A component that is a descendant of `app`
local function YetAnotherExample(props, hooks)
    local value = RoduxHooks.useCustomSelector(hooks, selector, equalityFn, CustomContext)
    local dispatch = RoduxHooks.useCustomDispatch(hooks, CustomContext)

    -- your component here
end
```

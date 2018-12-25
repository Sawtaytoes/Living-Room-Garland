print('hi')
local t = loadfile('libraries.lc')
print(t)
local libraries = t()
print('hi2')
local createReducer = function(
	reducerActions,
	initialState
)
	return function(
		state,
		action
	)
		if not state then
			state = initialState
		end

		print(action)
		print(reducerActions)
		print(action.type)
		print(reducerActions[action.type])

		return (
			reducerActions[action.type]
			and (
				reducerActions[action.type](
					state,
					action
				)
			)
			or state
		)
	end
end

local createStore = function(
	reducers,
	middleware
)
	local state = {}
	local store = {}
	local subscribers = {}

	store
	.getState = function()
		return state
	end

	store
	.subscribe = function(
		func
	)
		table
		.insert(
			subscribers,
			func
		)
	end

	store
	.dispatch = function(
		action
	)
		local nextState = {}

		for key, reducer in pairs(reducers) do
			local prevState = state[key]

			local stateSlice = (
				reducer(
					prevState,
					action
				)
			)

			nextState[key] = stateSlice
		end

		libraries
		.merge(
			state,
			nextState
		)

		for _, func in ipairs(middleware) do
			print(func)
			func(
				store
			)(
				store
				.dispatch
			)(
				action
			)
		end

		for _, subscriber in ipairs(subscribers) do
			print(subscriber)
			subscriber()
		end

		return action
	end

	store
	.dispatch({ type = '' })

	return store
end

return {
	createReducer = createReducer,
	createStore = createStore,
}

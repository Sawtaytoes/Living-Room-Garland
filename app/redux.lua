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

		merge(state, nextState)

		for func in ipairs(middleware) do
			func(
				store
			)(
				store
				.dispatch
			)(
				action
			)
		end

		for subscriber in ipairs(subscribers) do
			subscriber()
		end

		return action
	end

	store
	.dispatch({ type = '' })

	return store
end

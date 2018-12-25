local middleware = {}

table
.insert(
	middleware,
	garlandLightsMiddleware
)

local rootReducer = {
	garlandLights = createGarlandLightsReducer()
}

local store = (
	createStore(
		rootReducer,
		middleware
	)
)

store
.subscribe(function()
	print_as_json(
		store
		.getState()
	)
end)

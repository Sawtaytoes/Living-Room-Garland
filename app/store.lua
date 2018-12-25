local actionLoggerMiddleware = loadfile('actionLoggerMiddleware.lua')()
local garlandLightsMiddleware = loadfile('garlandLightsMiddleware.lua')()
local garlandLightsReducer = loadfile('garlandLightsReducer.lua')()
local libraries = loadfile('libraries.lua')()
local redux = loadfile('redux.lua')()
local sendStateMiddleware = loadfile('sendStateMiddleware.lua')()

local middleware = {
	actionLoggerMiddleware,
	garlandLightsMiddleware,
	sendStateMiddleware,
}

local rootReducer = {
	garlandLights = garlandLightsReducer
}

local store = (
	redux
	.createStore(
		rootReducer,
		middleware
	)
)

store
.subscribe(function()
	libraries
	.print_as_json(
		store
		.getState()
	)
end)

return store

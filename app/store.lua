local actionLoggerMiddleware = loadfile('actionLoggerMiddleware.lc')
local garlandLightsMiddleware = loadfile('garlandLightsMiddleware.lc')
local garlandLightsReducer = loadfile('garlandLightsReducer.lc')
local libraries = loadfile('libraries.lc')
local sendStateMiddleware = loadfile('sendStateMiddleware.lc')

local middleware = {
	actionLoggerMiddleware,
	garlandLightsMiddleware,
	sendStateMiddleware,
}

local rootReducer = {
	garlandLights = garlandLightsReducer()
}

local store = (
	createStore(
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

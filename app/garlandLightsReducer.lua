local actions = loadfile('actions.lc')()
local redux = loadfile('redux.lc')()

local gpioStates = {
	[gpio.LOW] = 'off',
	[gpio.HIGH] = 'on',
}

local initialState = 'unknown'

local reducerActions = {
	[actions.TURN_OFF_GARLAND_LIGHTS] = function()
		return initialState
	end,

	[actions.TURN_ON_GARLAND_LIGHTS] = function(
		prevState,
		action
	)
		return action.payload
	end,
}

local garlandLightsReducer = (
	redux
	.createReducer(
		reducerActions,
		initialState
	)
)

return garlandLightsReducer

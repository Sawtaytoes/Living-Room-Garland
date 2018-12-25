local actions = loadfile('actions.lc')()
local redux = loadfile('redux.lc')()

local initialState = 'unknown'

local reducerActions = {
	[actions.TURN_OFF_GARLAND_LIGHTS] = function()
		return 'off'
	end,

	[actions.TURN_ON_GARLAND_LIGHTS] = function(
		prevState,
		action
	)
		return 'on'
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

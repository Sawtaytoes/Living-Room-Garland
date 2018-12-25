local TURN_OFF_GARLAND_LIGHTS = 'GARLAND_LIGHTS::TURN_OFF'
local TURN_ON_GARLAND_LIGHTS = 'GARLAND_LIGHTS::TURN_ON'

local turnOffGarlandLights = function()
	return {
		type = TURN_OFF_GARLAND_LIGHTS,
	}
end

local turnOnGarlandLights = function()
	return {
		type = TURN_ON_GARLAND_LIGHTS,
	}
end

local createGarlandLightsReducer = function()
	local gpioStates = {
		[gpio.LOW] = 'off',
		[gpio.HIGH] = 'on',
	}

	local initialState = 'unknown'

	local reducerActions = {
		[TURN_OFF_GARLAND_LIGHTS] = function()
			return initialState
		end,

		[TURN_ON_GARLAND_LIGHTS] = function(
			prevState,
			action
		)
			return action.payload
		end,
	}

	local garlandLightsReducer = (
		createReducer(
			reducerActions,
			initialState
		)
	)

	return garlandLightsReducer
end

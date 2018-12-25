local SEND_STATE = 'HTTP_SERVER::SEND_STATE'

local sendState = function(
	socket
)
	return {
		socket = socket,
		type = SEND_STATE,
	}
end

local TURN_OFF_GARLAND_LIGHTS = 'GARLAND_LIGHTS::TURN_OFF'
local TURN_ON_GARLAND_LIGHTS = 'GARLAND_LIGHTS::TURN_ON'

local turnOffGarlandLights = function(
	socket
)
	return {
		socket = socket,
		type = TURN_OFF_GARLAND_LIGHTS,
	}
end

local turnOnGarlandLights = function(
	socket
)
	return {
		socket = socket,
		type = TURN_ON_GARLAND_LIGHTS,
	}
end

return {
	SEND_STATE = SEND_STATE,
	sendState = sendState,
	TURN_OFF_GARLAND_LIGHTS = TURN_OFF_GARLAND_LIGHTS,
	TURN_ON_GARLAND_LIGHTS = TURN_ON_GARLAND_LIGHTS,
	turnOffGarlandLights = turnOffGarlandLights,
	turnOnGarlandLights = turnOnGarlandLights,
}

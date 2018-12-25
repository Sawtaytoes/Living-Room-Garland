local actions = loadfile('actions.lc')

local garlandLightsRelayPin = 1

gpio
.mode(
	garlandLightsRelayPin,
	gpio.OUTPUT
)

local garlandLightsGpioPinActions = {
	[actions.TURN_OFF_GARLAND_LIGHTS] = function(
		action
	)
		gpio
		.write(
			lightsRelayPin,
			gpio.LOW
		)

		return (
			actions
			.sendState(
				action
				.socket
			)
		)
	end,

	[actions.TURN_ON_GARLAND_LIGHTS] = function(
		action
	)
		gpio
		.write(
			lightsRelayPin,
			gpio.HIGH
		)

		return (
			actions
			.sendState(
				action
				.socket
			)
		)
	end,
}

local garlandLightsMiddleware = (
	function(store)
		return function(next)
			return function(action)
				if (garlandLightsGpioPinActions[action.type]) then
					next(
						garlandLightsGpioPinActions[action.type]()
					)
				end
			end
		end
	end
)

return garlandLightsMiddleware

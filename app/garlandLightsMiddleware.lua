local actions = loadfile('actions.lc')()

local relayPin = 4

gpio
.mode(
	relayPin,
	gpio.OUTPUT
)

gpio
.mode(
	relayPin,
	gpio.LOW
)

local garlandLightsGpioPinActions = {
	[actions.TURN_OFF_GARLAND_LIGHTS] = function(
		action
	)
		gpio
		.write(
			relayPin,
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

	[actions.TURN_ON_GARLAND_LIGHTS] = function(
		action
	)
		gpio
		.write(
			relayPin,
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
}

local garlandLightsMiddleware = (
	function(store)
		return function(next)
			return function(action)
				garlandLightsGpioPinActions[action.type]
				and (
					next(
						garlandLightsGpioPinActions[action.type](
							action
						)
					)
				)
			end
		end
	end
)

return garlandLightsMiddleware

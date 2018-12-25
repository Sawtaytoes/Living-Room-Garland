local lightsRelayPin = 1

gpio.mode(lightsRelayPin, gpio.OUTPUT)

local states = {
	[gpio.LOW] = 'off',
	[gpio.HIGH] = 'on',
}

local setLightState = function(newState)
	state = newState
end

local getNextLightState = function()
	return state
end

local getCurrentLightState = function()
	local sensorReading = gpio.read(lightsRelayPin)
	local nextState = states[sensorReading]

	setLightState(nextState)

	return state
end

local toggleLights = function()
	print('toggling garage door')
	gpio.write(lightsRelayPin, gpio.LOW)

	tmr.delay(lightsTriggerTime)

	gpio.write(lightsRelayPin, gpio.HIGH)
end

local turnOnLights = function()
	if gpio.read(lightsSensorPin) == gpio.LOW then
		toggleLights()
	end

	setLightState('on')
end

local turnOffLights = function()
	if gpio.read(lightsSensorPin) == gpio.HIGH then
		toggleLights()
	end

	setLightState('off')
end

local onResponseSent = function(socket)
	print('closing socket')
	socket:close()
end

local onReceivedData = function(socket, data)
	print('onReceivedData', data)

	socket:on('sent', onResponseSent)

	-- Routes
	if data:find('GET /status') then
		socket
		:send(
			store
			.getState()
		)

	elseif data:find('GET /light/on') then
		turnOnLights()
		socket:send(getNextLightState())

	elseif data:find('GET /light/off') then
		turnOffLights()
		socket:send(getNextLightState())

	else
		socket:close()
	end
end

local srv = net.createServer(net.TCP)

srv:listen(
	80,
	function(connection)
		connection:on('receive', onReceivedData)
	end
)

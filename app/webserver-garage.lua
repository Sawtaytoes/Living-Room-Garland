local garageDoorMotorPin = 1
local garageDoorSensorPin = 2
local garageDoorTriggerTime = 500000

gpio.mode(garageDoorMotorPin, gpio.OUTPUT)
gpio.mode(garageDoorSensorPin, gpio.INPUT)

-- Turn on sensor
gpio.write(garageDoorSensorPin, gpio.HIGH)

local garageState = 'Unknown'
local garageStates = {
	[gpio.LOW] = 'closed',
	[gpio.HIGH] = 'opened',
}

local setGarageState = function(newState)
	garageState = newState
end

local getNextGarageState = function()
	return garageState
end

local getCurrentGarageState = function()
	local sensorReading = gpio.read(garageDoorSensorPin)
	local nextState = garageStates[sensorReading]

	setGarageState(nextState)
	return garageState
end

local toggleGarageDoor = function()
	print('toggling garage door')
	gpio.write(garageDoorMotorPin, gpio.LOW)

	tmr.delay(garageDoorTriggerTime)

	gpio.write(garageDoorMotorPin, gpio.HIGH)
end

local openGarage = function()
	if gpio.read(garageDoorSensorPin) == gpio.LOW then
		toggleGarageDoor()
	end

	setGarageState('opened')
end

local closeGarage = function()
	if gpio.read(garageDoorSensorPin) == gpio.HIGH then
		toggleGarageDoor()
	end

	setGarageState('closed')
end

local responseSent = function(socket)
	print('closing socket')
	socket:close()
end

-- local routes = {
-- 	'GET /status'=
-- 	'GET /open'=
-- 	'GET /close'=
-- }

local receiver = function(socket, data)
	print('received request')
	socket:on('sent', responseSent)

	-- Routes
	if data:find('GET /status') then
		socket:send(getCurrentGarageState())

	elseif data:find('GET /open') then
		openGarage()
		socket:send(getNextGarageState())

	elseif data:find('GET /close') then
		closeGarage()
		socket:send(getNextGarageState())

	else
		socket:close()
	end
end

local srv = net.createServer(net.TCP)

srv:listen(
	80,
	function(connection)
		connection:on('receive', receiver)
	end
)

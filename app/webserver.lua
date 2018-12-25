local actions = loadfile('actions.lc')
local store = loadfile('store.lc')

local onResponseSent = function(
	socket
)
	print('closing socket')

	socket
	:close()
end

local onReceivedData = function(socket, data)
	print(
		'onReceivedData',
		data
	)

	socket
	:on(
		'sent',
		onResponseSent
	)

	-- Routes
	if data:find('GET /status') then
		socket
		:send(
			store
			.getState()
		)

	elseif data:find('GET /light/off') then
		store
		.dispatch(
			actions
			.turnOffGarlandLights(
				socket
			)
		)

	elseif data:find('GET /light/on') then
		store
		.dispatch(
			actions
			.turnOnGarlandLights(
				socket
			)
		)

	else
		socket
		:close()
	end
end

local httpServer = (
	net
	.createServer(
		net
		.TCP
	)
)

httpServer
:listen(
	80,
	function(connection)
		connection
		:on(
			'receive',
			onReceivedData
		)
	end
)

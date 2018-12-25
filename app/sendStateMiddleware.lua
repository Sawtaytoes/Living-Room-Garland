local actions = loadfile('actions.lc')()
local libraries = loadfile('libraries.lc')()

local responseHeaders = {
	'HTTP/1.1 200 OK',
	'Server: NodeMCU on ESP8266',
	'Content-Type: application/json',
	'\r\n',
}

local sendStateMiddleware = (
	function(store)
		return function()
			return function(action)
				if action.type == actions.SEND_STATE then
					for i, responseHeader in ipairs(responseHeaders) do
						action
						.socket
						:send(responseHeader)

						action
						.socket
						:send('\r\n')
					end

					action
					.socket
					:send(
						libraries
						.format_as_json(
							store
							.getState()
						)
					)
				end
			end
		end
	end
)

return sendStateMiddleware

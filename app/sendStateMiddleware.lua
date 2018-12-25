local actions = loadfile('actions.lc')()
local libraries = loadfile('libraries.lc')()

local sendStateMiddleware = (
	function(store)
		return function()
			return function(action)
				if action.type == actions.SEND_STATE then
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

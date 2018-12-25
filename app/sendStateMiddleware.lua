local actions = loadfile('actions.lc')

local sendStateMiddleware = (
	function(store)
		return function()
			return function(action)
				if action.type == actions.SEND_STATE then
					action
					.socket
					:send(
						store
						.getState()
					)
				end
			end
		end
	end
)

return sendStateMiddleware

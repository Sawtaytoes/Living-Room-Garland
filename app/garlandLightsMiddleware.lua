local garlandLightsMiddleware = (
	function(store)
		return function(next)
			return function(action)
				print(action)
			end
		end
	end
)

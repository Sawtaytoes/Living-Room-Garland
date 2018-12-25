local libraries = loadfile('libraries.lua')()

local actionLoggerMiddleware = (
	function()
		return function()
			return libraries.print_as_json
		end
	end
)

return actionLoggerMiddleware

local forEach = function(tbl, func)
	for i, v in pairs(tbl) do
		func(v)
	end
end

local pins = {
	1,
	2,
	3,
	6,
}

local setPinLow = function(pin)
	gpio.mode(pin, gpio.OUTPUT)
	gpio.write(pin, gpio.HIGH)
end

forEach(pins, setPinLow)

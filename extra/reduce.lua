local reduce = function(
	values,
	func,
	initialValue
)
	local returnValue = initialValue

	for value in ipairs(values) do
		returnValue = (
			func(
				returnValue,
				value
			)
		)
	end

	return returnValue
end

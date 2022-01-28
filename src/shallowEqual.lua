local function shallowEqual(x, y)
	if typeof(x) ~= "table" or typeof(y) ~= "table" then
		return x == y
	end

	for k, v in pairs(x) do
		if y[k] ~= v then
			return false
		end
	end

	for k, v in pairs(y) do
		if x[k] ~= v then
			return false
		end
	end

	return true
end

return shallowEqual

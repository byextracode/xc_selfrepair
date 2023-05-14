lib.callback.register("selfRepair:request", function(source, data)
	local xPlayer = ESX.GetPlayerFromId(source)
	if not xPlayer then
		return "error"
	end
	local index = data?.index
	if not index then
		return "error (data invalid)"
	end
	local table = Config.repairs[index]
	if not table then
		return "error (data invalid)"
	end
	local price = table.fee
	local enoughMoney = xPlayer.getAccount("money").money >= price
	if not enoughMoney then
		return labelText("not_enough_money")
	end
	return true
end)

lib.callback.register("selfRepair:pay", function(source, data)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if not xPlayer then
		return
	end
	local index = data?.index
	if not index then
		return "error (data invalid)"
	end
	local table = Config.repairs[index]
	if not table then
		return "error (data invalid)"
	end
	local price = table.fee
	xPlayer.removeAccountMoney("money", price)
	return true
end)
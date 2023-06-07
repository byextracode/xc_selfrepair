lib.callback.register("selfRepair:request", function(source, data)
	local Player = GetPlayerData(source)
	if not Player then
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
	local enoughMoney = Player.GetMoney("money") >= price
	if not enoughMoney then
		return labelText("not_enough_money")
	end
	return true
end)

lib.callback.register("selfRepair:pay", function(source, data)
	local Player = GetPlayerData(source)
	if not Player then
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
	Player.RemoveMoney("money", price)
	return true
end)
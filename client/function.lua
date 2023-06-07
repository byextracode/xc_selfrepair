local function repair(data)
	local result = lib.callback.await("selfRepair:request", false, data)
	if type(result) == "string" then
		return lib.notify({
            title = labelText("failure"),
            description = result,
            position = 'top',
            style = {
                backgroundColor = '#141517',
                color = '#909296'
            },
            icon = 'ban',
            iconColor = '#C53030'
        })
	end

	local vehicle = data?.vehicle
	if not DoesEntityExist(vehicle) then
		return
	end
	if repairing then
		return lib.notify({
            title = labelText("attention"),
            description = labelText("in_progress"),
            position = 'top',
            style = {
                backgroundColor = '#141517',
                color = '#909296'
            },
            icon = 'circle-exclamation',
            iconColor = '#ffff00'
        })
	end

	repairing = true
	Wait(1000)

	local options = {
		duration = data.duration * 1000,
		label = labelText("progress_label"),
		position = "bottom",
		useWhileDead = false,
		canCancel = true,
		disable = {
			move = true,
			car = true
		}
	}
	local progress = lib.progressCircle(options)
	CreateThread(function()
		Wait(2000)
		repairing = false
	end)
	if not progress then
		return lib.notify({
            title = labelText("attention"),
            description = labelText("progress_canceled"),
            position = 'top',
            style = {
                backgroundColor = '#141517',
                color = '#909296'
            },
            icon = 'circle-exclamation',
            iconColor = '#ffff00'
        })
	end

	local payment = lib.callback.await("selfRepair:pay", false, data)
	if type(payment) == "string" then
		return lib.notify({
            title = labelText("failure"),
            description = payment,
            position = 'top',
            style = {
                backgroundColor = '#141517',
                color = '#909296'
            },
            icon = 'ban',
            iconColor = '#C53030'
        })
	end

	SetVehicleFixed(vehicle)
	SetVehicleDeformationFixed(vehicle)

	lib.notify({
		title = labelText("success"),
		description = labelText("repair_finish"),
		position = 'top',
		style = {
			backgroundColor = '#141517',
			color = '#909296'
		},
		icon = 'circle-check',
		iconColor = '#00ff00'
	})
	Wait(3000)
	lib.notify({
		title = labelText("success"),
		description = labelText("repair_paid", data.fee),
		position = 'top',
		style = {
			backgroundColor = '#141517',
			color = '#909296'
		},
		icon = 'circle-check',
		iconColor = '#00ff00'
	})
end

function selfRepairs(data)
	local table = Config.repairs[data.index]
	if table.job then
		if not isAuthorized(table.job) then
			return lib.notify({
				title = labelText("failure"),
				description = labelText("unauthorized"),
				position = 'top',
				style = {
					backgroundColor = '#141517',
					color = '#909296'
				},
				icon = 'ban',
				iconColor = '#C53030'
			})
		end
	end

	data.duration = table.duration
	data.fee = table.fee

	lib.registerContext({
		id = "selfrepair",
		title = labelText("context_menu"),
		options = {
			{
				title = labelText("context_title", data.duration),
				description = labelText("context_desc", data.fee),
                onSelect = function()
                    repair(data)
                end
			},
		}
	})
	Wait(500)
	lib.showContext("selfrepair")
end
repairing = false
local blips = {}

CreateThread(function()
    for i = 1, #Config.repairs do
        local locations = Config.repairs[i].coords
        if type(locations) ~= "table" then
            locations = {locations}
        end
        for n = 1, #locations do
            local coords = locations[n]
            local point = lib.points.new({
                coords = coords,
                distance = 10.0
            })

            if Config.repairs[i].blip and not blips[i] then
                local prop = Config.repairs[i].blip
                local blip = AddBlipForCoord(coords)
                SetBlipScale(blip, prop.scale)
                SetBlipDisplay(blip, 4)
                SetBlipSprite(blip, prop.sprite)
                SetBlipColour(blip, prop.color)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(prop.label)
                EndTextCommandSetBlipName(blip)
                blips[i] = blip
            end

            function point:nearby()
                if self.isClosest then
                    if self.currentDistance <= 2.0 and cache.vehicle and not repairing then
                        if not textUI then
                            lib.showTextUI(labelText("textui"))
                            textUI = true
                        end
                        if IsControlJustPressed(0, 38) then
                            lib.hideTextUI()
                            textUI = nil

                            local data = {
                                index = i,
                                vehicle = cache.vehicle
                            }
                            selfRepairs(data)
                            Wait(1000)
                        end
                    else
                        if textUI then
                            textUI = nil
                            lib.hideTextUI()
                        end
                    end
                end
                if Config.repairs[i].marker then
                    DrawMarker(Config.repairs[i].marker.type, self.coords.x, self.coords.y, self.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.repairs[i].marker.scale, Config.repairs[i].marker.scale, Config.repairs[i].marker.scale, 200, 20, 20, 150, false, true, 2, false, nil, nil, false)
                end
            end
        end
    end
end)
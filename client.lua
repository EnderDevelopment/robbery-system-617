local QBCore = exports['qb-core']:GetCoreObject()

local function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

local function startRobbery(target)
    local playerPed = PlayerPedId()
    local playerId = PlayerId()
    local targetId = GetPlayerServerId(target)

    if not targetId then
        QBCore.Functions.Notify('Invalid target', 'error')
        return
    end

    loadAnimDict(Config.RobberyAnimDict)
    TaskPlayAnim(playerPed, Config.RobberyAnimDict, Config.RobberyAnimName, 8.0, -8.0, Config.RobberyTime, Config.RobberyAnimFlag, 0, false, false, false)

    QBCore.Functions.Progressbar('robbery_progress', 'Robbing...', Config.RobberyTime, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = Config.RobberyAnimDict,
        anim = Config.RobberyAnimName,
        flags = Config.RobberyAnimFlag,
    }, {}, function() -- Done
        TriggerServerEvent('ender_robberysystem:completeRobbery', targetId)
        StopAnimTask(playerPed, Config.RobberyAnimDict, Config.RobberyAnimName, 1.0)
    end, function() -- Cancel
        QBCore.Functions.Notify('Robbery cancelled', 'error')
        StopAnimTask(playerPed, Config.RobberyAnimDict, Config.RobberyAnimName, 1.0)
    end)
end

RegisterNetEvent('ender_robberysystem:startRobbery', function(target)
    startRobbery(target)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for _, player in ipairs(GetActivePlayers()) do
            local targetPed = GetPlayerPed(player)
            local targetCoords = GetEntityCoords(targetPed)
            local distance = #(playerCoords - targetCoords)

            if distance < Config.RobberyDistance and player ~= PlayerId() then
                DrawText3D(targetCoords.x, targetCoords.y, targetCoords.z + 1.0, 'Press E to rob')

                if IsControlJustReleased(0, 38) then -- E key
                    TriggerServerEvent('ender_robberysystem:attemptRobbery', GetPlayerServerId(player))
                end
            end
        end
    end
end)

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

    local scale = (1 / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov

    if onScreen then
        SetTextScale(0.0 * scale, 0.55 * scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry('STRING')
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end
local QBCore = exports['qb-core']:GetCoreObject()

local function getRandomItem(items)
    return items[math.random(#items)]
end

local function getRandomAmount(itemType)
    if itemType == 'money' then
        return math.random(100, 500)
    elseif itemType == 'black_money' then
        return math.random(50, 200)
    elseif itemType == 'weapons' then
        return 1
    end
end

RegisterNetEvent('ender_robberysystem:attemptRobbery')
AddEventHandler('ender_robberysystem:attemptRobbery', function(targetId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Target = QBCore.Functions.GetPlayer(targetId)

    if not Player or not Target then
        TriggerClientEvent('QBCore:Notify', src, 'Invalid player', 'error')
        return
    end

    TriggerClientEvent('ender_robberysystem:startRobbery', src, targetId)
end)

RegisterNetEvent('ender_robberysystem:completeRobbery')
AddEventHandler('ender_robberysystem:completeRobbery', function(targetId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Target = QBCore.Functions.GetPlayer(targetId)

    if not Player or not Target then
        TriggerClientEvent('QBCore:Notify', src, 'Invalid player', 'error')
        return
    end

    local itemType = getRandomItem(Config.ItemsToSteal)
    local amount = getRandomAmount(itemType)

    if Config.InventoryType == 'ox_inventory' then
        exports.ox_inventory:AddItem(src, itemType, amount)
        exports.ox_inventory:RemoveItem(targetId, itemType, amount)
    elseif Config.InventoryType == 'qb-inventory' then
        Player.Functions.AddItem(itemType, amount)
        Target.Functions.RemoveItem(itemType, amount)
    end

    TriggerClientEvent('QBCore:Notify', src, 'You stole ' .. amount .. ' ' .. itemType, 'success')
    TriggerClientEvent('QBCore:Notify', targetId, 'You were robbed of ' .. amount .. ' ' .. itemType, 'error')

    MySQL.Async.execute('INSERT INTO player_robberies (player_id, target_id, amount, item_type) VALUES (?, ?, ?, ?)', {
        Player.PlayerData.citizenid,
        Target.PlayerData.citizenid,
        amount,
        itemType
    })
end)
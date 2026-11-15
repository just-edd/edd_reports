---@diagnostic disable: duplicate-set-field
---@diagnostic disable: duplicate-doc-field

if GetResourceState('qb-core') ~= 'started' then return end

Framework = { name = 'qb-core' }
local sharedObject = exports['qb-core']:GetCoreObject()
Framework.object = sharedObject
QBCore = sharedObject
---@class Player
---@field source number
---@field QBPlayer any
local player = {}

local codemInventory = GetResourceState('codem-inventory') == 'started'

function Framework.getPlayerFromId(id)
    local player = setmetatable({}, { __index = player })
    player.QBPlayer = sharedObject.Functions.GetPlayer(id)

    if not player.QBPlayer then return end

    player.source = id

    return player
end

function Framework.getPlayerFromIdentifier(identifier)
    local player = setmetatable({}, { __index = player })
    player.QBPlayer = sharedObject.Functions.GetPlayerByCitizenId(identifier)

    if not player.QBPlayer then return end

    player.source = player.QBPlayer.PlayerData.source

    return player
end

Framework.registerUsableItem = sharedObject.Functions.CreateUseableItem

Framework.getPlayers = sharedObject.Functions.GetQBPlayers

local ox_inventory = GetResourceState('ox_inventory') == 'started'
local qs_inventory = GetResourceState('qs-inventory') == 'started'
local one_inventory = GetResourceState('one_inventory') == 'started'

function Framework.getItemLabel(item)
    if ox_inventory then
        return exports.ox_inventory:Items()[item]?.label
    elseif qs_inventory then
        return exports['qs-inventory']:GetItemList()[item]?.label
    elseif codemInventory then
        return exports['codem-inventory']:GetItemList()[item]?.label
    elseif one_inventory then
        return exports.one_inventory:GetItemDefinition(item)?.label
    end

    return sharedObject.Shared.Items[item]?.label
end

function Framework.getItems()
    if ox_inventory then
        return exports.ox_inventory:Items()
    elseif qs_inventory then
        return exports['qs-inventory']:GetItemList()
    elseif codemInventory then
        return exports['codem-inventory']:GetItemList()
    elseif one_inventory then
        return exports.one_inventory:GetAllItemDefinitions()
    end

    return sharedObject.Shared.Items
end

function player:hasGroup(name)
    return sharedObject.Functions.HasPermission(self.source, name) == name
end

function player:hasOneOfGroups(groups)
    for k,v in pairs(groups) do
        if sharedObject.Functions.HasPermission(self.source, k) then
            return true
        end
    end

    return false
end

function player:addItem(name, count, metadata)
    count = count or 1

    if ox_inventory then
        if not exports.ox_inventory:CanCarryItem(self.source, name, count) then
            return false
        end

        exports.ox_inventory:AddItem(self.source, name, count, metadata)
        return true
    elseif codemInventory then
        return exports['codem-inventory']:AddItem(self.source, name, count, nil, metadata)
    elseif one_inventory then
        if not exports.one_inventory:CanCarryItem(self.source, name, count) then
            return false
        end

        return (exports.one_inventory:AddItem(self.source, name, count, metadata))
    else
        return self.QBPlayer.Functions.AddItem(name, count, nil, metadata) --[[@as boolean]]
    end
end

function player:removeItem(name, count)
    count = count or 1

    if ox_inventory then
        exports.ox_inventory:RemoveItem(self.source, name, count)
    elseif codemInventory then
        exports['codem-inventory']:RemoveItem(self.source, name, count)
    elseif one_inventory then
        exports.one_inventory:RemoveItem(self.source, name, count)
    else
        self.QBPlayer.Functions.RemoveItem(name, count)
    end
end

function player:canCarryItem(name, count)
    count = count or 1

    if ox_inventory then
        return exports.ox_inventory:CanCarryItem(self.source, name, count)
    end

    if codemInventory then
        return exports['codem-inventory']:CanCarryItem(self.source, name, count)
    end

    if one_inventory then
        return exports.one_inventory:CanCarryItem(self.source, name, count)
    end

    -- No equivalent for QBCore
    return true
end

function player:getItemCount(name)
    if ox_inventory then
        return exports.ox_inventory:GetItemCount(self.source, name)
    elseif codemInventory then
        return exports['codem-inventory']:GetItemsTotalAmount(self.source, name)
    elseif one_inventory then
        return exports.one_inventory:GetItemCount(self.source, name)
    else
        return self.QBPlayer.Functions.GetItemByName(name)?.amount or 0
    end
end

function player:hasItem(name)
    return self:getItemCount(name) > 0
end

function player:getAccountMoney(account)
    if account == 'money' then
        account = 'cash'
    end

    return self.QBPlayer.Functions.GetMoney(account)
end

function player:addAccountMoney(account, amount)
    if account == 'money' then
        account = 'cash'
    end

    self.QBPlayer.Functions.AddMoney(account, amount) 
end

function player:removeAccountMoney(account, amount)
    if account == 'money' then
        account = 'cash'
    end

    self.QBPlayer.Functions.RemoveMoney(account, amount)
end

function player:getJob()
    return self.QBPlayer.PlayerData.job.name
end

function player:getJobGrade()
    return self.QBPlayer.PlayerData.job.grade.level
end

function player:setJob(name, grade)
    return self.QBPlayer.Functions.SetJob(name, grade)
end

function player:setDuty(value)
    return self.QBPlayer.Functions.SetJobDuty(value)
end

function player:getIdentifier()   
    return self.QBPlayer.PlayerData.citizenid
end

function player:getFirstName()
    return self.QBPlayer.PlayerData.charinfo.firstname
end

function player:getLastName()
    return self.QBPlayer.PlayerData.charinfo.lastname
end
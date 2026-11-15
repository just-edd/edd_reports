---Checks if the player is staff (admin)
---@param source number
---@return boolean
local function isStaff(source)
    local player = Framework.getPlayerFromId(source)

    if not player then return false end

    for _, group in ipairs(Config.admin.groups) do
        if player:hasGroup(group) then
            return true
        end
    end

    return false
end

---Get player that owns the report
---@param reportId number
---@return string | nil
local function getReportOwner(reportId)
    return MySQL.scalar.await('SELECT createdBy FROM edd_reports WHERE reportId = ?', { reportId })
end

---Checks whether the player is allowed
---@param source number
---@param reportId number
---@return boolean
local function canAccess(source, reportId)
    local player = Framework.getPlayerFromId(source)
    if type(reportId) ~= 'number' or not player then return false end
    if isStaff(source) then return true end
    local owner = getReportOwner(reportId)
    return owner ~= nil and owner == player:getIdentifier()
end
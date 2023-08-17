g_specializationManager:addSpecialization("swather", "Swather", Utils.getFilename("scripts/Swather.lua", g_currentModDirectory), nil)

local function init()
    for vehicleName, vehicleType in pairs(g_vehicleTypeManager.types) do
        if SpecializationUtil.hasSpecialization(Mower, vehicleType.specializations) then
            g_vehicleTypeManager:addSpecialization(vehicleName, "swather")
        end
    end
end

init()

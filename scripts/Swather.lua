Swather = {}

function Swather.prerequisitesPresent(specializations)
    return SpecializationUtil.hasSpecialization(Mower, specializations)
end

function Swather.registerEventListeners(vehicleType)
    SpecializationUtil.registerEventListener(vehicleType, "onLoadFinished", Swather)
end

function Swather:onLoadFinished(savegame)
    if self.spec_mower ~= nil then
        local fruitTypeConverterName = self.xmlFile:getValue("vehicle.mower#fruitTypeConverter")

        if fruitTypeConverterName == "MOWER" or fruitTypeConverterName == "SWATHER" then
            local _, groundTypeFirstChannel, groundTypeNumChannels = g_currentMission.fieldGroundSystem:getDensityMapData(FieldDensityMap.GROUND_TYPE)
            local harvestReadyValue = g_currentMission.fieldGroundSystem:getFieldGroundValue(FieldGroundType.HARVEST_READY)
            local harvestReadyOtherValue = g_currentMission.fieldGroundSystem:getFieldGroundValue(FieldGroundType.HARVEST_READY_OTHER)
            self:addAITerrainDetailRequiredRange(harvestReadyValue, harvestReadyValue, groundTypeFirstChannel, groundTypeNumChannels)
            self:addAITerrainDetailRequiredRange(harvestReadyOtherValue, harvestReadyOtherValue, groundTypeFirstChannel, groundTypeNumChannels)
        end
    end
end

SwathingAddon = {}
local modDir = g_currentModDirectory

--- Register custom fillTypes.
function SwathingAddon.registerFillTypes(self, superFunc)
    superFunc(self)

    local xml = loadXMLFile("mod_fillTypes", modDir .. "xml/fillTypes.xml")
    g_fillTypeManager:loadFillTypes(xml, modDir, false, "FS22_SwathingAddon")
    delete(xml)
end

--- Register custom fruitTypes.
function SwathingAddon.registerFruitTypes(self, superFunc)
    superFunc(self)

    local xml = loadXMLFile("mod_fruitTypes", modDir .. "xml/fruitTypes.xml")
    g_fruitTypeManager:loadFruitTypes(xml, nil, false)
    delete(xml)
end

--- Register custom densityHeightTypes.
function SwathingAddon.registerDensityHeightTypes(self, superFunc, missionInfo, baseDirectory)
    local s = superFunc(self, missionInfo, baseDirectory)

    local xml = loadXMLFile("mod_densityMapHeightTypes", modDir .. "xml/densityMapHeightTypes.xml")
    g_densityMapHeightManager:loadDensityMapHeightTypes(xml, nil, modDir, false)
    delete(xml)

    return s
end

--- Register custom motionPathEffects.
function SwathingAddon.registerMotionPathEffects(self, superFunc, xmlFile, missionInfo, baseDirectory)
    local s = superFunc(self, xmlFile, missionInfo, baseDirectory)

    if fileExists(modDir .. "xml/motionPathEffects.xml") then
        local xml = loadXMLFile("mod_motionPathEffects", modDir .. "xml/motionPathEffects.xml")
        local i = 0

        while true do
            local filename = getXMLString(xml, "motionPathEffects.motionPathEffect(" .. i .. ")#filename")

            if filename ~= nil then
                g_motionPathEffectManager:loadMotionPathEffectsXML(filename, modDir, "FS22_SwathingAddon")
            else
                break
            end
            i = i + 1
        end

        delete(xml)
    end

    return s
end

FillTypeManager.loadDefaultTypes = Utils.overwrittenFunction(FillTypeManager.loadDefaultTypes, SwathingAddon.registerFillTypes)
FruitTypeManager.loadDefaultTypes = Utils.overwrittenFunction(FruitTypeManager.loadDefaultTypes, SwathingAddon.registerFruitTypes)
DensityMapHeightManager.loadDefaultTypes = Utils.overwrittenFunction(DensityMapHeightManager.loadDefaultTypes, SwathingAddon.registerDensityHeightTypes)
MotionPathEffectManager.loadMapData = Utils.overwrittenFunction(MotionPathEffectManager.loadMapData, SwathingAddon.registerMotionPathEffects)

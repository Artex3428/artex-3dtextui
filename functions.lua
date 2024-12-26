local keyMap = {
    [34] = "A",
    [29] = "B",
    [26] = "C",
    [30] = "D",
    [46] = "E",
    [49] = "F",
    [47] = "G",
    [74] = "H",
    [311] = "K",
    [7] = "L",
    [244] = "M",
    [249] = "N",
    [199] = "P",
    [44] = "Q",
    [45] = "R",
    [33] = "S",
    [245] = "T",
    [303] = "U",
    [0] = "V",
    [32] = "W",
    [73] = "X",
    [246] = "Y",
    [20] = "Z",
    [27] = "Up Arrow",
    [173] = "Down Arrow",
    [174] = "Left Arrow",
    [175] = "Right Arrow",
    [19] = "Left Alt",
    [344] = "F11",
    [157] = "Numpad 1",
    [158] = "Numpad 2",
    [160] = "Numpad 3",
    [164] = "Numpad 4",
    [165] = "Numpad 5",
    [159] = "Numpad 6",
    [161] = "Numpad 7",
    [162] = "Numpad 8",
    [163] = "Numpad 9",
    [36] = "Left Ctrl",
    [21] = "Left Shift",
    [18] = "Left Alt",
    [201] = "Enter",
    [177] = "Backspace",
    [178] = "Delete",
    [243] = "Home",
    [250] = "Insert",
    [251] = "Page Up",
    [252] = "Page Down",
    [253] = "End",
    [254] = "Caps Lock",
    [255] = "Scroll Lock"
}

function DrawText3d(text, targetCoords)
    local camCoords = GetFinalRenderedCamCoord()
    local playerPed = PlayerPedId()
    local rayHandle = StartShapeTestRay(camCoords.x, camCoords.y, camCoords.z, targetCoords.x, targetCoords.y, targetCoords.z, 1, playerPed, 0)
    local _, hit, hitCoords, hitEntity, _ = GetShapeTestResult(rayHandle)

    if hit == 1 then
        return 'Obstructed by a wall or object'
    end

    local onScreen, _x, _y = World3dToScreen2d(targetCoords.x, targetCoords.y, targetCoords.z)

    if onScreen then
        SetTextScale(0.38, 0.38)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(Config.TxtColor.r, Config.TxtColor.g, Config.TxtColor.b, Config.TxtColor.a)
        SetTextEntry("STRING")
        SetTextCentre(1)

        AddTextComponentString(text)
        DrawText(_x, _y)

        local factor = string.len(text) / 370
        DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, Config.BgColor.r, Config.BgColor.g, Config.BgColor.b, Config.BgColor.a)
    end

    return onScreen
end

function StartText3d(text, advancedText, keyInput, action, ownText, coords, isGlobalDistance, isCloseDistance, isOnlyOnControlHold, isNotAdvacedText, callback)
    local keyName = keyMap[keyInput] or "Unknown Key"
    local message = string.format("Press [~g~%s~w~] to %s %s", string.upper(keyName), string.lower(action), string.lower(text))
    IsCloseToPoint = false
    local distance = #(GetEntityCoords(PlayerPedId()) - coords)

    if distance < isGlobalDistance then
    else
        Citizen.Wait(1000)
    end

    if not isNotAdvacedText then
        if distance < isCloseDistance then
            IsCloseToPoint = true
            if ownText == "" then
                DrawText3d(message, coords)
            else
                DrawText3d(ownText, coords)
            end
            if IsControlJustPressed(0, keyInput) then
                if callback and type(callback) == "table" then
                    callback()
                else
                    print("No valid callback provided")
                end
            end
        end
    end
    if isOnlyOnControlHold then
        if IsControlPressed(0, Config.HoldControl) then
            if isGlobalDistance >= 0.1 then
                if distance < isGlobalDistance then
                    if not advancedText then
                    else
                        if distance < isGlobalDistance and not IsCloseToPoint then
                            DrawText3d(text, coords)
                        end
                    end
                end
            elseif isGlobalDistance <= 0.0 then
                DrawText3d(text, GetEntityCoords(PlayerPedId()))
            end
        end
    else
        if isGlobalDistance >= 0.1 then
            if not advancedText then
            else
                if distance < isGlobalDistance and not IsCloseToPoint then
                    DrawText3d(text, coords)
                end
            end
        elseif isGlobalDistance <= 0.0 then
            DrawText3d(text, GetEntityCoords(PlayerPedId()))
        end
    end
end

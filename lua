local a1b2c3 = false
local d4e5f6 = guiCreateWindow(0.3, 0.3, 0.4, 0.4, "OMGPNC Trolls", true)
guiSetVisible(d4e5f6, false)

local g7h8i9 = guiCreateTabPanel(0.05, 0.1, 0.9, 0.75, true, d4e5f6)
local j0k1l2 = guiCreateTab("Trolls", g7h8i9)

local m3n4o5 = guiCreateLabel(0.05, 0.1, 0.4, 0.1, "Player Name:", true, j0k1l2)
local p6q7r8 = guiCreateEdit(0.45, 0.1, 0.5, 0.1, "", true, j0k1l2)

local s9t0u1 = guiCreateButton(0.1, 0.3, 0.3, 0.1, "Explode Player", true, j0k1l2)
local v2w3x4 = guiCreateButton(0.6, 0.3, 0.3, 0.1, "Damage Player", true, j0k1l2)
local y5z6a7 = guiCreateButton(0.1, 0.5, 0.3, 0.1, "Fire on Player", true, j0k1l2)
local b8c9d0 = guiCreateButton(0.6, 0.5, 0.3, 0.1, "Smoke on Player", true, j0k1l2)
local e1f2g3 = guiCreateButton(0.35, 0.7, 0.3, 0.1, "Crazy Car", true, j0k1l2)

local h1i2j3 = guiCreateLabel(0.05, 0.85, 0.9, 0.1, "OMGPNC TEAM", true, d4e5f6)
guiSetFont(h1i2j3, "default-bold-small")
guiLabelSetColor(h1i2j3, 255, 0, 0)
guiLabelSetHorizontalAlign(h1i2j3, "center", true)
guiSetVisible(h1i2j3, false)

function i4j5k6()
    a1b2c3 = not a1b2c3
    guiSetVisible(d4e5f6, a1b2c3)
    guiSetVisible(h1i2j3, a1b2c3)
    showCursor(a1b2c3)
end

function l7m8n9(o)
    for _, p in ipairs(getElementsByType("player")) do
        if getPlayerName(p) == o then
            return p
        end
    end
    return nil
end

function o0p1q2(r)
    local s = l7m8n9(r)
    if s then
        local t, u, v = getElementPosition(s)
        local w = createProjectile(localPlayer, 19, t, u, v + 2)
        local x, y, z = getElementPosition(s)
        local a, b, c = (x - t) * 0.1, (y - u) * 0.1, (z - v) * 0.1
        setElementVelocity(w, a, b, c)
    else
        outputChatBox("Player not found!", 255, 0, 0)
    end
end

addEventHandler("onClientGUIClick", s9t0u1, function()
    local d = guiGetText(p6q7r8)
    if d and d ~= "" then
        o0p1q2(d)
    else
        outputChatBox("Please enter a player name.", 255, 0, 0)
    end
end, false)

function r3s4t5(u, v)
    local w = l7m8n9(u)
    if w then
        setElementHealth(w, getElementHealth(w) - v)
        if getElementHealth(w) <= 0 then
            killPed(w)
        end
    else
        outputChatBox("Player not found!", 255, 0, 0)
    end
end

addEventHandler("onClientGUIClick", v2w3x4, function()
    local x = guiGetText(p6q7r8)
    if x and x ~= "" then
        r3s4t5(x, 100)
    else
        outputChatBox("Please enter a player name.", 255, 0, 0)
    end
end, false)

function t6u7v8(x)
    local y = l7m8n9(x)
    if y then
        local z, a, b = getElementPosition(y)
        createExplosion(z, a, b, 8)
        outputChatBox("Toxic effect applied to " .. x, 0, 255, 0)
    else
        outputChatBox("Player not found!", 255, 0, 0)
    end
end

addEventHandler("onClientGUIClick", b8c9d0, function()
    local c = guiGetText(p6q7r8)
    if c and c ~= "" then
        t6u7v8(c)
    else
        outputChatBox("Please enter a player name.", 255, 0, 0)
    end
end, false)

function u8v9w0(x)
    local y = l7m8n9(x)
    if y then
        local z = getPedOccupiedVehicle(localPlayer)
        if z then
            local a, b, c = getElementPosition(y)
            setElementPosition(z, a, b, c + 1)
            local d = 50
            setElementVelocity(z, d, 0, 0)
            local e, f, g = getElementPosition(z)
            setTimer(function()
                if isElement(z) then
                    setElementPosition(z, e, f, g)
                    setElementVelocity(z, 0, 0, 0)
                end
            end, 5000, 1)
        else
            outputChatBox("You are not in a vehicle!", 255, 0, 0)
        end
    else
        outputChatBox("Player not found!", 255, 0, 0)
    end
end

addEventHandler("onClientGUIClick", e1f2g3, function()
    local h = guiGetText(p6q7r8)
    if h and h ~= "" then
        u8v9w0(h)
    else
        outputChatBox("Please enter a player name.", 255, 0, 0)
    end
end, false)

bindKey("N", "down", i4j5k6)

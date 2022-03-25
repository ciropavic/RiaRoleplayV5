key_to_teleport = 38

positions = {
    --[[
    {{Teleport1 X, Teleport1 Y, Teleport1 Z, Teleport1 Heading}, {Teleport2 X, Teleport 2Y, Teleport 2Z, Teleport2 Heading}, {Red, Green, Blue}, "Text for Teleport"}
    ]]
    {{-473.32, -94.61, 39.16, 0}, {-1569.56, -3017.34, -74.11, 0},{255, 157, 0}, "Clube Giriş/Çıkış yapmak için ~r~E~r~ tuşuna tıklayınız"}, --GECE KLUBÜ
    {{-458.32, -51.61, 44.16, 0}, {-1641.56, -2990.34, -77.11, 271.01},{255, 157, 0}, "Clup ARAÇ Giriş/Çıkışı yapmak için ~r~E~r~ tuşuna tıklayınız"},   
    {{416.68, -213.25, 70.67, 0}, {411.96, -207.26, 59.67, 271.01},{255, 157, 0}, "Çatı  Giriş/Çıkışı yapmak için ~r~E~r~ tuşuna tıklayınız"},
}

-----------------------------------------------------------------------------
-------------------------DO NOT EDIT BELOW THIS LINE-------------------------
-----------------------------------------------------------------------------

local player = PlayerPedId()

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(5)
        local player = PlayerPedId()
        local playerLoc = GetEntityCoords(player)

        for _,location in ipairs(positions) do
            teleport_text = location[4]
            loc1 = {
                x=location[1][1],
                y=location[1][2],
                z=location[1][3],
                heading=location[1][4]
            }
            loc2 = {
                x=location[2][1],
                y=location[2][2],
                z=location[2][3],
                heading=location[2][4]
            }
            Red = location[3][1]
            Green = location[3][2]
            Blue = location[3][3]

            DrawMarker(21, loc1.x, loc1.y, loc1.z, 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.7, Red, Green, Blue, 200, 0, 0, 0, 2)
            DrawMarker(21, loc2.x, loc2.y, loc2.z, 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.7, Red, Green, Blue, 200, 0, 0, 0, 2)

            if CheckPos(playerLoc.x, playerLoc.y, playerLoc.z, loc1.x, loc1.y, loc1.z, 2) then 
                alert(teleport_text)
                
                if IsControlJustReleased(1, key_to_teleport) then
                    if IsPedInAnyVehicle(player, true) then
                        SetEntityCoords(GetVehiclePedIsUsing(player), loc2.x, loc2.y, loc2.z)
                        SetEntityHeading(GetVehiclePedIsUsing(player), loc2.heading)
                    else
                        SetEntityCoords(player, loc2.x, loc2.y, loc2.z)
                        SetEntityHeading(player, loc2.heading)
                    end
                end

            elseif CheckPos(playerLoc.x, playerLoc.y, playerLoc.z, loc2.x, loc2.y, loc2.z, 2) then
                alert(teleport_text)

                if IsControlJustReleased(1, key_to_teleport) then
                    if IsPedInAnyVehicle(player, true) then
                        SetEntityCoords(GetVehiclePedIsUsing(player), loc1.x, loc1.y, loc1.z)
                        SetEntityHeading(GetVehiclePedIsUsing(player), loc1.heading)
                    else
                        SetEntityCoords(player, loc1.x, loc1.y, loc1.z)
                        SetEntityHeading(player, loc1.heading)
                    end
                end
            end            
        end
    end
end)

function CheckPos(x, y, z, cx, cy, cz, radius)
    local t1 = x - cx
    local t12 = t1^2

    local t2 = y-cy
    local t21 = t2^2

    local t3 = z - cz
    local t31 = t3^2

    return (t12 + t21 + t31) <= radius^2
end

function alert(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end
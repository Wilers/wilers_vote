local display = false

-- Command
RegisterCommand("vote", function(source, args)
    SetDisplay(not display)
end)

-- Fermeture du Menu
RegisterNUICallback('exit', function(data)
    SetDisplay(false)
end)

function SetDisplay(bool)
    display = bool
    -- Animation
    if Config.Anim then
        if bool then
            startAnim()
        else
            stopAnim()
        end
    end
    -- NUI
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        lien = Config.Lien,
        status = bool,
    })
end

-- Desactivation de certaines touches lors de l'activation du menu
Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        DisableControlAction(0, 1, display)
        DisableControlAction(0, 2, display)
        DisableControlAction(0, 142, display)
        DisableControlAction(0, 18, display)
        DisableControlAction(0, 322, display)
        DisableControlAction(0, 106, display)
    end
end)

-- Fonction debut Animation
function startAnim()
    Citizen.CreateThread(function()
        RequestAnimDict("amb@world_human_seat_wall_tablet@female@base")
        while not HasAnimDictLoaded("amb@world_human_seat_wall_tablet@female@base") do
            Citizen.Wait(0)
        end
        attachObject()
        TaskPlayAnim(PlayerPedId(), "amb@world_human_seat_wall_tablet@female@base", "base", 8.0, -8.0, -1, 50, 0, false, false, false)
    end)
end

-- Prop tablette dans les mains
function attachObject()
    tab = CreateObject(GetHashKey("prop_cs_tablet"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(tab, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.17, 0.10, -0.13, 20.0, 180.0, 180.0, true, true, false, true, 1, true)
end

-- Fonction fermeture Animation
function stopAnim()
    StopAnimTask(PlayerPedId(), "amb@world_human_seat_wall_tablet@female@base", "base", 8.0, -8.0, -1, 50, 0, false, false, false)
    DeleteEntity(tab)
end
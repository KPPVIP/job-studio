Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

-- MENU FUNCTION --

local open = false 
local studioDeTesMort = RageUI.CreateMenu('Garage', 'Bienvenue sur le Garage du Studio')
studioDeTesMort.Display.Header = true 
studioDeTesMort.Closed = function()
  open = false
end

function OpenTesMortstudio()
     if open then 
         open = false
         RageUI.Visible(studioDeTesMort, false)
         return
     else
         open = true 
         RageUI.Visible(studioDeTesMort, true)
         CreateThread(function()
         while open do 
            RageUI.IsVisible(studioDeTesMort,function() 

              RageUI.Button("Ranger le véhicule", nil, {RightLabel = "→→"}, true , {
                onSelected = function()
                  local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                  if dist4 < 4 then
                      DeleteEntity(veh)
                      RageUI.CloseAll()
                end
              end, })


               RageUI.Separator("↓ ~b~Gestion Véhicule ~s~ ↓")

                RageUI.Button("Véhicule Fete", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                      local model = GetHashKey("pbus2")
                      RequestModel(model)
                      while not HasModelLoaded(model) do Citizen.Wait(10) end
                      local pos = GetEntityCoords(PlayerPedId())
                      local vehicle = CreateVehicle(model, -988.96, -302.22, 37.8, 205.91, true, true)
                    end
                })
                
                RageUI.Button("Véhicule Employé", nil, {RightLabel = "→→"}, true , {
                  onSelected = function()
                    local model = GetHashKey("sultanrs")
                    RequestModel(model)
                    while not HasModelLoaded(model) do Citizen.Wait(10) end
                    local pos = GetEntityCoords(PlayerPedId())
                    local vehicle = CreateVehicle(model, -988.96, -302.22, 37.8, 205.91, true, true)
                  end
              })


           end)
          Wait(0)
         end
      end)
   end
end

----OUVRIR LE MENU------------

local position = {
	{x = -969.6, y = -266.36, z = 38.55}
}

Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(position) do
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'studio' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 15.0 then
            wait = 0
            DrawMarker(21, -969.6, -266.36, 38.55, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 255, 235, 59, 255, true, true, p19, true)  

        
            if dist <= 1.0 then
               wait = 0
                Visual.Subtitle("Appuyer sur ~b~E~w~ pour intéragir", 1) 
                if IsControlJustPressed(1,51) then
                  OpenTesMortstudio()
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)

--- BLIPS ---

Citizen.CreateThread(function()

  local blip = AddBlipForCoord(-1007.03, -265.16, 56.55) 

  SetBlipSprite (blip, 135) -- Model du blip
  SetBlipDisplay(blip, 4)
  SetBlipScale  (blip, 0.7) -- Taille du blip
  SetBlipColour (blip, 1) -- Couleur du blip
  SetBlipAsShortRange(blip, true)

  BeginTextCommandSetBlipName('STRING')
  AddTextComponentSubstringPlayerName('Studio')
  EndTextCommandSetBlipName(blip)
end)


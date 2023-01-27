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
local studioMain2 = RageUI.CreateMenu('Studio', 'Interaction')
local subMenu5 = RageUI.CreateSubMenu(studioMain2, "Annonces", "Interaction")
local studioMenu6 = RageUI.CreateSubMenu(studioMain2, "~rMatériel Mobile", "Interaction")
studioMain2.Display.Header = true 
studioMain2.Closed = function()
  open = false
end

function OpenMenustudio()
	if open then 
		open = false
		RageUI.Visible(studioMain2, false)
		return
	else
		open = true 
		RageUI.Visible(studioMain2, true)
		CreateThread(function()
		while open do 
		   RageUI.IsVisible(studioMain2,function() 

			RageUI.Separator("↓ Annonces ↓")
			RageUI.Button("Annonces", nil, {RightLabel = "→→"}, true , {
				onSelected = function()
				end
			}, subMenu5)


			RageUI.Separator("↓ Facture ↓")
			RageUI.Button("Faire une Facture", nil, {RightLabel = "→→"}, true , {
				onSelected = function()
					OpenBillingMenu2()
                    RageUI.CloseAll()
				end
			})

		
		
			RageUI.Separator("↓ Matériel ↓")
			RageUI.Button("Pour accéder au matériel mobile", nil, {RightLabel = "→→"}, true , {
				onSelected = function()
				end
			}, studioMenu6)


			end)
			


			RageUI.IsVisible(studioMenu6,function() 

	
				RageUI.Button("Micro main gauche", nil, {RightLabel = "→→"}, true , {
					onSelected = function()
						TriggerEvent('Mic:ToggleMic')
					end
				})
				RageUI.Button("Caméra", nil, {RightLabel = "→→"}, true , {
					onSelected = function()
						TriggerEvent('Cam:ToggleCam')
					end
				})


				RageUI.Button("Perche Son", nil, {RightLabel = "→→"}, true , {
					onSelected = function()
						TriggerEvent('Mic:ToggleBMic')
					end
				})


			end)

			RageUI.IsVisible(subMenu5,function() 

				RageUI.Button("Annonce Ouvertures", nil, {RightLabel = "→"}, true , {
					onSelected = function()
						TriggerServerEvent('Ouvre:studio')
					end
				})
				
				RageUI.Button("Annonce Recrutement", nil, {RightLabel = "→"}, true , {
					onSelected = function()
						TriggerServerEvent('Recru:studio')
					end
				})

				RageUI.Button("Annonce Fermetures", nil, {RightLabel = "→"}, true , {
					onSelected = function()
						TriggerServerEvent('Ferme:studio')
					end
				})
				RageUI.Button("Annonce Personnalisé", nil, {RightLabel = "→"}, true , {
					 onSelected = function()
						local te = KeyboardInput("Message", "", 100)
						ExecuteCommand("voit" ..te)
					end
				})

				end)
		 Wait(0)
		end
	 end)
  end
end

-- FUNCTION BILLING --

function OpenBillingMenu2()

	ESX.UI.Menu.Open(
	  'dialog', GetCurrentResourceName(), 'billing',
	  {
		title = "Facture"
	  },
	  function(data, menu)
	  
		local amount = tonumber(data.value)
		local player, distance = ESX.Game.GetClosestPlayer()
  
		if player ~= -1 and distance <= 3.0 then
  
		  menu.close()
		  if amount == nil then
			  ESX.ShowNotification("~r~Problèmes~s~: Montant invalide")
		  else
			local playerPed        = GetPlayerPed(-1)
			TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
			Citizen.Wait(5000)
			  TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_studio', ('mechanic'), amount)
			  Citizen.Wait(100)
			  ESX.ShowNotification("~r~Vous avez bien envoyer la facture")
		  end
  
		else
		  ESX.ShowNotification("~r~Problèmes~s~: Aucun joueur à proximitée")
		end
  
	  end,
	  function(data, menu)
		  menu.close()
	  end
	)
  end

-- OUVERTURE DU MENU --

Keys.Register('F6', 'Macdonalds', 'Ouvrir le menu studio', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'studio' then
    	OpenMenustudio()
	end
end)
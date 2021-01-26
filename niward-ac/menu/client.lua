Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent(ClConfig.ESXGetSharedObject , function(obj)
			ESX = obj
		end)
		Citizen.Wait(0)
	end
end)

local isStaffLocal  = 0
local onlineplayers = {}
local totalplayers  = 0
local returncoords  = {}

Citizen.CreateThread(function()
	TriggerServerEvent('niward-ac:getPermissionLevelMenu')
end)

RegisterNetEvent('niward-ac:setPermissionLevelMenu')
AddEventHandler('niward-ac:setPermissionLevelMenu' , function(isStaff)
	if (isStaff) then
		isStaffLocal = 1
		TriggerServerEvent('niward-ac:staffLogs' , GetPlayerServerId(PlayerId()) , "Admin Menu enabled.")
	end
end)

RegisterNetEvent('niward-ac-menu:updateConnectedPlayers')
AddEventHandler('niward-ac-menu:updateConnectedPlayers' , function(connectedPlayers)
	onlineplayers = connectedPlayers
end)

RegisterNetEvent('niward-ac-menu:freezeplayer')
AddEventHandler('niward-ac-menu:freezeplayer' , function()
	FreezeEntityPosition(PlayerPedId() , true)
	if IsPedInAnyVehicle(PlayerPedId() , false) then
		FreezeEntityPosition(GetVehiclePedIsIn(PlayerPedId() , false) , true)
	end
end)

if ClConfig.QuantityResources and isStaffLocal == 0 then
	function collectAndSendResourceList()
		local resourceList = {}
		for i = 0 , GetNumResources() - 1 do
			resourceList[i + 1] = GetResourceByFindIndex(i)
		end
		TriggerServerEvent("niward-ac:checkResources" , resourceList)
	end
	
	CreateThread(function()
		while true do
			Wait(5000)
			collectAndSendResourceList()
		end
	end)
end

RegisterNetEvent('niward-ac-menu:unfreezeplayer')
AddEventHandler('niward-ac-menu:unfreezeplayer' , function()
	FreezeEntityPosition(PlayerPedId() , false)
	if IsPedInAnyVehicle(PlayerPedId() , false) then
		FreezeEntityPosition(GetVehiclePedIsIn(PlayerPedId() , false) , false)
	end
end)

RegisterNetEvent('niward-ac-menu:dospectate')
AddEventHandler('niward-ac-menu:dospectate' , function(targetid , oldcoord , newcoord)
	SetEntityCoords(PlayerPedId() , newcoord.x , newcoord.y , newcoord.z - 10.0 , 0 , 0 , 0 , false)
	Wait(500)
	local playerId = GetPlayerFromServerId(targetid)
	spectatePlayer(GetPlayerPed(playerId) , playerId , GetPlayerName(targetid))
	Wait(500)
	if oldcoord == newcoord then
	
	else
		returncoords = oldcoord
	end
end)

Citizen.CreateThread(function()
	if ClConfig.AdminMenuEnabled then
		Citizen.Wait(5000)
		if isStaffLocal == 1 then
			local blipsEnabled = false
			local namesEnabled = false
			local noclip       = false
			local noclip_speed = 3.0
			
			Citizen.CreateThread(function()
				while true do
					Citizen.Wait(0)
					if isStaffLocal == 1 then
						if IsControlJustReleased(0 , ClConfig.AdminMenuKey) then
							openMainMenu()
						end
						
						if noclip then
							local ped          = GetPlayerPed(-1)
							local x , y , z    = getPosition()
							local dx , dy , dz = getCamDirection()
							local speed        = noclip_speed
							
							-- Resetear velocidad
							SetEntityVelocity(ped , 0.0001 , 0.0001 , 0.0001)
							
							if IsControlPressed(0 , 32) then
								x = x + speed * dx
								y = y + speed * dy
								z = z + speed * dz
							end
							
							if IsControlPressed(0 , 269) then
								x = x - speed * dx
								y = y - speed * dy
								z = z - speed * dz
							end
							
							SetEntityCoordsNoOffset(ped , x , y , z , true , true , true)
						end
						
						if frozen then
							FreezeEntityPosition(PlayerPedId() , frozen)
							if IsPedInAnyVehicle(PlayerPedId() , true) then
								FreezeEntityPosition(GetVehiclePedIsIn(PlayerPedId() , false) , frozen)
							end
						end
						
						if drawInfo then
							local text      = {}
							-- cheat checks
							local targetPed = GetPlayerPed(drawTarget)
							local targetGod = GetPlayerInvincible(drawTarget)
							if targetGod then
								table.insert(text , "GodMode: ~r~DETECTED")
							else
								table.insert(text , "GodMode: ~g~NOT DETECTED")
							end
							if not CanPedRagdoll(targetPed) and not IsPedInAnyVehicle(targetPed , false) and (GetPedParachuteState(targetPed) == -1 or GetPedParachuteState(targetPed) == 0) and not IsPedInParachuteFreeFall(targetPed) then
								table.insert(text , "ANTI-RAGDOLL ENABLED")
							end
							-- health info
							table.insert(text , "HEALTH: " .. GetEntityHealth(targetPed) .. "/" .. GetEntityMaxHealth(targetPed))
							table.insert(text , "ARMOR: " .. GetPedArmour(targetPed))
							-- misc info
							
							table.insert(text , "Press [E] to exit Spectator Mode")
							
							for i , theText in pairs(text) do
								SetTextFont(0)
								SetTextProportional(1)
								SetTextScale(0.0 , 0.30)
								SetTextDropshadow(0 , 0 , 0 , 0 , 255)
								SetTextEdge(1 , 0 , 0 , 0 , 255)
								SetTextDropShadow()
								SetTextOutline()
								SetTextEntry("STRING")
								AddTextComponentString(theText)
								EndTextCommandDisplayText(0.3 , 0.7 + (i / 30))
							end
							
							if IsControlJustPressed(0 , 103) then
								local targetPed                   = PlayerPedId()
								local targetx , targety , targetz = table.unpack(GetEntityCoords(targetPed , false))
								
								RequestCollisionAtCoord(targetx , targety , targetz)
								NetworkSetInSpectatorMode(false , targetPed)
								FreezeEntityPosition(PlayerPedId() , false)
								SetEntityCoords(PlayerPedId() , returncoords.x , returncoords.y , returncoords.z + 1.0 , 0 , 0 , 0 , false)
								
								StopDrawPlayerInfo()
								ESX.ShowNotification("Stopped Spectating")
							end
						
						end
					end
				end
			end)
			
			function openMainMenu()
				if isStaffLocal == 1 then
					ESX.UI.Menu.CloseAll()
					local elements = {
						{ label = "Self Menu", value = "selfMenu" },
						{ label = "Online Menu", value = "onlineMenu" },
						{ label = "Delete Menu", value = "deleteMenu" },
						{ label = "Vehicle Options", value = "vehicleMenu" },
					}
					
					ESX.UI.Menu.Open(
							'default' , GetCurrentResourceName() , 'niwardacmainmenu' ,
							{
								title    = "NIWARD-AC | MAIN MENU",
								align    = 'bottom-right',
								elements = elements
							} ,
							function(data , menu)
								if data.current.value == "selfMenu" then
									ESX.UI.Menu.CloseAll()
									selfMenu()
								elseif data.current.value == "onlineMenu" then
									ESX.UI.Menu.CloseAll()
									onlineMenu()
								elseif data.current.value == "deleteMenu" then
									ESX.UI.Menu.CloseAll()
									deleteMenu()
								elseif data.current.value == "vehicleMenu" then
									ESX.UI.Menu.CloseAll()
									vehicleMenu()
								end
								isMenuOpened = false
							end ,
							function(data , menu)
								isMenuOpened = false
								menu.close()
							end)
				end
			end
			
			function selfMenu()
				local elements = {}
				if isStaffLocal == 1 then
					ESX.UI.Menu.CloseAll()
					local actions = {
						{ label = "Noclip", value = "noclip" },
						{ label = "Player Names", value = "playerName" },
						{ label = "Player Blips", value = "playerBlips" },
					}
					
					for i , v in pairs(actions) do
						if v.value == "noclip" and noclip == true then
							table.insert(elements , { label = v.label .. " <span style='color: green;'>enabled</span>", value = v.value })
						elseif v.value == "noclip" and noclip == false then
							table.insert(elements , { label = v.label .. " <span style='color: red;'>disabled</span>", value = v.value })
						elseif v.value == "playerName" and namesEnabled == true then
							table.insert(elements , { label = v.label .. " <span style='color: green;'>enabled</span>", value = v.value })
						elseif v.value == "playerName" and namesEnabled == false then
							table.insert(elements , { label = v.label .. " <span style='color: red;'>disabled</span>", value = v.value })
						elseif v.value == "playerBlips" and blipsEnabled == true then
							table.insert(elements , { label = v.label .. " <span style='color: green;'>enabled</span>", value = v.value })
						elseif v.value == "playerBlips" and blipsEnabled == false then
							table.insert(elements , { label = v.label .. " <span style='color: red;'>disabled</span>", value = v.value })
						else
							table.insert(elements , { label = v.label, value = v.value })
						end
					end
					
					ESX.UI.Menu.Open(
							'default' , GetCurrentResourceName() , 'niwardacmainmenu2' ,
							{
								title    = "NIWARD-AC | SELF MENU",
								align    = 'bottom-right',
								elements = elements
							} ,
							function(data , menu)
								if data.current.value == "noclip" then
									ESX.UI.Menu.CloseAll()
									TriggerEvent('niward-ac:nocliped')
								elseif data.current.value == "playerName" then
									ESX.UI.Menu.CloseAll()
									TriggerEvent('niward-ac:playerName')
								elseif data.current.value == "playerBlips" then
									ESX.UI.Menu.CloseAll()
									TriggerEvent('niward-ac:playerBlips')
								end
								isMenuOpened = false
							end ,
							function(data , menu)
								isMenuOpened = false
								menu.close()
								openMainMenu()
							end)
				end
			end
			
			function onlineMenu()
				if isStaffLocal == 1 then
					ESX.UI.Menu.CloseAll()
					local elements = {}
					totalplayers   = 0
					for k , v in pairs(onlineplayers) do
						totalplayers = totalplayers + 1
						table.insert(elements , { label = v.label, value = v.value })
					end
					
					ESX.UI.Menu.Open(
							'default' , GetCurrentResourceName() , 'niwardacmainmenu3' ,
							{
								title    = "NIWARD-AC | ONLINE MENU | TOTAL PLAYERS: " .. tostring(totalplayers),
								align    = 'bottom-right',
								elements = elements
							} ,
							function(data , menu)
								if data.current.value == "search" then
									ESX.UI.Menu.CloseAll()
									ESX.UI.Menu.Open('dialog' , GetCurrentResourceName() , 'menuDiag' , {
										title = 'Search Player'
									} ,
									                 function(data2 , menu2)
										                 local search = data2.value
										                 menu2.close()
										                 local ret = {}
										
										                 for k , v in pairs(onlineplayers) do
											                 local player = v.value
											                 if (player ~= nil) then
												                 local player_name = GetPlayerName(player)
												                 local esnumero    = tonumber(search)
												                 if esnumero then
													                 if (player == search) then
														                 table.insert(ret , { label = v.label, value = player })
														                 break
													                 end
												                 elseif string.find(string.lower(tostring(player_name)) , string.lower(tostring(search)) , 1 , true) then
													                 table.insert(ret , { label = v.label, value = player })
												                 end
											                 end
										                 end
										                 ESX.UI.Menu.Open(
												                 'default' , GetCurrentResourceName() , 'nwacsearchmenu' ,
												                 {
													                 title    = "NIWARD-AC | ONLINE MENU | SEARCH RESULT",
													                 align    = 'bottom-right',
													                 elements = ret
												                 } ,
												                 function(data3 , menu3)
													                 ESX.UI.Menu.CloseAll()
													                 OpenSubOnlineMenu(data3.current.value , data3.current.label)
													                 isMenuOpened = false
												                 end ,
												                 function(data3 , menu3)
													                 isMenuOpened = false
													                 menu3.close()
													                 openMainMenu()
												                 end)
									
									                 end ,
									                 function(data2 , menu2)
										                 menu2.close()
									                 end)
								elseif data.current.value == "nothing" then
								else
									ESX.UI.Menu.CloseAll()
									OpenSubOnlineMenu(data.current.value , data.current.label)
									isMenuOpened = false
								end
							end ,
							function(data , menu)
								isMenuOpened = false
								menu.close()
								openMainMenu()
							end)
				end
			end
			
			function OpenSubOnlineMenu(plyId , plyName)
				local selectedPlayer = GetPlayerFromServerId(tonumber(plyId))
				
				local elements       = {
					{ label = 'Spectate', value = 'spectate' },
					{ label = 'Kick', value = 'kick' },
					{ label = 'Go to Player', value = 'goto' },
					{ label = 'Bring', value = 'bring' },
					{ label = 'Freeze', value = 'freeze' },
					{ label = 'Unfreeze', value = 'unfreeze' },
					{ label = 'Kill', value = 'kill' },
					{ label = 'Manual Ban', value = 'manualBan' }
				}
				
				ESX.UI.Menu.Open('default' , GetCurrentResourceName() , 'player_menu' , { title = 'PLAYER: ' .. plyName, align = 'bottom-right', elements = elements } , function(data , menu)
					if data.current.value == 'spectate' then
						local oldCoords = GetEntityCoords(PlayerPedId())
						FreezeEntityPosition(PlayerPedId() , true)
						TriggerServerEvent('niward-ac-menu:requestSpectate' , plyId , oldCoords)
					elseif data.current.value == 'kick' then
						ESX.UI.Menu.Open('dialog' , GetCurrentResourceName() , 'menuDiag' , {
							title = 'Kick Reason'
						} ,
						                 function(data2 , menu2)
							                 local text = data2.value
							                 menu2.close()
							                 TriggerServerEvent('niward-ac-menu:kickplayer' , plyId , text)
						                 end ,
						                 function(data2 , menu2)
							                 menu2.close()
						                 end)
					elseif data.current.value == 'goto' then
						TriggerServerEvent('niward-ac-menu:gotoplayer' , plyId)
					elseif data.current.value == 'bring' then
						TriggerServerEvent('niward-ac-menu:bringplayer' , plyId)
					elseif data.current.value == 'freeze' then
						TriggerServerEvent('niward-ac-menu:freezeplayerSV' , plyId , true)
					elseif data.current.value == 'unfreeze' then
						TriggerServerEvent('niward-ac-menu:freezeplayerSV' , plyId , false)
					elseif data.current.value == 'kill' then
						local xTarget    = GetPlayerFromServerId(plyId)
						local xTargetPed = GetPlayerPed(xTarget)
						SetEntityHealth(xTargetPed , 0)
					elseif data.current.value == 'manualBan' then
						TriggerServerEvent('niward-ac:checkBan' , 'manualBan' , true , "Efectuado por: " .. GetPlayerName(plyId) , plyId)
					elseif data.current.value == 'warn' then
						ESX.UI.Menu.Open('dialog' , GetCurrentResourceName() , 'warnReason' , {
							title = 'Warn Reason'
						} ,
						                 function(data2 , menu2)
							                 local warnreason = data2.value
							                 menu2.close()
							                 TriggerServerEvent("kc_admin:warnFromMenu" , plyId , warnreason , GetLocalTime())
						                 end ,
						                 function(data2 , menu2)
							                 menu2.close()
						                 end)
					elseif data.current.value == 'comserv' then
						ESX.UI.Menu.Open('dialog' , GetCurrentResourceName() , 'comserv' , {
							title = 'Comunity Service'
						} ,
						                 function(data2 , menu2)
							                 local totalcoms = tonumber(data2.value)
							                 menu2.close()
							                 if totalcoms == nil then
								                 TriggerEvent('esx:showNotification' , "~r~Inválid Quantity.")
							                 else
								                 TriggerServerEvent("esx_communityservice:sendToCommunityService" , plyId , totalcoms)
								                 menu2.close()
							                 end
						                 end ,
						                 function(data , menu)
							                 menu2.close()
						                 end)
					end
				end , function(data , menu)
					menu.close()
					onlineMenu()
				end)
			
			end
			
			function deleteMenu()
				if isStaffLocal == 1 then
					local elements = {
						{ label = "Delete all vehicles", value = "deleteVehicles" },
						{ label = "Delete all peds", value = "deletePeds" },
						{ label = "Delete all props", value = "deleteProps" },
					}
					
					ESX.UI.Menu.CloseAll()
					ESX.UI.Menu.Open(
							'default' , GetCurrentResourceName() , 'adminMenu' ,
							{
								title    = "NIWARD-AC | DELETE MENU",
								align    = 'bottom-right',
								elements = elements
							} ,
							function(data , menu)
								if data.current.value == "deleteVehicles" then
									ExecuteCommand("nwac_clear vehs")
								elseif data.current.value == "deletePeds" then
									ExecuteCommand("nwac_clear peds")
								elseif data.current.value == "deleteProps" then
									ExecuteCommand("nwac_clear props")
								end
								isMenuOpenedPlayers = false
							end ,
							function(data , menu)
								isMenuOpenedPlayers = false
								menu.close()
								openMainMenu()
							end)
				end
			end
			
			function vehicleMenu()
				if isStaffLocal == 1 then
					local elements = {
						{ label = 'Repair Vehicle', value = 'repair_vehicle' },
						{ label = 'Max All Tuning', value = 'max_all_tuning' },
						{ label = 'Vehicle Boost Menu', value = 'vehicle_boost_menu' }
					}
					
					ESX.UI.Menu.CloseAll()
					ESX.UI.Menu.Open(
							'default' , GetCurrentResourceName() , 'adminMenu' ,
							{
								title    = "NIWARD-AC | VEHICLE MENU",
								align    = 'bottom-right',
								elements = elements
							} ,
							function(data , menu)
								if data.current.value == "repair_vehicle" then
									ESX.UI.Menu.CloseAll()
									SetVehicleFixed(GetVehiclePedIsIn(GetPlayerPed(-1) , false))
									SetVehicleDirtLevel(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 0.0)
									SetVehicleLights(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 0)
									SetVehicleBurnout(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , false)
									Citizen.InvokeNative(0x1FD09E7390A74D54 , GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 0)
								elseif data.current.value == "max_all_tuning" then
									ESX.UI.Menu.CloseAll()
									maxTunning(GetVehiclePedIsUsing(PlayerPedId()))
								elseif data.current.value == "vehicle_boost_menu" then
									ESX.UI.Menu.CloseAll()
									boostVehicleMenu()
								end
								isMenuOpenedPlayers = false
							end ,
							function(data , menu)
								isMenuOpenedPlayers = false
								menu.close()
								openMainMenu()
							end)
				end
			end
			
			function boostVehicleMenu()
				if isStaffLocal == 1 then
					local elements = {
						{ label = 'Engine boost RESET', value = 'engine_power_boost_reset' },
						{ label = 'Engine boost x2', value = 'engine_power_boost_x2' },
						{ label = 'Engine boost x4', value = 'engine_power_boost_x4' },
						{ label = 'Engine boost x8', value = 'engine_power_boost_x8' },
						{ label = 'Engine boost x16', value = 'engine_power_boost_x16' },
						{ label = 'Engine boost x32', value = 'engine_power_boost_x32' }
					}
					
					ESX.UI.Menu.CloseAll()
					ESX.UI.Menu.Open(
							'default' , GetCurrentResourceName() , 'adminMenu' ,
							{
								title    = "NIWARD-AC | BOOST MENU",
								align    = 'bottom-right',
								elements = elements
							} ,
							function(data , menu)
								if data.current.value == 'engine_power_boost_reset' then
									SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 1.0)
								elseif data.current.value == 'engine_power_boost_x2' then
									SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 2.0 * 20.0)
								elseif data.current.value == 'engine_power_boost_x4' then
									SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 4.0 * 20.0)
								elseif data.current.value == 'engine_power_boost_x8' then
									SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 8.0 * 20.0)
								elseif data.current.value == 'engine_power_boost_x16' then
									SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 16.0 * 20.0)
								elseif data.current.value == 'engine_power_boost_x32' then
									SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 32.0 * 20.0)
								end
							end ,
							function(data , menu)
								menu.close()
								openMainMenu()
							end)
				end
			end
			
			RegisterNetEvent('niward-ac:nocliped')
			AddEventHandler('niward-ac:nocliped' , function()
				if isStaffLocal == 1 then
					noclip    = not noclip
					local ped = GetPlayerPed(-1)
					if noclip then
						SetEntityInvincible(ped , true)
						SetEntityVisible(ped , false , false)
					else
						SetEntityInvincible(ped , false)
						SetEntityVisible(ped , true , false)
					end
					if noclip == true then
						TriggerEvent('esx:showNotification' , "~w~Noclip ~g~enabled.")
					else
						TriggerEvent('esx:showNotification' , "~w~Noclip ~r~disabled.")
					end
					selfMenu()
				end
			end)
			
			RegisterNetEvent('niward-ac:playerBlips')
			AddEventHandler('niward-ac:playerBlips' , function()
				if isStaffLocal == 1 then
					if blipsEnabled == false then
						blipsEnabled = true
						TriggerEvent('esx:showNotification' , "~w~Blips ~g~enabled.")
					else
						blipsEnabled = false
						TriggerEvent('esx:showNotification' , "~w~Blips ~r~disabled.")
					end
					selfMenu()
				end
			end)
			
			RegisterNetEvent('niward-ac:playerName')
			AddEventHandler('niward-ac:playerName' , function()
				if isStaffLocal == 1 then
					if namesEnabled == false then
						namesEnabled = true
						TriggerEvent('esx:showNotification' , "~w~Player Names ~g~enabled.")
					else
						namesEnabled = false
						TriggerEvent('esx:showNotification' , "~w~Player Names ~r~disabled.")
					end
					selfMenu()
				end
			end)
			
			function getPosition()
				local x , y , z = table.unpack(GetEntityCoords(GetPlayerPed(-1) , true))
				return x , y , z
			end
			
			function getCamDirection()
				local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(GetPlayerPed(-1))
				local pitch   = GetGameplayCamRelativePitch()
				
				local x       = -math.sin(heading * math.pi / 180.0)
				local y       = math.cos(heading * math.pi / 180.0)
				local z       = math.sin(pitch * math.pi / 180.0)
				
				local len     = math.sqrt(x * x + y * y + z * z)
				if len ~= 0 then
					x = x / len
					y = y / len
					z = z / len
				end
				
				return x , y , z
			end
			
			Citizen.CreateThread(function()
				while true do
					Wait(1)
					for _ , player in ipairs(GetActivePlayers()) do
						if NetworkIsPlayerActive(player) then
							ped     = GetPlayerPed(player)
							blip    = GetBlipFromEntity(ped)
							idTesta = Citizen.InvokeNative(0xBFEFE3321A3F5015 , ped , "[" .. GetPlayerServerId(player) .. "] " .. GetPlayerName(player) , false , false , "" , false)
							if namesEnabled then
								local numeroid = GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1)))
								if numeroid ~= GetPlayerServerId(player) then
									Citizen.InvokeNative(0x63BB75ABEDC1F6A0 , idTesta , 0 , true)
								end
							else
								Citizen.InvokeNative(0x63BB75ABEDC1F6A0 , idTesta , 0 , false)
							end
							if blipsEnabled then
								if not DoesBlipExist(blip) then
									-- Con questo aggiungo i blip sulla testa dei giocatori.
									blip = AddBlipForEntity(ped)
									SetBlipSprite(blip , 1) -- imposto il blip sulla posizione "blip" con l'id 1
									Citizen.InvokeNative(0x5FBCA48327B914DF , blip , true) -- Aggiunge effettivamente il blip
								else
									-- se il blip esiste, allora lo aggiorno
									SetBlipNameToPlayerName(blip , player) -- aggirono il blip del giocatore
									SetBlipScale(blip , 0.85) -- dimensione
								end
								
								if IsPauseMenuActive() then
									SetBlipAlpha(blip , 255)
								end
							else
								RemoveBlip(blip)
							end
						end
					end
				end
			end)
			
			function DrawPlayerInfo(target)
				drawTarget = target
				drawInfo   = true
			end
			
			function StopDrawPlayerInfo()
				drawInfo   = false
				drawTarget = 0
				ESX.UI.Menu.CloseAll()
				onlineMenu()
			end
			
			function maxTunning(veh)
				SetVehicleModKit(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 0)
				SetVehicleWheelType(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 7)
				SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 0 , GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 0) - 1 , false)
				SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 1 , GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 1) - 1 , false)
				SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 2 , GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 2) - 1 , false)
				SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 3 , GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 3) - 1 , false)
				SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 4 , GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 4) - 1 , false)
				SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 5 , GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 5) - 1 , false)
				SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 6 , GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 6) - 1 , false)
				SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 7 , GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 7) - 1 , false)
				SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 8 , GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 8) - 1 , false)
				SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 9 , GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 9) - 1 , false)
				SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 10 , GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 10) - 1 , false)
				SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 11 , GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 11) - 1 , false)
				SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 12 , GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 12) - 1 , false)
				SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 13 , GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 13) - 1 , false)
				SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 14 , 16 , false)
				SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 15 , GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 15) - 2 , false)
				SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 16 , GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 16) - 1 , false)
				ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 17 , true)
				ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 18 , true)
				ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 19 , true)
				ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 20 , true)
				ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 21 , true)
				ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 22 , true)
				SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 23 , 1 , false)
				SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 24 , 1 , false)
				SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 25 , GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 25) - 1 , false)
				SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 27 , GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 27) - 1 , false)
				SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 28 , GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 28) - 1 , false)
				SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 30 , GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 30) - 1 , false)
				SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 33 , GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 33) - 1 , false)
				SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 34 , GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 34) - 1 , false)
				SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 35 , GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 35) - 1 , false)
				SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 38 , GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 38) - 1 , true)
				SetVehicleWindowTint(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 1)
				SetVehicleTyresCanBurst(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , false)
				SetVehicleNumberPlateTextIndex(GetVehiclePedIsIn(GetPlayerPed(-1) , false) , 5)
			end
			
			function spectatePlayer(targetPed , target , name)
				local targetx , targety , targetz = table.unpack(GetEntityCoords(targetPed , false))
				RequestCollisionAtCoord(targetx , targety , targetz)
				NetworkSetInSpectatorMode(true , targetPed)
				DrawPlayerInfo(target)
				ESX.ShowNotification("Spectating")
				OpenAdminActionMenu(target)
			end
			
			function OpenAdminActionMenu(player)
				ESX.TriggerServerCallback('niward-ac-menu:getOtherPlayerData' , function(data)
					
					--print(json.encode(data))
					local jobLabel    = nil
					local sexLabel    = nil
					local sex         = nil
					local dobLabel    = nil
					local heightLabel = nil
					local idLabel     = nil
					local Money       = 0
					local Bank        = 0
					local blackMoney  = 0
					local Inventory   = nil
					
					for k , v in pairs(data.accounts) do
						if v.name == 'black_money' then
							blackMoney = v.money
						end
						if v.name == 'money' then
							Money = v.money
						end
						if v.name == 'bank' then
							Bank = v.money
						end
					end
					
					if data.job.grade_label ~= nil and data.job.grade_label ~= '' then
						jobLabel = 'Job : ' .. data.job.label .. ' - ' .. data.job.grade_label
					else
						jobLabel = 'Job : ' .. data.job.label
					end
					
					if data.sex ~= nil then
						if (data.sex == 'm') or (data.sex == 'M') then
							sex = 'Male'
						else
							sex = 'Female'
						end
						sexLabel = 'Sex : ' .. sex
					else
						sexLabel = 'Sex : Unknown'
					end
					
					if data.dob ~= nil then
						dobLabel = 'DOB : ' .. data.dob
					else
						dobLabel = 'DOB : Unknown'
					end
					
					if data.height ~= nil then
						heightLabel = 'Height : ' .. data.height
					else
						heightLabel = 'Height : Unknown'
					end
					
					local elements = {
						{ label = 'Name: ' .. data.firstname .. " " .. data.lastname, value = nil },
						{ label = 'Money: ' .. Money, value = nil, itemType = 'item_account', amount = Money },
						{ label = 'Bank: ' .. Bank, value = nil, itemType = 'item_account', amount = Bank },
						{ label = 'Black Money: ' .. blackMoney, value = nil, itemType = 'item_account', amount = blackMoney },
						{ label = jobLabel, value = nil },
						{ label = "STEAM ID:" .. data.name, value = nil },
					}
					
					table.insert(elements , { label = '--- Inventory ---', value = nil })
					
					for i = 1 , #data.inventory , 1 do
						if data.inventory[i].count > 0 then
							table.insert(elements , {
								label    = data.inventory[i].label .. ' x ' .. data.inventory[i].count,
								value    = nil,
								itemType = 'item_standard',
								amount   = data.inventory[i].count,
							})
						end
					end
					
					table.insert(elements , { label = '--- Weapons ---', value = nil })
					
					for i = 1 , #data.weapons , 1 do
						table.insert(elements , {
							label    = ESX.GetWeaponLabel(data.weapons[i].name),
							value    = nil,
							itemType = 'item_weapon',
							amount   = data.ammo,
						})
					end
				end)
			end
		end
	end
end)
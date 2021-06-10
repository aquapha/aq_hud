ESX = nil

local food = 0
local thirst = 0

Citizen.CreateThread(function()
  while ESX == nil do 
    TriggerEvent('esx:getSharedObject', function(obj)
      ESX = obj 
    end)
    Wait(0)
  end
end)

RegisterNetEvent("esx_status:onTick")
AddEventHandler("esx_status:onTick", function(status)
    TriggerEvent('esx_status:getStatus', 'hunger', function(status)
        food = status.val / 10000
    end)
    TriggerEvent('esx_status:getStatus', 'thirst', function(status)
        thirst = status.val / 10000
    end)
end)

Citizen.CreateThread(function()
  while true do
      Citizen.Wait(0)

      HideHudComponentThisFrame(3)
      HideHudComponentThisFrame(4)
      HideHudComponentThisFrame(13)
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(400)
    TriggerEvent("esx_status:onTick")
  
    ESX.TriggerServerCallback('aq_hud:getAccounts', function(cash, bank)
      SendNUIMessage({
        type = 'update',
        values = {
          id = GetPlayerServerId(PlayerId()),
          name = GetPlayerName(PlayerId()),
          health = GetEntityHealth(PlayerPedId()) - 100,
          armor = GetPedArmour(PlayerPedId()),
          hunger = food,
          thirst = thirst,
          isTalking = NetworkIsPlayerTalking(PlayerId()),
          cash = comma_value(cash),
          bank = comma_value(bank),
        }
      })
    end)
  end
end)

function comma_value(amount)
  local formatted = amount
  while true do  
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return formatted
end

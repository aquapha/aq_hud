ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('aq_hud:getAccounts', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)

  cb(xPlayer.getMoney(), xPlayer.getAccount("bank").money)
end)

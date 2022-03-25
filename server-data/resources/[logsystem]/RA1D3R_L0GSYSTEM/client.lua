local spawned = false
AddEventHandler("playerSpawned",function()
	if spawned == false then
		TriggerServerEvent("raiderlog:giris")
		spawned = true
	end
end)
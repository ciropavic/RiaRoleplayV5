
RegisterNUICallback('youtplay', function(data)
    exports["xsound"]:Cal(data.link, false)
end)

RegisterNUICallback('youtstop', function() 
    exports["xsound"]:Durdur()
end)

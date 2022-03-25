TriggerEvent('es:addCommand', 'cinema', function(source, args, user)
  TriggerClientEvent('malte-cinema:activate', source, {})
end)


RegisterCommand('setGreeting', function(source, args, rawCommand)
    local identifier = GetPlayerIdentifierByType(source, 'license')
    local greeting = string.sub(rawCommand, 13)

    MySQL.insert('INSERT INTO greetings (identifier, greeting) VALUES (?, ?) ON DUPLICATE KEY UPDATE greeting = ?', {
        identifier,
        greeting,
        greeting,
    }, function()
        TriggerClientEvent('chat:addMessage', source, {
            args = {'Your greeting has been saved!'}
        })
    end)
end)

RegisterNetEvent('ch_greeting:show', function ()
    local playerID = source
    local identifier = GetPlayerIdentifierByType(playerID, 'license')

    MySQL.scalar('SELECT greeting FROM greetings WHERE identifier = ?', {
        identifier
    }, function(greeting)
        if not greeting then
            return
        end

        TriggerClientEvent('chat:addMessage', playerID, {
            args = { greeting }
        })
    end)
end)

local example = {
    {
        greeting = 'foo',
    },
    {
        greeting = 'bar',
    },
    {
        greeting = 'baz',
    },
}
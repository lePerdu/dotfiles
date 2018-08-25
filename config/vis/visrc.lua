-- load standard vis module, providing parts of the Lua API
require('vis')

vis.events.subscribe(vis.events.INIT, function()
    vis:command('set autoindent')
    vis:command('set cursorline')
    vis:command('set numbers')

    vis:command('set expandtab')
    vis:command('set tabwidth 4')
    vis:command('set theme multicolor')
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)

end)


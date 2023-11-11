import "CoreLibs/graphics"
import "CoreLibs/object"
import "CoreLibs/sprites"
import  "CoreLibs/timer"

import "Test"

local gfx <const> = playdate.graphics
local i = 0;
function playdate.update() 
    gfx.clear()
    i+=1
    test(i)
end

function test(i)
    text = "test Function got called! FRAME: " .. tostring(i)
    gfx.drawText(text, 20, 20)
    playdate.datastore.write(table, "test",true)
end

import "CoreLibs/graphics"
import "CoreLibs/object"
import "CoreLibs/sprites"
import  "CoreLibs/timer"

import "Test"

local gfx <const> = playdate.graphics
local inrData = {}
local i = 0
local j = 0
function playdate.update()  
    if playdate.buttonJustReleased( playdate.kButtonA) then
        test(i)
        i+=1
        j+=1
    end
    
    if playdate.buttonJustPressed(playdate.kButtonB) then
        j=0
        gfx.clear()
    end
end

function test(i)
    inrData[i]= "test Function got called! FRAME: " .. tostring(i)
    gfx.drawText(inrData[i], 0, 20*j)
    playdate.datastore.write(table, "test",true)
end

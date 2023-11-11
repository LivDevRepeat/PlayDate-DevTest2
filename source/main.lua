import "CoreLibs/graphics"
import "CoreLibs/object"
import "CoreLibs/sprites"
import  "CoreLibs/timer"

import "Test"

local gfx <const> = playdate.graphics
local inrData = {}
local i = 0
function playdate.update()  
    if playdate.buttonJustReleased( playdate.kButtonA) then
       test(i)
       i+=1
    end
end

function test(i)
    gfx.clear()
    inrData[i]= "test Function got called! FRAME: " .. tostring(i)

    for  j=0,i,1 do
     
        gfx.drawText(inrData[j], 20, 20*j)
        end
  
    playdate.datastore.write(table, "test",true)
end

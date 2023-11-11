import "CoreLibs/graphics"
import "CoreLibs/object"
import "CoreLibs/sprites"
import  "CoreLibs/timer"

import "Test"

local gfx <const> = playdate.graphics


local j = 0
local inrData = {}

function debugReadData()
  local inrSaveData = playdate.datastore.read()
  inrData = inrSaveData
 end

debugReadData()

function playdate.update()  
    if playdate.buttonJustReleased( playdate.kButtonA) then
        addAndDrawNewTableEntry()
        j+=1
    end
    
    if playdate.buttonJustPressed(playdate.kButtonB) then
        j=0
        gfx.clear()
    end
    
    if playdate.buttonJustPressed(playdate.kButtonUp) then
        playdate.datastore.write(inrData)
    end
    
    if playdate.buttonJustPressed(playdate.kButtonDown) then
       debugReadData()
    end
    
    if playdate.buttonJustPressed(playdate.kButtonLeft) then
        playdate.datastore.delete()
    end
    
end

function addAndDrawNewTableEntry()
    i = #inrData +1;
    inrData[i] = "I created " .. tostring(i) .. " entries in the inr save data!"
    gfx.drawText(inrData[i], 0, 20*j)
end



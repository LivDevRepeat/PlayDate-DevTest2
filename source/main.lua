import "CoreLibs/graphics"
import "CoreLibs/object"
import "CoreLibs/sprites"
import  "CoreLibs/timer"
import "CoreLibs/keyboard"

import "Test"

local gfx <const> = playdate.graphics


local j = 0
local inrData = {}

function debugReadData()
      local inrSaveData = playdate.datastore.read()
      inrData = inrSaveData
      
      if inrData == nil then
          inrData = {}
      end
 end

debugReadData()

function playdate.update()  
    gfx.clear();
    
    if playdate.keyboard.isVisible() then 
        debugKeyBoardControls()
        gfx.drawText("Next ENTRY will be: " .. playdate.keyboard.text  , 20, 100)
    else
        debugControlls()   
    end 
    gfx.drawText("Welcome to the debug Save Data Experiment", 20, 20)
    if #inrData == 0 then
        gfx.drawText("NO INR", 20, 40)
    else
        gfx.drawTextInRect("The INRdata Currently Saves ".. #inrData .. " Entries", 20, 50, 400, 80)
        gfx.drawText("Last Entry: "  .. inrData[#inrData], 20, 70)
    end

end

function debugControlls()
    
    if playdate.buttonJustPressed(playdate.kButtonUp) then
        playdate.datastore.write(inrData)
    end
    
    if playdate.buttonJustPressed(playdate.kButtonDown) then
       debugReadData()
    end
    
    if playdate.buttonJustPressed(playdate.kButtonLeft) then
        playdate.datastore.delete()
    end
    
    if playdate.buttonJustPressed(playdate.kButtonRight) then
        playdate.keyboard.show()   
    end
end

function debugKeyBoardControls()
    
    if playdate.buttonJustPressed(playdate.kButtonB) then
    playdate.keyboard.hide()
    end 
    
end

function playdate.keyboard.keyboardWillHideCallback() 
     i = #inrData + 1
     inrData[i] = playdate.keyboard.text  
end



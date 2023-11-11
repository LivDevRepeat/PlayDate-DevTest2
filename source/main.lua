import "CoreLibs/graphics"
import "CoreLibs/object"
import "CoreLibs/sprites"
import  "CoreLibs/timer"
import "CoreLibs/keyboard"

import "Test"

local gfx <const> = playdate.graphics


local j = 0
local inrData = {}
 local gameMode = 1
 local onUpdates = {}

function debugReadData()
      local inrSaveData = playdate.datastore.read()
      inrData = inrSaveData
      
      if inrData == nil then
          inrData = {}
      end
 end
 






function debugControlls()
     
     if playdate.buttonJustPressed(playdate.kButtonUp) then
         availableGameModes = #onUpdates
         newGamemode = (gameMode % availableGameModes)+1
         print (newGamemode)
         gameMode = new
     end
     
     if playdate.buttonJustPressed(playdate.kButtonDown) then
       
     end
     
     if playdate.buttonJustPressed(playdate.kButtonLeft) then
         
     end
     
     if playdate.buttonJustPressed(playdate.kButtonRight) then
   
     end
 end



-- HERE ALL THE DRAWING & SPECIAL INPUTS FOR THE TEXT INPUT WINDOW RESIDES --
 
 function drawTextMode()  
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
  
  function debugKeyBoardControls() 
      if playdate.buttonJustPressed(playdate.kButtonB) then
      playdate.keyboard.hide()
      end 
      
  end
  
  function playdate.keyboard.keyboardWillHideCallback() 
       i = #inrData + 1
       inrData[i] = playdate.keyboard.text  
       playdate.datastore.write(inrData)
  end
  
  -- HERE THE LOGIC FOR DRAWING SQUARES RESIDES --
  
  function drawAllSquares()
       for i=3,0,-1 do
           gfx.fillRect(15, 15, 20, 20)
       end
   end
   
   

   
   function setGameMode()
       gameMode = 1
       onUpdates = {
           [1]={ onUpdate = drawTextMode},
           [2]={ onUpdate = drawAllSquares},
       }
   end
   
   
   -- PRE  UPDATE CALLS --
   debugReadData()
   setGameMode()
   
   -- UPDATE IS THE LAST --
   
   function playdate.update()  
       gfx.clear()  
       onUpdates[gameMode].onUpdate()
   end





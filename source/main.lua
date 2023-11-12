import "CoreLibs/graphics"
import "CoreLibs/object"
import "CoreLibs/sprites"
import  "CoreLibs/timer"
import "CoreLibs/keyboard"
import "CoreLibs/ui"
import "CoreLibs/nineslice"

import "Test"

local gfx <const> = playdate.graphics


local j = 0
local inrData = {}
 local gameMode = 1
 local onUpdates = {}
 
 -- In this example, we'll be drawing a smiley face to an image, which saves our
 -- drawing, makes it easier to draw, and helps improve performance since we don't
 -- have to redraw each element separately each time
 local gfx = playdate.graphics
 
 local smileWidth, smileHeight = 36, 36
 local smileImage = gfx.image.new(smileWidth, smileHeight)
 -- Pushing our new image to the graphics context, so everything
 -- drawn will be drawn directly to the image
 gfx.pushContext(smileImage)
     -- => Indentation not required, but helps organize things!
     gfx.setColor(gfx.kColorWhite)
     -- Coordinates are based on the image being drawn into
     -- (e.g. (x=0, y=0) refers to the top left of the image)
     gfx.fillCircleInRect(0, 0, smileWidth, smileHeight)
     gfx.setColor(gfx.kColorBlack)
     -- Drawing the eyes
     gfx.fillCircleAtPoint(11, 13, 3)
     gfx.fillCircleAtPoint(25, 13, 3)
     -- Drawing the mouth
     gfx.setLineWidth(3)
     gfx.drawArc(smileWidth/2, smileHeight/2, 11, 115, 245)
     -- Drawing the outline
     gfx.setLineWidth(2)
     gfx.setStrokeLocation(gfx.kStrokeInside)
     gfx.drawCircleInRect(0, 0, smileWidth, smileHeight)
 -- Popping context to stop drawing to image
 gfx.popContext()


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
        gameMode = newGamemode
     end
     
     if playdate.buttonJustPressed(playdate.kButtonDown) then
       setUpSmiley()
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
    debugControlls()
    if playdate.buttonJustPressed("a") then
        playdate.keyboard.show()
    end
    if playdate.buttonJustPressed("b") then
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
     local screenWidth, screenHeight = playdate.display.getSize()
     for i=4,0,-1 do
       for j=3,0,-1 do
         smileImage:drawAnchored(screenWidth*i/4, screenHeight*j/3,0.5,0.5)
        end
     end
 end

   -- DRAW UI GRID
   
   
   local gfx = playdate.graphics
   local gridview = playdate.ui.gridview.new(44, 44)
  -- gridview.backgroundImage = playdate.graphics.nineSlice.new('shadowbox', 4, 4, 45, 45)
   gridview:setNumberOfColumns(8)
   gridview:setNumberOfRows(2, 4, 3, 5) -- number of sections is set automatically
   gridview:setSectionHeaderHeight(24)
   gridview:setContentInset(1, 4, 1, 4)
   gridview:setCellPadding(4, 4, 4, 4)
   gridview.changeRowOnColumnWrap = false
   
   function gridview:drawCell(section, row, column, selected, x, y, width, height)
       if selected then
           gfx.drawCircleInRect(x-2, y-2, width+4, height+4, 3)
       else
           gfx.drawCircleInRect(x+4, y+4, width-8, height-8, 0)
       end
       local cellText = ""..row.."-"..column
       gfx.drawTextInRect(cellText, x, y+14, width, 20, nil, nil, kTextAlignment.center)
   end
   
   function gridview:drawSectionHeader(section, x, y, width, height)
       gfx.drawText("*SECTION ".. section .. "*", x + 10, y + 8)
   end
   
 function drawUIGrid()
       gridview:drawInRect(0, 0, 400, 240)
       playdate.timer:updateTimers()
   end
   
   
   -- CREATE GAMEMODE TABLE --
   
   function setGameMode()
       gameMode = 2
       onUpdates = {
           [1]={title = "Keyboard Test", draw = drawTextMode, manageInputs = debugKeyBoardControls },
           [2]={title = "Square Test", draw = drawAllSquares, manageInputs = debugControlls },
           [3]={title = "Grid Test", draw = drawUIGrid, manageInputs = debugControlls },
       }
   end  
   
   -- PRE  UPDATE CALLS --
   debugReadData()
   setGameMode()
   
   -- UPDATE IS THE LAST --
   
   function playdate.update()  
       gfx.clear()  
       onUpdates[gameMode].draw()
       onUpdates[gameMode].manageInputs()
       
       gfx.drawText(onUpdates[gameMode].title,0,220)
   end





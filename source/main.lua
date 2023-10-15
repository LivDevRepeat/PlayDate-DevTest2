import "CoreLibs/graphics"
import "CoreLibs/object"
import "CoreLibs/sprites"
import  "CoreLibs/timer"

local gfx <const> = playdate.graphics
function playdate.update() 
    gfx.clear()
    gfx.drawText("Hello World", 89, 20)
end
-- import "CoreLibs/object"
import "CoreLibs/graphics"
-- import "CoreLibs/timer"
import 'CoreLibs/ui/gridview.lua'
import 'files'
import 'text'

gfx = playdate.graphics

gfx.setColor(gfx.kColorWhite)
local font = gfx.font.new('fonts/Roobert/Roobert-11-Medium-table-22-22.png')
gfx.setFont(font)

function playdate.upButtonUp()

end

function playdate.downButtonUp()

end

function playdate.AButtonDown()

end

function playdate.BButtonDown()

end

function playdate.gameWillTerminate()
   
end

function playdate.deviceWillSleep()

end


function playdate.update() 
   playdate.drawFPS(385, 0) 
   
   content = readFileContent('test 1.txt')

   readingIndex = drawText(content)
   readingIndex = handleContiniousInput(readingIndex)

    
    -- gfx.sprite.update()
    -- playdate.timer.updateTimers()
end

function handleContiniousInput(index)
   local crankChange = playdate.getCrankChange() 
   local crankMoved = math.abs(crankChange) > crankStepPerLine
   
   if playdate.buttonIsPressed(playdate.kButtonUp) or (crankMoved and crankChange < 0) then
      index -= 1
      needRefresh = true
   end
   if playdate.buttonIsPressed(playdate.kButtonDown) or (crankMoved and crankChange > 0) then
       index += 1
       needRefresh = true
   end
   
   if index > #content - linesPerScreen + extraScrollLines then
       index = #content - linesPerScreen + extraScrollLines
   end
   if index < 0 then
       index = 0
   end	 
   
   return index
end


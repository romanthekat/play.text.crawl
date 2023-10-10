import "CoreLibs/object"
import "CoreLibs/graphics"
-- import "CoreLibs/timer"
import 'CoreLibs/ui/gridview.lua'
import 'files'
import 'text'
import 'locations'
import 'actors'

---- initialisation
local currentMode = 'draw text'

-- todo move to dedicated place related to text/draw logic
local textFullyDrawn = false
local text = ''
local lineNumber = 1

-- view
gfx = playdate.graphics
font = gfx.font.new('fonts/Roobert/Roobert-11-Medium-table-22-22.png')   
local needRefresh = true
local crankStepPerLine = 7

-- code
gfx.setColor(gfx.kColorWhite)
gfx.setFont(font)

-- math.randomseed(playdate.getSecondsSinceEpoch())
---- initialisation finished


-- todo remove after tests
local contentRead = false
function playdate.update() 
   playdate.drawFPS(385, 0) 
   
   if not contentRead then
      content = readFileContent('test 1.txt')
      text = prepareTextForDraw(content)
      contentRead = true
   end

   if needRefresh then
      textFullyDrawn = drawText(text, lineNumber)
      needRefresh = false
   end
   
   local newLineNumber = handleContiniousInput(lineNumber)
   if newLineNumber ~= lineNumber then 
      lineNumber = newLineNumber
      needRefresh = true
   end

    
    -- gfx.sprite.update()
    -- playdate.timer.updateTimers()
end

function handleContiniousInput(lineNumber)
   local crankChange = playdate.getCrankChange() 
   local crankMoved = math.abs(crankChange) > crankStepPerLine
   
   if playdate.buttonIsPressed(playdate.kButtonUp) or (crankMoved and crankChange < 0) then
      lineNumber -= 1
   end
   if playdate.buttonIsPressed(playdate.kButtonDown) or (crankMoved and crankChange > 0) then
       lineNumber += 1
   end
   
   -- todo should not depend on view logic, refactor
   if lineNumber > #content - linesPerScreen + extraScrollLines then
       lineNumber = #content - linesPerScreen + extraScrollLines
   end
   if lineNumber <= 0 then
       lineNumber = 1
   end	 
   
   return lineNumber
end

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
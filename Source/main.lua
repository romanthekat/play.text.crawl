-- import "CoreLibs/object"
import "CoreLibs/graphics"
-- import "CoreLibs/timer"
import 'CoreLibs/ui/gridview.lua'
import 'files'
import 'text'

---- initialisation
local currentMode = 'draw text'
-- todo move to dedicated place related to text/draw logic
local textFullyDrawn = false
local text = ''
local textLine = 1

-- view
gfx = playdate.graphics
font = gfx.font.new('fonts/Roobert/Roobert-11-Medium-table-22-22.png')   
local needRefresh = true
local crankStepPerLine = 7

-- code
gfx.setColor(gfx.kColorWhite)
gfx.setFont(font)
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
      textFullyDrawn = drawText(text, textLine)
      needRefresh = false
   end
   
   local newTextLine = handleContiniousInput(textLine)
   if newTextLine ~= textLine then 
      textLine = newTextLine
   end

    
    -- gfx.sprite.update()
    -- playdate.timer.updateTimers()
end

function handleContiniousInput(textLine)
   local crankChange = playdate.getCrankChange() 
   local crankMoved = math.abs(crankChange) > crankStepPerLine
   
   if playdate.buttonIsPressed(playdate.kButtonUp) or (crankMoved and crankChange < 0) then
      textLine -= 1
      needRefresh = true
   end
   if playdate.buttonIsPressed(playdate.kButtonDown) or (crankMoved and crankChange > 0) then
       textLine += 1
       needRefresh = true
   end
   
   -- todo should not depend on view logic, refactor
   if textLine > #content - linesPerScreen + extraScrollLines then
       textLine = #content - linesPerScreen + extraScrollLines
   end
   if textLine <= 0 then
       textLine = 1
   end	 
   
   return textLine
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
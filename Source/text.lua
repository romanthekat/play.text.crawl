screenWidth, screenHeight = playdate.display.getSize()

linesPerScreen = 11
extraScrollLines = 4

local lineHeight = 22

--- Draws an arbitrary text, starting with line number
function drawText(text, lineNumber)
	gfx.clear()
		
	local screenLine = 1
	while screenLine <= linesPerScreen do
		if lineNumber <= #text then
			line = text[lineNumber]
			local x = 2
			local y = (screenLine-1)*lineHeight
				
			-- printedLength, printedHeight = gfx.drawTextInRect(line, x, y, 400, 240) 
			printedLength, printedHeight = gfx.drawText(line, x, y) 
				
			-- if more than 1 line were drawn, ideally shouldn't happen ever, get rid of this logic?
			if printedHeight > lineHeight then
				screenLine += printedHeight //= lineHeight - 1
			end
		end
			
		lineNumber += 1
		screenLine += 1
	end
	
	playdate.display.flush()
	
	return lineNumber >= #text
end

local function isFitScreen(line)
	width, height = gfx.getTextSize(line)
	return width <= screenWidth
end

-- todo binary search would be more efficient
local function splitLineToFitScreen(line)
  local words = {}
  for word in line:gmatch("%S+") do
	table.insert(words, word)
  end

  local lines = {}
  local currentLine = ""

  for i, word in ipairs(words) do
	if #currentLine > 0 then
	  currentLine = currentLine .. " "
	end

	if isFitScreen(currentLine .. word) then
	  currentLine = currentLine .. word
	else
	  table.insert(lines, currentLine)
	  currentLine = word
	end
  end

  if #currentLine > 0 then
	table.insert(lines, currentLine)
  end

  return lines
end

--- Prepares input table for drawing on screen, 
-- splits lines by words to fit the screen
function prepareTextForDraw(input)
	local result = {}
	
	for i, line in ipairs(input) do
		local lines = splitLineToFitScreen(line)
		for i = 1, #lines do
			table.insert(result, lines[i])
		end
	end
	
	return result
end
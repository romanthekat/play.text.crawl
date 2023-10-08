width, height = playdate.display.getSize()

linesPerScreen = 11
lineHeight = 22
needRefresh = true

crankStepPerLine = 7
extraScrollLines = 4

local text = 'empty'
local textLine = 1

function drawText(input)
	text = splitLines(input)
	
	if needRefresh then
		gfx.clear()
		
		local screenLine = 1
		while screenLine <= linesPerScreen do
			if textLine+screenLine <= #text then
				line = text[textLine]
				local x = 2
				local y = (screenLine-1)*lineHeight
				
				printedLength, printedHeight = gfx.drawTextInRect(line, x, y, 400, 240) 
				-- printedLength, printedHeight = gfx.drawText(line, x, y) 
				
				if printedHeight > lineHeight then
					screenLine += printedHeight //= lineHeight - 1
				end
			end
			
			textLine += 1
			screenLine += 1
		end
		needRefresh = false  
		playdate.display.flush()
	end 
	
	return textLine
end


-- todo implement
function splitLines(input)
	return input
	
	-- local result = {}
	-- 
	-- for i = 1, #input do
	-- 	local line = input[i]
	-- 	line:
	-- 	table.insert(result, file)	
	-- end
	-- 
	-- return result
end
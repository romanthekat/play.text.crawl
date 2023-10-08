-- width, height = playdate.display.getSize()

linesPerScreen = 11
extraScrollLines = 4

local lineHeight = 22

function drawText(text, textLine)
	gfx.clear()
		
	local screenLine = 1
	while screenLine <= linesPerScreen do
		if textLine <= #text then
			line = text[textLine]
			local x = 2
			local y = (screenLine-1)*lineHeight
				
			printedLength, printedHeight = gfx.drawTextInRect(line, x, y, 400, 240) 
			-- printedLength, printedHeight = gfx.drawText(line, x, y) 
				
			-- if more than 1 line were drawn, ideally shouldn't happen ever, get rid of this logic?
			if printedHeight > lineHeight then
				screenLine += printedHeight //= lineHeight - 1
			end
		end
			
		textLine += 1
		screenLine += 1
	end
	
	playdate.display.flush()
	
	return textLine >= #text
end


-- todo implement
function prepareTextForDraw(input)
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
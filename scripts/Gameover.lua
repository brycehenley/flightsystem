gtext = getObject("Text0")

setText(gtext , "Game Over") 
setTextColor(gtext, {255, 0, 0, 255})

sec = 0
min = 0
timeseta = 0

function time()
	sec = sec + 1
	if sec == 60 then
		min = min + 1
		sec = 0
	end
end

function onSceneUpdate()
	time()

	if isKeyPressed("ENTER") then
		loadLevel("levels/titlescreen.level")
	end
	if onKeyDown("MOUSE_BUTTON_LEFT") then 
		loadLevel("levels/titlescreen.level")
	end
	if isKeyPressed("JOY1_BUTTON_Y") then
		if sec % 2 == 0 then
		loadLevel("levels/titlescreen.level")
		end
	end

	if isKeyPressed("ESCAPE") then
		quit()
	end
end
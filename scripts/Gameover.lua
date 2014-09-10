gtext = getObject("Text0")

setText(gtext , "Game Over") 
setTextColor(gtext, {255, 0, 0, 255})


function onSceneUpdate()

	if isKeyPressed("ENTER") then
		loadLevel("levels/titlescreen.level")
	end

	if isKeyPressed("JOY1_BUTTON_Y") then
		loadLevel("levels/titlescreen.level")
	end

end
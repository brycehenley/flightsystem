gtext = getObject("Text0")

setText(gtext , "Game Over") 
setTextColor(gtext, {255, 0, 0, 255})


function onSceneUpdate()

	if isKeyPressed("ENTER") then
		loadLevel("levels/start.level")
	end

	if isKeyPressed("SPACE") then
		loadLevel("levels/titlescreen.level")
	end
end
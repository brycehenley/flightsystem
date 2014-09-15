menuheadertext = getObject("Text0")
menubodytext = getObject("Text1")
menusubbodytext = getObject("Text2")
local logo = getObject("Entity0")

setText(menuheadertext , "Skyland") 
setText(menubodytext , "press Space or Start to begin")
setText(menusubbodytext , "press Escape to exit") 



function onSceneUpdate()
	if isKeyPressed("W") then
		changeAnimation(logo,"1")
	end

	if isKeyPressed("SPACE") then
		loadLevel("levels/start.level")
	end
	if isKeyPressed("JOY1_BUTTON_Y") then
		loadLevel("levels/start.level")
	end

	if isKeyPressed("ESCAPE") then
		quit()
	end
end

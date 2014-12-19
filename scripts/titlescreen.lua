menuheadertext = getObject("Text0")
background = getObject("Entity1")
logo = getObject("Entity0")

scale = getWindowScale()
width = scale[1]
height = scale[2]

setText(menuheadertext , "Skyland")

showCursor()

------ menu buttons
	function button1Callback()
		destroyWidget(button1)
		destroyWidget(button2)		
		destroyWidget(button3)

		loadLevel("levels/start.level")
	end

	function button2Callback()
		quit()
	end

	function button3Callback()
		quit()
	end

	enableGui(1)
	mainCanvas = getMainCanvas()

	button1 = createButton(200,400,250,35, "Start", "button1Callback")
	button2 = createButton(200,455,250,35,"Settings", "button2Callback")
	button3 = createButton(200,510,250,35, "Quit", "button3Callback")

	setNormalBackground({0.5,0.5,0.5,0.3})
	setHoverBackground({0.7,0.7,0.7,0.3})

	addWidgetToCanvas(mainCanvas, button1)
	addWidgetToCanvas(mainCanvas, button2)
	addWidgetToCanvas(mainCanvas, button3)

function onSceneUpdate()
	showCursor()

	rotate(logo, {0, 0, 1}, .5, "local")

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

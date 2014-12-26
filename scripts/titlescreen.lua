menuheadertext = getObject("Text0")
background = getObject("Entity1")
logo = getObject("Entity0")
titlemusic = getObject("titlemusic")

button = false

sound = true
applysound = true

setText(menuheadertext , "Skyland")
showCursor()

if sound then
playSound(titlemusic) 
end
------ menu buttons
	function button1Callback()
		destroyWidget(button1)
		destroyWidget(button2)		
		destroyWidget(button3)
		destroyWidget(button4)
		destroyWidget(button5)
		destroyWidget(input1)
		destroyWidget(input2)

		loadLevel("levels/start.level")
	end

	function button2Callback()
		if button ~= true then
		button4 = createButton(500,455,250,35, "Apply Settings", "button4Callback")
		button5 = createButton(500,620,250,35, "Sound On", "button5Callback")
		applysound = true
		addWidgetToCanvas(mainCanvas, button4)
		addWidgetToCanvas(mainCanvas, button5)

		input1 = createInput(500,510,250, 30, "width", "")
		input2 = createInput(500,565,250, 30, "height", "")

		addWidgetToCanvas(mainCanvas, input1)
		addWidgetToCanvas(mainCanvas, input2)
		button = true
		else
			destroyWidget(button4)
			destroyWidget(input1)
			destroyWidget(input2)
			destroyWidget(button5)
			button = false
		end
	end

	function button3Callback()
		quit()
	end

	enableGui(1)
	mainCanvas = getMainCanvas()

	button1 = createButton(200,400,250,35, "Start", "button1Callback")
	button2 = createButton(200,455,250,35,"Settings", "button2Callback")
	button3 = createButton(200,510,250,35, "Quit", "button3Callback")

	setNormalBackground({0.7,0.5,0.5,0.3})
	setHoverBackground({1.0,0.7,0.7,0.3})

	addWidgetToCanvas(mainCanvas, button1)
	addWidgetToCanvas(mainCanvas, button2)
	addWidgetToCanvas(mainCanvas, button3)

	function button4Callback()
		width = getLabel(input1)
		height = getLabel(input2)
		resizeWindow(width, height)
		sound = applysound
		if sound then
			playSound(titlemusic)
		else
			pauseSound(titlemusic)
		end

		destroyWidget(button4)
		destroyWidget(input1)
		destroyWidget(input2)
		destroyWidget(button5)
		button = false
	end

	function button5Callback()
		if applysound then
			destroyWidget(button5)
			button5 = createButton(500,620,250,35, "Sound Off", "button5Callback")
			addWidgetToCanvas(mainCanvas, button5)
			applysound = false
		else
			destroyWidget(button5)
			button5 = createButton(500,620,250,35, "Sound On", "button5Callback")
			addWidgetToCanvas(mainCanvas, button5)
			applysound = true
		end
	end

function onSceneUpdate()
	showCursor()

	rotate(logo, {0, 0, 1}, .5, "local")

	if isKeyPressed("SPACE") then
		button1Callback()
	end
	if isKeyPressed("JOY1_BUTTON_A") then
		button1Callback()
	end

	if isKeyPressed("ESCAPE") then
		quit()
	end
end
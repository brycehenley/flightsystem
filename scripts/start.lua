Main = getScene("Scene-1")
Camera = getObject("Camera0")

enableGui(0)

debug = false
gamepad = false
keyboard = true

-- get objects
camera = getObject("Camera0")
cambody = getObject("Entity3")
ship = getObject("Entity0")
landmass = getObject("Entity1")
obuilding = getObject("obuilding")
dome = getObject("dome")
controlsText = getObject("Text")
Eship0 = getObject("Eship0")
Eship1 = getObject("Eship1")
Eship2 = getObject("Eship2")

hitstart0 = getObject("hitstart0")
hitstart1 = getObject("hitstart1")
hitend0 = getObject("hitend0")
hitend1 = getObject("hitend1")

Laser0 = getObject("Laser0")
Laser1 = getObject("Laser1")

heart0 = getObject("heart0")
heart1 = getObject("heart1")
heart2 = getObject("heart2")

testcube = getObject("testcube")

rainsound = getObject("Sound0")

cloneList = {}
subcloneList = {}
cubecloneList0 = {}
cubecloneList1 = {}
apoint = {}
bpoint = {}

---------
dx = 0.0 -- change in mouse x-axis since last update
dy = 0.0 -- change in mouse y-axis since last update
dz = 0.0
dw = 0.0

sec = 0
min = 0

shots = 0
shipcollision = true
shipcollisionnumber = 0
Eship1collisionnumber = 0
Eship2collisionnumber = 0
Eship3collisionnumber = 0

-- no global gravity, gravity is independent to each object.
setGravity({0.0, 0.0, 0.0})

hideCursor()
centerCursor()

mx = getAxis("MOUSE_X") 
my = getAxis("MOUSE_Y")

setText(controlsText, "W to accelerate | S to brake | A&D to roll | Mouse for pitch and yaw; or press tab or dpad-down to enable gamepad")
setTextColor(controlsText, {255, 0, 127, 255})
--------
function time()
	sec = sec + 1

	if sec == 60 then
		min = min + 1
		sec = 0
	end
end

function menu()
	quit()
end

function gameover()
	loadLevel("levels/gameover.level")
end

--function land()
--	shipcollision = false
--	wait()
--end

function handleKeys()
	if isKeyPressed("W") then
		addCentralForce(ship, {700.0, 0.0, 0.0}, "local")
		addCentralForce(ship, {0.0, 0.0, 100.0}, "global")
	end
	if isKeyPressed("A") then
		rotate(ship, {-1.0, 0.0, 0.0}, 0.75, "local") 
		rotate(cambody, {-1.0, 0.0, 0.0}, 0.75, "local") 
	end
	if isKeyPressed("D") then
		rotate(ship, {1.0, 0.0, 0.0}, 0.75, "local")
		rotate(cambody, {1.0, 0.0, 0.0}, 0.75, "local")
	end
	
	if isKeyPressed("S") then
		addCentralForce(ship, {-200.0, 0.0, 0.0}, "local")
		addCentralForce(ship, {0.0, 0.0, -100.0}, "global")
	end
	if isKeyPressed("BACKSPACE") then
		menu()
	end
	if isKeyPressed("ESCAPE") then
		menu()
	end
	--if isKeyPressed("SPACE") then
	--	land()
	--end

	if isKeyPressed("TAB") then
		gamepad = true
		keyboard = false
	end
	
	if gamepad then
		if isKeyPressed("JOY1_BUTTON_RIGHTSTICK") then
			addCentralForce(ship, {500.0, 0.0, 0.0}, "local")
		end
		if isKeyPressed("JOY1_BUTTON_Y") then
			menu()
		end
	end
end


-- scene update
function onSceneUpdate()
	--tracks time
	time()

	--Ship crash handeling
	if shipcollision then

			if isCollisionBetween(ship, landmass) then
				shipcollisionnumber = shipcollisionnumber + 2
			end
			if isCollisionBetween(ship, obuilding) then
				shipcollisionnumber = shipcollisionnumber + 2
			end
			if isCollisionBetween(ship, dome) then
				shipcollisionnumber = shipcollisionnumber + 2
			end
			if isCollisionBetween(ship, Eship0) then
				shipcollisionnumber = shipcollisionnumber + 5
			end
			if isCollisionBetween(ship, Eship1) then
				shipcollisionnumber = shipcollisionnumber + 5
			end
			if isCollisionBetween(ship, Eship2) then
				shipcollisionnumber = shipcollisionnumber + 5
			end
	
	end

	if shipcollisionnumber >= 5 then
		gameover()
	end

	if gamepad then

		dl = getAxis("JOY1_AXIS_LEFTX")
		dm = getAxis("JOY1_AXIS_LEFTY")
		dz = getAxis("JOY1_AXIS_RIGHTX")
		dw = getAxis("JOY1_AXIS_RIGHTY")

		if dl > -0.2 and dl < 0.2 then dl = 0.0 end
		if dm > -0.2 and dm < 0.2 then dm = 0.0 end
		-- yaw
		if dz > -0.2 and dz < 0.2 then dz = 0.0 end
		-- pitch
		if dw > -0.2 and dw < 0.2 then dw = 0.0 end

		rotate(ship, {1.0, 0.0, 0.0}, dl*1.25, "local")
		rotate(cambody, {1.0, 0.0, 0.0}, dl*1.25, "local")

		rotate(ship, {0.0, 0.0, -1.0}, dz*1.25, "local")
		rotate(cambody, {0.0, 0.0, -1.0}, dz*1.25, "local")

		rotate(ship, {0.0, -1.0, 0.0}, dw*1.25, "local")
		rotate(cambody, {0.0, -1.0, 0.0}, dw*1.25, "local")
	end

		-------
		-- rotate camera (X mouse)
		rotate(cambody, {0.0, 0.0, -1.0}, dx*100.0, "local")
		-- rotate camera (Y mouse)
		rotate(cambody, {0.0, -1.0, 0.0}, dy*100.0, "local")
		-- rotate Ship (X mouse)
		rotate(ship, {0.0, 0.0, -1.0}, dx*100.0, "local")	
		-- rotate Ship (Y mouse)
		rotate(ship, {0.0, -1.0, 0.0}, dy*100.0, "local")	
		
 
	---- ambient forces

		addCentralForce(ship, {300.0, 0.0, 0.0}, "local")

		addCentralForce(Eship0, {0.0, -300.0, 0.0}, "local")

		addCentralForce(Eship1, {0.0, -300.0, 0.0}, "local")

		addCentralForce(Eship2, {0.0, -300.0, 0.0}, "local")



	handleKeys()
	
	dx = getAxis("MOUSE_X") - mx 
	dy = getAxis("MOUSE_Y") - my 

	centerCursor()

		mx = getAxis("MOUSE_X") 
		my = getAxis("MOUSE_Y") 
---------

 	--hit detection vars
	startpos0 = getPosition(hitstart0)
	endpos0 = getPosition(hitend0)

	startpos1 = getPosition(hitstart1)
	endpos1 = getPosition(hitend1)

	if keyboard then
		if onKeyDown("MOUSE_BUTTON_LEFT") then 

			addCentralForce(ship, {-500.0, 0.0, 0.0}, "local")

			endpos0[1] = startpos0[1] + (endpos0[1] - startpos0[1])*1000
			endpos0[2] = startpos0[2] + (endpos0[2] - startpos0[2])*1000
			endpos0[3] = startpos0[3] + (endpos0[3] - startpos0[3])*1000

			endpos1[1] = startpos1[1] + (endpos1[1] - startpos1[1])*1000
			endpos1[2] = startpos1[2] + (endpos1[2] - startpos1[2])*1000
			endpos1[3] = startpos1[3] + (endpos1[3] - startpos1[3])*1000
	        
	        shots = shots + 2 --number of shots taken

			point0, object0 = rayHit(startpos0, endpos0)
	    	if point0 then
	    		if debug then
	    			print("hit at:")
	        		print(point0)
	        		print(getName(object0))
	        	end
		        	
		        	if getName(object1) == "Eship0" then
		        		Eship1collisionnumber = Eship1collisionnumber + 1
		        	end
		        	if getName(object1) == "Eship1" then
		        		Eship2collisionnumber = Eship2collisionnumber + 1
		        	end
		        	if getName(object1) == "Eship2" then
		        		Eship3collisionnumber = Eship3collisionnumber + 1
		        	end

	        		table.insert(cubecloneList0, #cubecloneList0 + 1, getClone(testcube))
	        		table.insert(apoint, #apoint + 1, point0)

	   		end
	   		point1, object1 = rayHit(startpos1, endpos1)
	    	if point1 then
	    		if debug then
		    		print("hit at:")
		        	print(point1)	-- print point of colision
		        	print(getName(object1))
	        	end
	        		
	        		if getName(object1) == "Eship0" then
		        		Eship1collisionnumber = Eship1collisionnumber + 1
		        	end
		        	if getName(object1) == "Eship1" then
		        		Eship2collisionnumber = Eship2collisionnumber + 1
		        	end
		        	if getName(object1) == "Eship2" then
		        		Eship3collisionnumber = Eship3collisionnumber + 1
		        	end
		        		
	        		table.insert(cubecloneList1, #cubecloneList1 + 1, getClone(testcube))
	        		table.insert(bpoint, #bpoint + 1, point1)
	   		
	   		end

	        

	        table.insert(cloneList, #cloneList + 1, getClone(Laser0)) -- create a clone 
	        table.insert(subcloneList, #subcloneList + 1, getClone(Laser1))
	    end	
	    	for i=1, #cubecloneList0 do
	    		setPosition(cubecloneList0[i], apoint[i])
	    	end
	    	for i=1, #cubecloneList1 do
	    		setPosition(cubecloneList1[i], bpoint[i])
	    	end

			for i=1, #cloneList do
		    	
		    	setParent(cloneList[i], 0)
				setParent(subcloneList[i], 0)

				translate(cloneList[i], {0.0, 50.0, 0.0}, "local")
				translate(subcloneList[i], {0.0, 50.0, 0.0}, "local")

			end
	end


	if gamepad then
		if onKeyDown("JOY1_BUTTON_LEFTSHOULDER") then 

			addCentralForce(ship, {-500.0, 0.0, 0.0}, "local")

			endpos0[1] = startpos0[1] + (endpos0[1] - startpos0[1])*1000
			endpos0[2] = startpos0[2] + (endpos0[2] - startpos0[2])*1000
			endpos0[3] = startpos0[3] + (endpos0[3] - startpos0[3])*1000

			endpos1[1] = startpos1[1] + (endpos1[1] - startpos1[1])*1000
			endpos1[2] = startpos1[2] + (endpos1[2] - startpos1[2])*1000
			endpos1[3] = startpos1[3] + (endpos1[3] - startpos1[3])*1000
	        
	        shots = shots + 2 --number of shots taken

			point0, object0 = rayHit(startpos0, endpos0)
	    	if point0 then
	    		if debug then
	    			print("hit at:")
	        		print(point0)
	        		print(getName(object0))
	        	end
		        	
		        	if getName(object1) == "Eship0" then
		        		Eship1collisionnumber = Eship1collisionnumber + 1
		        	end
		        	if getName(object1) == "Eship1" then
		        		Eship2collisionnumber = Eship2collisionnumber + 1
		        	end
		        	if getName(object1) == "Eship2" then
		        		Eship3collisionnumber = Eship3collisionnumber + 1
		        	end

	        		table.insert(cubecloneList0, #cubecloneList0 + 1, getClone(testcube))
	        		table.insert(apoint, #apoint + 1, point0)

	   		end
	   		point1, object1 = rayHit(startpos1, endpos1)
	    	if point1 then
	    		if debug then
		    		print("hit at:")
		        	print(point1)	-- print point of colision
		        	print(getName(object1))
	        	end
	        		
	        		if getName(object1) == "Eship0" then
		        		Eship1collisionnumber = Eship1collisionnumber + 1
		        	end
		        	if getName(object1) == "Eship1" then
		        		Eship2collisionnumber = Eship2collisionnumber + 1
		        	end
		        	if getName(object1) == "Eship2" then
		        		Eship3collisionnumber = Eship3collisionnumber + 1
		        	end
		        		
	        		table.insert(cubecloneList1, #cubecloneList1 + 1, getClone(testcube))
	        		table.insert(bpoint, #bpoint + 1, point1)
	   		
	   		end

	        

	        table.insert(cloneList, #cloneList + 1, getClone(Laser0)) -- create a clone 
	        table.insert(subcloneList, #subcloneList + 1, getClone(Laser1))
	    end	
	    	for i=1, #cubecloneList0 do
	    		setPosition(cubecloneList0[i], apoint[i])
	    	end
	    	for i=1, #cubecloneList1 do
	    		setPosition(cubecloneList1[i], bpoint[i])
	    	end

			for i=1, #cloneList do
		    	
		    	setParent(cloneList[i], 0)
				setParent(subcloneList[i], 0)

				translate(cloneList[i], {0.0, 50.0, 0.0}, "local")
				translate(subcloneList[i], {0.0, 50.0, 0.0}, "local")

			end
	end





------------------------------------
	--Aircraft AI and collision


	Eship2pos = getPosition(Eship2)
	shippos = getPosition(ship)

	if Eship1collisionnumber >= 4 then
		deactivate(Eship0)
	end
	if Eship2collisionnumber >= 4 then
		deactivate(Eship1)
	end
	if Eship3collisionnumber >= 4 then
		deactivate(Eship2)
	end
	
end
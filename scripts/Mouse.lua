Main = getScene("Scene-1")
Camera = getObject("Camera0")

debug = false
--replacement for mouse axis
window = getWindowScale()
mx = window[1] / 2
my = window[2] / 2

-- get objects
camera = getObject("Camera0")
cambody = getObject("Entity3")
ship = getObject("Entity0")
landmass = getObject("Entity1")
controlsText = getObject("Text")
skybox = getObject("Entity2")
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

--Shadow
enableShadow(ship, shadow)
enableShadow(landmass, shadow)


---------
dx = 0.0 -- change in mouse x-axis since last update
dy = 0.0 -- change in mouse y-axis since last update


shots = 0
shipcollision = true
shipcollisionnumber = 0
Eship0collisionnumber = 0
Eship1collisionnumber = 0
Eship2collisionnumber = 0

hideCursor()
centerCursor()

mx = getAxis("MOUSE_X")
my = getAxis("MOUSE_Y")

setText(controlsText, "W to accelerate | S to brake | A&D to roll | Mouse for pitch and yaw")
setTextColor(controlsText, {255, 0, 127, 255})
--------

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
		addCentralForce(ship, {6.0, 0.0, 0.0}, "local")
	end
	if isKeyPressed("A") then
		rotate(ship, {-1.0, 0.0, 0.0}, 0.55, "local") 

		rotate(cambody, {-1.0, 0.0, 0.0}, 0.55, "local") 
	end
	if isKeyPressed("D") then
		rotate(ship, {1.0, 0.0, 0.0}, 0.55, "local")
		rotate(cambody, {1.0, 0.0, 0.0}, 0.55, "local")

	end
	if isKeyPressed("S") then
		addCentralForce(ship, {-0.5, 0.0, 0.0}, "local")
	end
	if isKeyPressed("BACKSPACE") then
		menu()
	end
	--if isKeyPressed("SPACE") then
	--	land()
	--end
end

-- scene update
function onSceneUpdate()

		--Ship crash handeling

	if shipcollision then

			if isCollisionBetween(ship, landmass) then
				shipcollisionnumber = shipcollisionnumber + 1
			end
			if isCollisionBetween(ship, Eship0) then
				gameover()
			end
			if isCollisionBetween(ship, Eship1) then
				gameover()
			end
			if isCollisionBetween(ship, Eship2) then
				gameover()
			end
	
	end

	if shipcollisionnumber == 5 then
		gameover()
	end




--------
	-- rotate camera (X mouse)
	rotate(cambody, {0.0, 0.0, -1.0}, dx*150.0, "local")
	-- rotate camera (Y mouse)
	rotate(cambody, {0.0, -1.0, 0.0}, dy*150.0, "local")

	camrotation = getRotation(cambody)
	if camrotation[1] > 50.0 then	--Rotation limits on update
		camrotation[1] = 50.0
	elseif camrotation[1] < -50.0 then
		camrotation[1] = -50.0
	end
---------
	setRotation(cambody, camrotation)



	-- rotate Ship (X mouse)
	rotate(ship, {0.0, 0.0, -1.0}, dx*150.0, "local")
	
	-- rotate Ship (Y mouse)
	rotate(ship, {0.0, -1.0, 0.0}, dy*150.0, "local")	
	rotation = getRotation(ship)
	if rotation[1] > 50.0 then		--Rotation limits on update
		rotation[1] = 50.0
	elseif rotation[1] < -50.0 then
		rotation[1] = -50.0
	end
---------
	setRotation(ship, rotation)


	--ambient forces
	addCentralForce(ship, {0.0, 0.0, .196}, "local")
	addCentralForce(ship, {0.75, 0.0, 0.0}, "local")

	addCentralForce(Eship0, {0.0, 0.0, .196}, "local")
	addCentralForce(Eship0, {0.0, -0.75, 0.0}, "local")

	addCentralForce(Eship1, {0.0, 0.0, .196}, "local")
	addCentralForce(Eship1, {0.0, -0.75, 0.0}, "local")

	addCentralForce(Eship2, {0.0, 0.0, .196}, "local")
	addCentralForce(Eship2, {0.0, -0.75, 0.0}, "local")




	handleKeys()

	addCentralForce(ship, {0.0, dx, 0.0}, "local")
	addCentralForce(ship, {0.0, 0.0, dy}, "local")
 --------
	-- get mouse direction
	dx = getAxis("MOUSE_X") - mx
	dy = getAxis("MOUSE_Y") - my 

	-- center cursor
	centerCursor()
	

		--depricated		--mx = getAxis("MOUSE_X")
		--depricated		--my = getAxis("MOUSE_Y")
---------

 	--hit detection vars
	startpos0 = getPosition(hitstart0)
	endpos0 = getPosition(hitend0)

	startpos1 = getPosition(hitstart1)
	endpos1 = getPosition(hitend1)


	if onKeyDown("MOUSE_BUTTON1") then 
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
	        		Eship0collisionnumber = Eship0collisionnumber + 1
	        	end
	        	if getName(object1) == "Eship1" then
	        		Eship1collisionnumber = Eship1collisionnumber + 1
	        	end
	        	if getName(object1) == "Eship2" then
	        		Eship2collisionnumber = Eship2collisionnumber + 1
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
	        		Eship0collisionnumber = Eship0collisionnumber + 1
	        	end
	        	if getName(object1) == "Eship1" then
	        		Eship1collisionnumber = Eship1collisionnumber + 1
	        	end
	        	if getName(object1) == "Eship2" then
	        		Eship2collisionnumber = Eship2collisionnumber + 1
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





------------------------------------
	--Aircraft AI


	Eship2pos = getPosition(Eship2)
	shippos = getPosition(ship)

	if Eship0collisionnumber >= 4 then
		deactivate(Eship0)
	end
	if Eship1collisionnumber >= 4 then
		deactivate(Eship1)
	end
	if Eship2collisionnumber >= 4 then
		deactivate(Eship2)
	end

end
setTimer(function()
if useDefaultSafeZone == 1 then
safezone = createColSphere(safezoneX,  safezoneY, safezoneZ, safezoneSize)
setElementData(safezone, "issafezone", true )

	node = xmlLoadFile ( safeZoneXML )
	if ( node ) then
		loadMapData ( node, getRootElement() )
		xmlUnloadFile ( node )
	end
end
end, 5000, 1)

function createSafeZone(fx,fy,fz,fradius)
setElementData(createColSphere(fx,fy,fz,fradius), "issafezone", true)
end


setTimer(function()

shapes = getElementsByType("colshape")

for theKey,theShape in ipairs(shapes) do
 
	if getElementData(theShape, "issafezone") then

	peds = getElementsWithinColShape(theShape, "ped")

		for theKey,thePed in ipairs(peds) do        

			if getElementData(thePed, "zombie") then
				
				setElementPosition(thePed, 0, 0, -10)
				setTimer(function()
				killPed(thePed)
				end, 5000, 1 )
				
		end
	end
end
end
end, 30000, 0 )






function onSafeEnable(thePlayer, matchingdim)
if getElementType ( thePlayer ) == "player" and getElementData(source, "issafezone") then

playerName = getPlayerName(thePlayer)
outputChatBox("You entered the Safezone, report griefers at our Forums or Ingame!", thePlayer, 255, 255, 255, false)

setElementData(thePlayer, "safezone", "true")


triggerClientEvent(thePlayer, "enableSafeClient", getResourceRootElement(getThisResource()))
else 
if getElementData(thePlayer, "zombie") then
setElementPosition(thePlayer, 0, 0, -10)
setTimer(function()
killPed(thePlayer)
end, 5000, 1 )
end

end

end
addEventHandler("onColShapeHit", root, onSafeEnable)


function onSafeDisable(thePlayer, matchingdim)
   if getElementType ( thePlayer ) == "player" and getElementData(source, "issafezone") then 
   playerName = getPlayerName(thePlayer)
setElementData(thePlayer, "safezone", "false")
   outputChatBox("You left the Safezone, Watch out for Yourself!", thePlayer, 255, 255, 255, false)
	triggerClientEvent(thePlayer, "disableSafeClient", getResourceRootElement(getThisResource()))
   end
end
addEventHandler ( "onColShapeLeave", root, onSafeDisable )



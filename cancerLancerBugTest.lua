local cancerLancerBug = {}

cancerLancerBug.optionEnable = Menu.AddOption({ "Hero Specific", "Phantom Lancer" }, "Enable", "Enabled/Disabled the script.")
cancerLancerBug.optionKey = Menu.AddKeyOption({ "Hero Specific", "Phantom Lancer"}, "Execute bug.", Enum.ButtonCode.KEY_P)
cancerLancerBug.optionPanelXPos = Menu.AddOption({ "Hero Specific", "Phantom Lancer",}, "X-position", "", -200, 500, 10)
cancerLancerBug.optionPanelYPos = Menu.AddOption({ "Hero Specific", "Phantom Lancer"}, "Y-position", "", -500, 500, 10)
cancerLancerBug.panelSizeOption = Menu.AddOption({ "Hero Specific", "Phantom Lancer"}, "Panel Size", "", 20, 40, 2)

cancerLancerBug.Font = Renderer.LoadFont("Tahoma", 12, Enum.FontWeight.EXTRABOLD)
cancerLancerBug.targetSelector = 1
cancerLancerBug.targetFix = nil
cancerLancerBug.numberCombos = 0
cancerLancerBug.isSameTeamTable = {}

function cancerLancerBug.OnGameStart()
	cancerLancerBug.targetFix = nil
	-- Reset table HeroPanel.isSameTeamTable
	for keyTable = 1, #cancerLancerBug.isSameTeamTable do
			
		cancerLancerBug.isSameTeamTable[keyTable] = nil
	end
	cancerLancerBug.targetSelector = 1
	cancerLancerBug.numberCombos = 0
end

function cancerLancerBug.OnGameEnd()
	cancerLancerBug.targetFix = nil
	-- Reset table HeroPanel.isSameTeamTable
	for keyTable = 1, #cancerLancerBug.isSameTeamTable do
			
		cancerLancerBug.isSameTeamTable[keyTable] = nil
	end
	cancerLancerBug.targetSelector = 1
	cancerLancerBug.numberCombos = 0
end

function cancerLancerBug.OnScriptUnload()
	cancerLancerBug.targetFix = nil
	-- Reset table HeroPanel.isSameTeamTable
	for keyTable = 1, #cancerLancerBug.isSameTeamTable do
			
		cancerLancerBug.isSameTeamTable[keyTable] = nil
	end
	cancerLancerBug.targetSelector = 1
	cancerLancerBug.numberCombos = 0
end

function cancerLancerBug.OnScriptLoad()
	cancerLancerBug.targetFix = nil
	-- Reset table HeroPanel.isSameTeamTable
	for keyTable = 1, #cancerLancerBug.isSameTeamTable do
			
		cancerLancerBug.isSameTeamTable[keyTable] = nil
	end
	cancerLancerBug.targetSelector = 1
	cancerLancerBug.numberCombos = 0
end

function cancerLancerBug.OnUpdate()
	if not Menu.IsEnabled(cancerLancerBug.optionEnable) then return end
	local myHero = Heroes.GetLocal()
	
	if not myHero then return end 
	if NPC.GetUnitName(myHero) ~= "npc_dota_hero_phantom_lancer" then return end
	
	cancerLancerBug.targetFix = cancerLancerBug.isSameTeamTable[cancerLancerBug.targetSelector]

	if Menu.IsKeyDownOnce(cancerLancerBug.optionKey) then
		local abil = NPC.GetAbilityByIndex(myHero, 2)
	
		if not Ability.GetToggleState(abil) then
			Log.Write("True")
		else
			Log.Write("False")
		end
		
		 Player.PrepareUnitOrders( Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET, cancerLancerBug.targetFix, Vector(0,0,0), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_HERO_ONLY, myHero, false, true)
		 
		 Ability.Toggle(abil)
	end
	
end

function cancerLancerBug.OnDraw()
	if not Menu.IsEnabled(cancerLancerBug.optionEnable) then return end
	local myHero = Heroes.GetLocal()
	
	if not myHero then return end
	if	NPC.GetUnitName(myHero) ~= "npc_dota_hero_phantom_lancer" then return end
	
	local w, h = Renderer.GetScreenSize()
	Renderer.SetDrawColor(255, 255, 255)
	
	local startX = w - 300 - Menu.GetValue(cancerLancerBug.optionPanelXPos)
	local startY = 300 + Menu.GetValue(cancerLancerBug.optionPanelYPos)
	local imageSize = Menu.GetValue(cancerLancerBug.panelSizeOption)
	local maxSkills = 6
	local ctr = 0
	
	local hoveringOverCombo1 = Input.IsCursorInRect(startX+1, startY+1+(imageSize+2)*0 + 0, (imageSize * maxSkills)+2 , (imageSize+2))
	local hoveringOverCombo2 = Input.IsCursorInRect(startX+1, startY+1+(imageSize+2)*1 + 1, (imageSize * maxSkills)+2 , (imageSize+2))
	local hoveringOverCombo3 = Input.IsCursorInRect(startX+1, startY+1+(imageSize+2)*2 + 2, (imageSize * maxSkills)+2 , (imageSize+2))
	local hoveringOverCombo4 = Input.IsCursorInRect(startX+1, startY+1+(imageSize+2)*3 + 3, (imageSize * maxSkills)+2 , (imageSize+2))
	local hoveringOverCombo5 = Input.IsCursorInRect(startX+1, startY+1+(imageSize+2)*4 + 4, (imageSize * maxSkills)+2 , (imageSize+2))
	local hoveringOverCombo6 = Input.IsCursorInRect(startX+1, startY+1+(imageSize+2)*5 + 5, (imageSize * maxSkills)+2 , (imageSize+2))
	local hoveringOverCombo7 = Input.IsCursorInRect(startX+1, startY+1+(imageSize+2)*6 + 6, (imageSize * maxSkills)+2 , (imageSize+2))
	local hoveringOverCombo8 = Input.IsCursorInRect(startX+1, startY+1+(imageSize+2)*7 + 7, (imageSize * maxSkills)+2 , (imageSize+2))
	
	
	if #cancerLancerBug.isSameTeamTable == 0 then
   
		
		for i = 1, NPCs.Count() do
			local npcGetz = NPCs.Get(i)
			
			if  Entity.IsAlive(npcGetz) and not Entity.IsDormant(npcGetz) and NPC.IsTower(npcGetz) and Entity.IsSameTeam(myHero, npcGetz) and not NPC.GetModifier(npcGetz, "modifier_invulnerable")  then
				cancerLancerBug.numberCombos = cancerLancerBug.numberCombos + 1
				
				cancerLancerBug.isSameTeamTable[#cancerLancerBug.isSameTeamTable + 1] = npcGetz
				
			end
		end
	else
		for i = 1, #cancerLancerBug.isSameTeamTable do
			Renderer.DrawText(cancerLancerBug.Font, startX+2+imageSize*0, startY+3+(imageSize+2)*(i-1), NPC.GetUnitName(cancerLancerBug.isSameTeamTable[i]))
		end
		
		Log.Write(#cancerLancerBug.isSameTeamTable)
		if hoveringOverCombo1 and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
			cancerLancerBug.targetFix = cancerLancerBug.isSameTeamTable[1]
			cancerLancerBug.targetSelector = 1
			
		elseif hoveringOverCombo2 and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
			cancerLancerBug.targetFix = cancerLancerBug.isSameTeamTable[2]
			cancerLancerBug.targetSelector = 2
		elseif hoveringOverCombo3 and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
			cancerLancerBug.targetFix = cancerLancerBug.isSameTeamTable[3]
			cancerLancerBug.targetSelector = 3
		elseif hoveringOverCombo4 and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
			cancerLancerBug.targetFix = cancerLancerBug.isSameTeamTable[4]
			cancerLancerBug.targetSelector = 4
		elseif hoveringOverCombo5 and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
			cancerLancerBug.targetFix = cancerLancerBug.isSameTeamTable[5]
			cancerLancerBug.targetSelector = 5
		elseif hoveringOverCombo6 and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
			cancerLancerBug.targetFix = cancerLancerBug.isSameTeamTable[6]
			cancerLancerBug.targetSelector = 6
		elseif hoveringOverCombo7 and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
			cancerLancerBug.targetFix = cancerLancerBug.isSameTeamTable[7]
			cancerLancerBug.targetSelector = 7
		elseif hoveringOverCombo8 and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
			cancerLancerBug.targetFix = cancerLancerBug.isSameTeamTable[8]
			cancerLancerBug.targetSelector = 8
		end
	
		
		-- black border
		Renderer.SetDrawColor(0, 0, 0, 255)
		Renderer.DrawOutlineRect(startX, startY, (imageSize * maxSkills) + 4, ((imageSize+2) * cancerLancerBug.numberCombos) + 12)
		
		 -- black background
		Renderer.SetDrawColor(0, 0, 0, 150)
		Renderer.DrawFilledRect(startX, startY, (imageSize * maxSkills) + 4, ((imageSize+2) * cancerLancerBug.numberCombos) + 12)
		
			
		if cancerLancerBug.targetSelector == 1 then
			Renderer.SetDrawColor(0, 255, 0, 255)
			Renderer.DrawOutlineRect(startX+1, startY+1+(imageSize+2)*0 + 0, (imageSize * maxSkills)+2 , (imageSize+2))
		end
		if cancerLancerBug.targetSelector == 2 then
			Renderer.SetDrawColor(0, 255, 0, 255)
			Renderer.DrawOutlineRect(startX+1, startY+1+(imageSize+2)*1 + 1, (imageSize * maxSkills)+2 , (imageSize+2))
		end
		if cancerLancerBug.targetSelector == 3 then
			Renderer.SetDrawColor(0, 255, 0, 255)
			Renderer.DrawOutlineRect(startX+1, startY+1+(imageSize+2)*2 + 2, (imageSize * maxSkills)+2 , (imageSize+2))
		end
		if cancerLancerBug.targetSelector == 4 then
			Renderer.SetDrawColor(0, 255, 0, 255)
			Renderer.DrawOutlineRect(startX+1, startY+1+(imageSize+2)*3 + 3, (imageSize * maxSkills)+2 , (imageSize+2))
		end
		if cancerLancerBug.targetSelector == 5 then
			Renderer.SetDrawColor(0, 255, 0, 255)
			Renderer.DrawOutlineRect(startX+1, startY+1+(imageSize+2)*4 + 4, (imageSize * maxSkills)+2 , (imageSize+2))
		end
		if cancerLancerBug.targetSelector == 6 then
			Renderer.SetDrawColor(0, 255, 0, 255)
			Renderer.DrawOutlineRect(startX+1, startY+1+(imageSize+2)*5 + 5, (imageSize * maxSkills)+2 , (imageSize+2))
		end
		if cancerLancerBug.targetSelector == 7 then
			Renderer.SetDrawColor(0, 255, 0, 255)
			Renderer.DrawOutlineRect(startX+1, startY+1+(imageSize+2)*6 + 6, (imageSize * maxSkills)+2 , (imageSize+2))
		end
		if cancerLancerBug.targetSelector == 8 then
			Renderer.SetDrawColor(0, 255, 0, 255)
			Renderer.DrawOutlineRect(startX+1, startY+1+(imageSize+2)*7 + 7, (imageSize * maxSkills)+2 , (imageSize+2))
		end
	end
end

function cancerLancerBug.OnChatEvent(chatEvent)
	if not Menu.IsEnabled(cancerLancerBug.optionEnable) then return end
	
	if not Engine.IsInGame then return end
	
	if chatEvent.type == 3 then
		-- Reset table HeroPanel.isSameTeamTable
		for keyTable = 1, #cancerLancerBug.isSameTeamTable do
			
			cancerLancerBug.isSameTeamTable[keyTable] = nil
		end
		cancerLancerBug.targetSelector = 1
		cancerLancerBug.numberCombos = 0
	end
	
end

return cancerLancerBug

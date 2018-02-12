local CritAttack = {}
CritAttack.optionEnable = Menu.AddOption({"Kostya12rus", "AutoCrit"}, "Activation", "")
CritAttack.key = Menu.AddKeyOption({"Kostya12rus","AutoCrit"},"Key for critattak only target",Enum.ButtonCode.BUTTON_CODE_NONE)
CritAttack.font = Renderer.LoadFont("Tahoma", 50, Enum.FontWeight.EXTRABOLD)


function CritAttack.OnUnitAnimation(animation)
	if not Menu.IsEnabled(CritAttack.optionEnable) then return end
	if not Menu.IsKeyDown(CritAttack.key) then return end
	local myHero = Heroes.GetLocal()
	if not myHero then return end
	if NPC.GetUnitName(animation.unit) == NPC.GetUnitName(myHero) then
		for _,j in pairs(critattak) do
			if j == animation.sequenceName then
				timer = GameRules.GetGameTime() + NPC.GetAttackTime(myHero)/2
			end
		end
		
		for _,k in pairs(attacanim) do
			if k == animation.sequenceName then
				Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_STOP, myHero, Vector(0,0,0), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_HERO_ONLY)
			end
		end
	end
end

function CritAttack.OnUpdate()
	if not Menu.IsEnabled(CritAttack.optionEnable) then return end
	local myHero = Heroes.GetLocal()
	if not myHero then return end
	if Menu.IsKeyDown(CritAttack.key) then
		target = Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY)
		if target then
			if timer <= GameRules.GetGameTime() then
				Player.AttackTarget(Players.GetLocal(),myHero,target)
				if NPC.GetAttackTime(myHero)/2.5 < 0.3 then
					timer = GameRules.GetGameTime() + 0.25
				else
					timer = GameRules.GetGameTime() + NPC.GetAttackTime(myHero)/2.5
				end
			end
		end
	end
end

function CritAttack.OnGameStart()
	CritAttack.init()
end
function CritAttack.OnGameEnd()
	CritAttack.init()
end

function CritAttack.init()
	attackcrit = false
	target = nil
	timer = 0
	critattak = {
	 "phantom_assassin_attack_crit_anim"
	,"attack_crit_anim"
	,"attack_crit_alt_anim"
	,"crit"
	}
	attacanim = {
	 "attack01_fast"
	,"attack02_fast"
	,"attack01_faster"
	,"attack02_faster"
	,"phantom_assassin_attack_anim"
	,"phantom_assassin_attack_alt1_anim"
	,"attack3_anim"
	,"attack2_anim"
	,"attack_anim"
	,"attack_alt1_anim"
	,"attack"
	,"attack2"
	}
end
CritAttack.init()

return CritAttack
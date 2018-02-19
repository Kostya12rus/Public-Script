local KunkaStaker = {}
KunkaStaker.optionEnable = Menu.AddOption({"Utility", "Kunka Staker"}, "Activation", "")

function KunkaStaker.OnUpdate()
  if not Menu.IsEnabled(KunkaStaker.optionEnable) then return end
  local myHero = Heroes.GetLocal()
  if not myHero then return end
  local torrent = NPC.GetAbility(myHero, "kunkka_torrent")
  if torrent then
    needStaker = true
    if Ability.IsReady(torrent) then
      local rangetorrent = Ability.GetCastRange(torrent)
      local second = (GameRules.GetGameTime()-GameRules.GetGameStartTime())%60
      if second >= 60-1.6-1 then
        for _,camp in pairs(anchentpoint) do
          if camp[2] and NPC.IsPositionInRange(myHero,camp[1],rangetorrent) then
            Ability.CastPosition(torrent,camp[1])
          end
        end
      end
    end
  end
end

function KunkaStaker.OnDraw()
  if not Menu.IsEnabled(KunkaStaker.optionEnable) then return end
  if not needStaker then return end
  for _,camp in pairs(anchentpoint) do
    if camp then
      local X,Y,vis = Renderer.WorldToScreen(camp[1])
      if vis then
        if camp[2] then
          Renderer.SetDrawColor(0,255,0,150)
        else
          Renderer.SetDrawColor(255,0,0,150)
        end
        Renderer.DrawFilledRect(X-sizeBar/2,Y-sizeBar/2,sizeBar,sizeBar)
      end
      if Input.IsCursorInRect(X-sizeBar/2,Y-sizeBar/2,sizeBar,sizeBar) then
        if Input.IsKeyDownOnce(Enum.ButtonCode.KEY_LCONTROL) then
          camp[2] = not camp[2]
        end
      end
    end
  end
end

function KunkaStaker.init()
  sizeBar = 32
  needStaker = false
  anchentpoint = {
  {Vector(69,-1860,384),false},
  {Vector(3873,-577,256),false}}
end

function KunkaStaker.OnGameStart()
  KunkaStaker.init()
end

function KunkaStaker.OnGameEnd()
  KunkaStaker.init()
end

KunkaStaker.init()

return KunkaStaker
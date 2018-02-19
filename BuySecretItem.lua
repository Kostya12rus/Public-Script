local BuySecretItem = {}
BuySecretItem.optionEnable = Menu.AddOption({"Utility","Buy Secret Item"}, "Activate", "")
BuySecretItem.optionKey = Menu.AddKeyOption({"Utility","Buy Secret Item"},"Key for buy and drop",Enum.ButtonCode.KEY_NONE)

function BuySecretItem.OnDraw()
	if not Menu.IsEnabled(BuySecretItem.optionEnable) then return end
	local myHero = Heroes.GetLocal()
	if not myHero then return end 
	if buyitem and trigerTimes <= GameRules.GetGameTime()then
		for index_item = 0, 15 do
			local item = NPC.GetItemByIndex(myHero, index_item)
			if item and Entity.IsAbility(item) then
				local itemName = Ability.GetName(item)
				for _,nameitem in pairs(itemlist) do
					if itemName == nameitem then
						BuySecretItem.DropItem(item)
					end
				end
			end
			if index_item == 14 then
				buyitem = false
			end
		end
	end
	if Menu.IsKeyDownOnce(BuySecretItem.optionKey) then
		for i = 21,27 do
			itemid = 1000+i
			BuySecretItem.BuyWard(itemid)
		end
		trigerTimes = GameRules.GetGameTime() + 0.5
		buyitem = true
	end
end

function BuySecretItem.DropItem(item)
	Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_DROP_ITEM, item, Entity.GetAbsOrigin(Heroes.GetLocal()), item, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, Heroes.GetLocal(), false, true)
end

function BuySecretItem.BuyWard(item)
	Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_PURCHASE_ITEM, item, Vector(0, 0, 0), item, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, Heroes.GetLocal(), false, true)
end

function BuySecretItem.init()
trigerTimes = 0
buyitem = false
itemlist = {
  "item_river_painter",
  "item_river_painter2",
  "item_river_painter3",
  "item_river_painter4",
  "item_river_painter5",
  "item_river_painter6",
  "item_river_painter7"	
}
end
function BuySecretItem.OnGameStart()
	BuySecretItem.init()
end
BuySecretItem.init()

return BuySecretItem
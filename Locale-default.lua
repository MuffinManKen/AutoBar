
local function atl(key, name)
	AutoBar.locale[key] = AutoBar.locale[key] or name;
end

atl("AutoBar.Food.Health.Basic", AutoBar.locale["Consumable.Food.Edible.Basic.Non-Conjured"]);
atl("AutoBar.Food.Mana.Basic", AutoBar.locale["Consumable.Water.Basic"]);
atl("AutoBar.Food.Combo.Basic", AutoBar.locale["Consumable.Food.Edible.Combo.Non-Conjured"]);
atl("AutoBar.SunsongRanch", "Sunsong Ranch");
atl("AutoBarButtonSunsongRanch", "Sunsong Ranch");

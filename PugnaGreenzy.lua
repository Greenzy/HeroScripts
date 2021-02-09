local PugnaBest = {}

PugnaBest.IsScriptEnabled = Menu.AddOptionBool({ "Hero Specific", "PugnaB" }, "Enable script", true)
PugnaBest.ComboButton = Menu.AddKeyOption({ "Hero Specific", "PugnaB" }, "Combo button", KEY_NONE)
PugnaBest.UseBlast_b = Menu.AddOptionBool({ "Hero Specific", "PugnaB",  "Items/Abilities to cast in combo" }, "Use blast in combo", true)
PugnaBest.UseNetherWard_b = Menu.AddOptionBool({ "Hero Specific", "PugnaB",  "Items/Abilities to cast in combo" }, "Use nether ward in combo", true)
PugnaBest.ShowBlastInfoW_b = Menu.AddOptionBool({ "Hero Specific", "PugnaB" , "Pugna info screen" }, "Show hp after blast with decrepify", true)
PugnaBest.ShowBlastInfoWO_b = Menu.AddOptionBool({ "Hero Specific", "PugnaB" , "Pugna info screen" }, "Show hp after blast w/o decrepify", true)
PugnaBest.ShowTowerBlastDamage = Menu.AddOptionBool({ "Hero Specific", "PugnaB" , "Pugna info screen" }, "Blast tower damage", true)
PugnaBest.ShowBlastLastHitHelper = Menu.AddOptionBool({ "Hero Specific", "PugnaB" , "Pugna info screen" }, "Blast lasthit helper", true)
PugnaBest.LastHitHelperRange =  Menu.AddOptionSlider({ "Hero Specific", "PugnaB" , "Pugna info screen"}, "Show Creep Info In Range", 100, 3000, 1500)
PugnaBest.RangeFromMouseToCast =  Menu.AddOptionSlider({ "Hero Specific", "PugnaB" }, "Use combo in range from mouse", 100, 1000, 300)
PugnaBest.BreakLinken_b = Menu.AddOptionBool({ "Hero Specific", "PugnaB",  "Items/Abilities to cast in combo" }, "Break linken", true)
PugnaBest.BlinkSetting = Menu.AddOptionCombo({ "Hero Specific", "PugnaB", "Blink setting"}, "Blink type", {"Blink to cursor", "Blink to enemy"}, 0)
PugnaBest.BlinkUseRange =  Menu.AddOptionSlider({ "Hero Specific", "PugnaB" , "Blink setting"}, "Don't use blink if enemy in range", 0, 1000, 300)

PugnaBest.ItemsForCast = Menu.AddOptionMultiSelect({"Hero Specific", "PugnaB", "Items/Abilities to cast in combo", "Combo items"}, "Combo items:", 
{
	{"Hex", "panorama/images/items/sheepstick_png.vtex_c", true},
	{"Dagon", "panorama/images/items/dagon_5_png.vtex_c", true},
	{"GlimmerCape", "panorama/images/items/glimmer_cape_png.vtex_c", true},
	{"EtherialBlade", "panorama/images/items/ethereal_blade_png.vtex_c", true},
	{"Blink", "panorama/images/items/blink_png.vtex_c", true},
	{"Veil", "panorama/images/items/veil_of_discord_png.vtex_c", true},
	{"Nulifier", "panorama/images/items/nullifier_png.vtex_c", true},
	{"BloodThorn", "panorama/images/items/bloodthorn_png.vtex_c", true},
	{"Orchid", "panorama/images/items/orchid_png.vtex_c", true},
	{"Shiva", "panorama/images/items/shivas_guard_png.vtex_c", true},
	{"Atos", "panorama/images/items/rod_of_atos_png.vtex_c", true},
	{"Halberd", "panorama/images/items/heavens_halberd_png.vtex_c", true}
}, false)

PugnaBest.LinkenBreakItems = Menu.AddOptionMultiSelect({"Hero Specific", "PugnaB", "Items/Abilities to cast in combo", "Linken break items"}, "Linken break items:", 
{
	{"Halberd", "panorama/images/items/heavens_halberd_png.vtex_c", true},
	{"BloodThorn", "panorama/images/items/bloodthorn_png.vtex_c", true},
	{"Orchid", "panorama/images/items/orchid_png.vtex_c", true},
	{"Hex", "panorama/images/items/sheepstick_png.vtex_c", true},
	{"Dagon", "panorama/images/items/dagon_5_png.vtex_c", true}
}, false)



--sphere_png.vtex_c
Menu.AddMenuIcon({"Hero Specific",  "PugnaB", "Items/Abilities to cast in combo"}, "panorama/images/cursor/cursor_cast_png.vtex_c")
Menu.AddMenuIcon({"Hero Specific", "PugnaB", "Pugna info screen"}, "panorama/images/hud/gold_graph_icon_png.vtex_c")
Menu.AddMenuIcon({"Hero Specific", "PugnaB"}, "panorama/images/heroes/icons/npc_dota_hero_pugna_png.vtex_c")
Menu.AddMenuIcon({"Hero Specific", "PugnaB", "Blink setting"}, "panorama/images/items/blink_png.vtex_c")
Menu.AddOptionIcon(PugnaBest.UseBlast_b, "panorama/images/spellicons/pugna_nether_blast_png.vtex_c")
Menu.AddOptionIcon(PugnaBest.UseNetherWard_b, "panorama/images/spellicons/pugna_nether_ward_png.vtex_c")
Menu.AddOptionIcon(PugnaBest.ShowBlastInfoW_b, "panorama/images/spellicons/pugna_decrepify_png.vtex_c")
Menu.AddOptionIcon(PugnaBest.ShowBlastInfoWO_b, "panorama/images/spellicons/pugna_nether_blast_png.vtex_c")
Menu.AddOptionIcon(PugnaBest.IsScriptEnabled, "panorama/images/hud/portrait_silenced_png.vtex_c")
Menu.AddOptionIcon(PugnaBest.BreakLinken_b, "panorama/images/items/sphere_png.vtex_c")
Menu.AddOptionIcon(PugnaBest.ShowTowerBlastDamage, "panorama/images/heroes/npc_dota_hero_tower_radiant_png.vtex_c")
Menu.AddOptionIcon(PugnaBest.ShowBlastLastHitHelper, "panorama/images/heroes/npc_dota_hero_creep_radiant_png.vtex_c")

local LocalHero = Heroes.GetLocal() -- Local hero pointer
local LocalHeroIndex = 0 -- Local Hero Index

local Blast_obj = nil -- Blast Object
local Decrepify_obj = nil -- Decrepify Object
local BlastBonusDamage_obj = nil -- bonus damage from talant
local LifeDrain_obj = nil -- Ultimate object
local NetherWard_obj = nil -- nether ward object
local Entities = nil -- All entities 
local Enemy = nil
local NetherWardRange = 0 -- Nether ward cast range
local CurrentBlastDamage = 0 -- Blast damage 
local CurrentDecrepifyRes = 0 -- Decrepify resistance debuff 
local CurrentLifeDrainDamage = 0 -- Life Drain damage/heal
local TowerParticle = 0
local BaseSpellAmp = 0

local ItemHex_obj = nil
local ItemDagon_obj = nil
local ItemDagon2_obj = nil
local ItemDagon3_obj = nil
local ItemDagon4_obj = nil
local ItemDagon5_obj = nil
local ItemBlink_obj = nil
local ItemSBlinkA_obj = nil
local ItemSBlinkS_obj = nil
local ItemSBlinkI_obj = nil
local ItemGlimmer_obj = nil
local ItemEBlade_obj = nil
local ItemVeil_obj = nil
local ItemNulifier_obj = nil
local ItemBloodThorn_obj = nil
local ItemOrchid_obj = nil 
local ItemShiva_obj = nil 
local ItemAtos_obj = nil 
local ItemHalberd_obj = nil 



local TowerParticle = 0
local CurrentParticleTarget = nil

--defines for cast type
local CAST_TARGET = 1
local CAST_POSITION = 2
local CAST_NO_TARGET = 3


local font = Renderer.LoadFont("Verdana",  20, Enum.FontCreate.FONTFLAG_ANTIALIAS, 2)

function PugnaBest.DrawEnemyHpAfterBlast() -- s4itat v onupdate i peredavat zna4eniye v ondraw
	if not Menu.IsEnabled(PugnaBest.ShowBlastInfoW_b) and not Menu.IsEnabled(PugnaBest.ShowBlastInfoWO_b) then
		return
	end
	Renderer.SetDrawColor(0, 255, 0, 255)
	local Entities = Heroes.GetAll()
	local EnemyMagicRes = 0
	local EnemyHP = 0
	local x,y = 0
	local EnemyEnt = nil
	local TrueBlastDamage_WD = 0 
	local TrueBlastDamage_WOD = 0

	if Ability.GetLevel(BlastBonusDamage_obj) == 1 then
		TrueBlastDamage_WOD = (CurrentBlastDamage + Ability.GetLevelSpecialValueFor(BlastBonusDamage_obj, "value")) * BaseSpellAmp 
		TrueBlastDamage_WD = (CurrentBlastDamage + Ability.GetLevelSpecialValueFor(BlastBonusDamage_obj, "value")) * BaseSpellAmp 
	else
		TrueBlastDamage_WOD = CurrentBlastDamage * BaseSpellAmp
		TrueBlastDamage_WD = CurrentBlastDamage * BaseSpellAmp
	end
	
	for index, ent in pairs(Entities) do

		if not Entity.IsDormant(ent) and Entity.IsAlive(ent) and not Entity.IsSameTeam(ent, LocalHero) then 
			x,y = Renderer.WorldToScreen(Entity.GetOrigin(ent))
			EnemyMagicRes = 1 - NPC.GetMagicalArmorValue(ent)
			TrueBlastDamage_WOD = TrueBlastDamage_WOD * EnemyMagicRes
			EnemyHp = Entity.GetHealth(ent)

			if Menu.IsEnabled(PugnaBest.ShowBlastInfoWO_b) then
				HpAfterBlast = EnemyHp - TrueBlastDamage_WOD
				Renderer.DrawText(font, x, y, math.floor(HpAfterBlast))
			end

			if Menu.IsEnabled(PugnaBest.ShowBlastInfoW_b) then
				if not NPC.HasModifier(ent, "modifier_pugna_decrepify")  then
					TrueBlastDamage_WD = TrueBlastDamage_WD * (EnemyMagicRes - ((CurrentDecrepifyRes * 0.01) * EnemyMagicRes))
				else
					TrueBlastDamage_WD = TrueBlastDamage_WOD
				end

				HpAfterBlast = EnemyHp - TrueBlastDamage_WD
				Renderer.DrawText(font, x, y+18, math.floor(HpAfterBlast))
			end

		end	
	end
end


function PugnaBest.IsItemNotInStash(ItemName)

	if NPC.HasItem(LocalHero, ItemName) then
		return true
	else
		return false
	end

end

function PugnaBest.CreateParticleToTarget()

	if not PugnaBest.PlayerCanCastOnEnemy() then
		if TowerParticle ~= 0 then
			Particle.Destroy(TowerParticle)			
			TowerParticle = 0
		end
		return
	end

	local ParticleEntity = Input.GetNearestHeroToCursor(Entity.GetTeamNum(LocalHero), TEAM_ENEMY)
	if true then	
		if not ParticleEntity or(not NPC.IsPositionInRange(ParticleEntity, Input.GetWorldCursorPos(), Menu.GetValue(PugnaBest.RangeFromMouseToCast), 0) and TowerParticle ~= 0) then
			Particle.Destroy(TowerParticle)			
			TowerParticle = 0
		else
			if TowerParticle == 0 and NPC.IsPositionInRange(ParticleEntity, Input.GetWorldCursorPos(), Menu.GetValue(PugnaBest.RangeFromMouseToCast), 0) then
				TowerParticle = Particle.Create("particles/ui_mouseactions/range_finder_tower_aoe.vpcf", Enum.ParticleAttachment.PATTACH_INVALID, ParticleEntity)				
			end
			if TowerParticle ~= 0 then
				Particle.SetControlPoint(TowerParticle, 2, Entity.GetOrigin(LocalHero))
				Particle.SetControlPoint(TowerParticle, 6, Vector(1, 0, 0))
				Particle.SetControlPoint(TowerParticle, 7, Entity.GetOrigin(ParticleEntity))
			end
		end
	else 
		if TowerParticle ~= 0 then
			Particle.Destroy(TowerParticle)			
			TowerParticle = 0
		end
	end
end


function PugnaBest.UseItem(Item_obj, ItemNameString, ItemTable, CastType, Target) -- For cast position target = Vector(xyz). For cast on target enemy entity.If no target give 0 to Target value

	if CastType == CAST_TARGET then
		if Item_obj and Ability.IsReady(Item_obj) and PugnaBest.IsItemNotInStash(Ability.GetName(Item_obj)) and Menu.IsSelected(ItemTable, ItemNameString) and  Ability.IsCastable(Item_obj, NPC.GetMana(LocalHero)) then
			Ability.CastTarget(Item_obj, Target)
			return true
		end
	elseif CastType == CAST_POSITION then
		if Item_obj and Ability.IsReady(Item_obj) and PugnaBest.IsItemNotInStash(Ability.GetName(Item_obj)) and Menu.IsSelected(ItemTable, ItemNameString) and  Ability.IsCastable(Item_obj, NPC.GetMana(LocalHero)) then
			Ability.CastPosition(Item_obj, Target)
			return true
		end
	elseif CastType == CAST_NO_TARGET then
		if Item_obj and Ability.IsReady(Item_obj) and PugnaBest.IsItemNotInStash(Ability.GetName(Item_obj)) and Menu.IsSelected(ItemTable, ItemNameString) and  Ability.IsCastable(Item_obj, NPC.GetMana(LocalHero)) then
			Ability.CastNoTarget(Item_obj)
			return true
		end
	end

	return false
end

function PugnaBest.UseAbility(Ability_obj, CastType, Target)  -- For cast position target = Vector(xyz). For cast on target enemy entity.
	
	if Ability_obj and Ability.GetName(Ability_obj) == "pugna_nether_blast" then

		if Ability_obj and Ability.IsReady(Ability_obj) and Menu.IsEnabled(PugnaBest.UseBlast_b) and Ability.IsCastable(Ability_obj, NPC.GetMana(LocalHero)) then
			Ability.CastPosition(Ability_obj, Target)
			return true
		end
	end

	if Ability_obj and Ability.GetName(Ability_obj) == "pugna_nether_ward" then

		if Ability_obj and Ability.IsReady(Ability_obj) and Menu.IsEnabled(PugnaBest.UseNetherWard_b) and Ability.IsCastable(Ability_obj, NPC.GetMana(LocalHero)) then
			Ability.CastPosition(Ability_obj, Target)
			return true
		end
	end

	if CastType == CAST_TARGET then

		if Ability_obj and Ability.IsReady(Ability_obj) and Ability.IsCastable(Ability_obj, NPC.GetMana(LocalHero)) then
			Ability.CastTarget(Ability_obj, Target)
			return true
		end
	elseif CastType == CAST_POSITION then

		if Ability_obj and Ability.IsReady(Ability_obj) and Ability.IsCastable(Ability_obj, NPC.GetMana(LocalHero)) then
			Ability.CastPosition(Ability_obj, Target)
			return true
		end
	end

	return false
end


function PugnaBest.BreakLinken()
	if PugnaBest.UseItem(ItemHalberd_obj, "Halberd", PugnaBest.LinkenBreakItems,  CAST_TARGET, Enemy) then return end
	if PugnaBest.UseItem(ItemBloodThorn_obj, "BloodThorn", PugnaBest.LinkenBreakItems,  CAST_TARGET, Enemy) then return end
	if PugnaBest.UseItem(ItemOrchid_obj, "Orchid", PugnaBest.LinkenBreakItems,  CAST_TARGET, Enemy) then return end
	if PugnaBest.UseItem(ItemDagon_obj, "Dagon",PugnaBest.LinkenBreakItems, CAST_TARGET, Enemy) then return end
	if PugnaBest.UseItem(ItemHex_obj, "Hex",PugnaBest.LinkenBreakItems, CAST_TARGET, Enemy) then return end

end

function PugnaBest.BlinkCast(Item_obj,ItemNameString,ItemTable)

	if Menu.GetValue(PugnaBest.BlinkSetting) == 0 then
		if Item_obj and Ability.IsReady(Item_obj) and PugnaBest.IsItemNotInStash(Ability.GetName(Item_obj)) and Menu.IsSelected(ItemTable, ItemNameString) and  Ability.IsCastable(Item_obj, NPC.GetMana(LocalHero)) then
			if NPC.IsEntityInRange(LocalHero, Enemy, Menu.GetValue(PugnaBest.BlinkUseRange)) then 
				return false
			end
			Ability.CastPosition(Item_obj, Input.GetWorldCursorPos())
			return true
		end
	elseif Menu.GetValue(PugnaBest.BlinkSetting) == 1 then
		if Item_obj and Ability.IsReady(Item_obj) and PugnaBest.IsItemNotInStash(Ability.GetName(Item_obj)) and Menu.IsSelected(ItemTable, ItemNameString) and  Ability.IsCastable(Item_obj, NPC.GetMana(LocalHero)) then
			
			if NPC.IsEntityInRange(LocalHero, Enemy, Menu.GetValue(PugnaBest.BlinkUseRange)) then 
				return false
			end

			local CastRange = Ability.GetLevelSpecialValueFor(Item_obj, "blink_range") + NPC.GetCastRangeBonus(Local)
			local Distance = Entity.GetOrigin(Enemy) - Entity.GetOrigin(LocalHero)
			Distance:SetZ(0)
			Distance:Normalize()
			Distance:Scale(CastRange)

			local BlinkPos = Distance + Entity.GetOrigin(LocalHero) 

			Ability.CastPosition(Item_obj, BlinkPos)
			return true
		end
	end

	return false
end
function PugnaBest.PlayerCanCastOnEnemy()
	local Distance = Entity.GetOrigin(LocalHero):Distance(Entity.GetOrigin(Enemy))
	local Distance2D = Distance:Length2D()
	if Distance2D > (1200 + NPC.GetCastRangeBonus(Local) + 200) then
		return false
	end

	return true
end
function PugnaBest.AutoCast()
	
	if not Input.IsKeyDown(Menu.GetValue(PugnaBest.ComboButton)) or Input.IsInputCaptured() or Ability.IsChannelling(LifeDrain_obj) or NPC.HasState(Enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) or NPC.IsSilenced(LocalHero) or not PugnaBest.PlayerCanCastOnEnemy() then
		return
	end
	if not NPC.IsPositionInRange(Enemy, Input.GetWorldCursorPos(), Menu.GetValue(PugnaBest.RangeFromMouseToCast), 0) then
		return
	end
	if Menu.IsEnabled(PugnaBest.BreakLinken_b) and NPC.IsLinkensProtected(Enemy) then
		if PugnaBest.UseItem(ItemGlimmer_obj, "GlimmerCape", PugnaBest.ItemsForCast ,CAST_TARGET, LocalHero) then return end
		if PugnaBest.BlinkCast(ItemBlink_obj, "Blink", PugnaBest.ItemsForCast) then return end
		if PugnaBest.BlinkCast(ItemSBlinkI_obj, "Blink", PugnaBest.ItemsForCast) then return end
		if PugnaBest.BlinkCast(ItemSBlinkS_obj, "Blink", PugnaBest.ItemsForCast) then return end
		if PugnaBest.BlinkCast(ItemSBlinkA_obj, "Blink", PugnaBest.ItemsForCast) then return end
		PugnaBest.BreakLinken()
		return
	end
		
	if PugnaBest.UseItem(ItemGlimmer_obj, "GlimmerCape", PugnaBest.ItemsForCast ,CAST_TARGET, LocalHero) then return end
	if PugnaBest.BlinkCast(ItemBlink_obj, "Blink", PugnaBest.ItemsForCast) then return end
	if PugnaBest.BlinkCast(ItemSBlinkI_obj, "Blink", PugnaBest.ItemsForCast) then return end
	if PugnaBest.BlinkCast(ItemSBlinkS_obj, "Blink", PugnaBest.ItemsForCast) then return end
	if PugnaBest.BlinkCast(ItemSBlinkA_obj, "Blink", PugnaBest.ItemsForCast) then return end
	if PugnaBest.UseItem(ItemHex_obj, "Hex", PugnaBest.ItemsForCast,  CAST_TARGET, Enemy) then return end
	if PugnaBest.UseItem(ItemHalberd_obj, "Halberd", PugnaBest.ItemsForCast,  CAST_TARGET, Enemy) then return end
	if PugnaBest.UseItem(ItemAtos_obj, "Atos", PugnaBest.ItemsForCast,  CAST_TARGET, Enemy) then return end
	if PugnaBest.UseItem(ItemShiva_obj, "Shiva", PugnaBest.ItemsForCast,  CAST_NO_TARGET, 0) then return end
	if PugnaBest.UseItem(ItemNulifier_obj, "Nulifier", PugnaBest.ItemsForCast,  CAST_TARGET, Enemy) then return end
	if PugnaBest.UseItem(ItemBloodThorn_obj, "BloodThorn", PugnaBest.ItemsForCast,  CAST_TARGET, Enemy) then return end
	if PugnaBest.UseItem(ItemOrchid_obj, "Orchid", PugnaBest.ItemsForCast,  CAST_TARGET, Enemy) then return end
	if PugnaBest.UseAbility(NetherWard_obj, CAST_POSITION, Entity.GetOrigin(LocalHero)) then return end
	if PugnaBest.UseItem(ItemVeil_obj, "Veil", PugnaBest.ItemsForCast , CAST_POSITION, Entity.GetOrigin(Enemy)) then return end
	if PugnaBest.UseItem(ItemEBlade_obj, "EtherialBlade", PugnaBest.ItemsForCast,  CAST_TARGET, Enemy) then return end
	if PugnaBest.UseAbility(Blast_obj, CAST_POSITION, Entity.GetOrigin(Enemy)) then return end
	if PugnaBest.UseAbility(Decrepify_obj, CAST_TARGET, Enemy) then return end
	if PugnaBest.UseItem(ItemDagon_obj, "Dagon", PugnaBest.ItemsForCast , CAST_TARGET, Enemy) then return end
	if PugnaBest.UseItem(ItemDagon2_obj, "Dagon", PugnaBest.ItemsForCast , CAST_TARGET, Enemy) then return end
	if PugnaBest.UseItem(ItemDagon3_obj, "Dagon", PugnaBest.ItemsForCast , CAST_TARGET, Enemy) then return end
	if PugnaBest.UseItem(ItemDagon4_obj, "Dagon", PugnaBest.ItemsForCast , CAST_TARGET, Enemy) then return end
	if PugnaBest.UseItem(ItemDagon5_obj, "Dagon", PugnaBest.ItemsForCast , CAST_TARGET, Enemy) then return end
	if PugnaBest.UseAbility(LifeDrain_obj, CAST_TARGET, Enemy) then return end

end

function PugnaBest.GetAbilities()
	Blast_obj = NPC.GetAbility(LocalHero, "pugna_nether_blast")
	Decrepify_obj = NPC.GetAbility(LocalHero, "pugna_decrepify")
	BlastBonusDamage_obj = NPC.GetAbility(LocalHero, "special_bonus_unique_pugna_2") -- talant bonus
	LifeDrain_obj =  NPC.GetAbility(LocalHero, "pugna_life_drain")
	NetherWard_obj = NPC.GetAbility(LocalHero, "pugna_nether_ward") 

	NetherWardRange = Ability.GetLevelSpecialValueFor(NetherWard_obj, "radius") -- Nether ward cast range
	CurrentBlastDamage = Ability.GetLevelSpecialValueFor(Blast_obj, "blast_damage") -- Blast damage
	CurrentLifeDrainDamage = Ability.GetLevelSpecialValueFor(LifeDrain_obj, "health_drain") -- ultamate damage/heal
	CurrentDecrepifyRes = Ability.GetLevelSpecialValueFor(Decrepify_obj, "bonus_spell_damage_pct") -- minus resist value from decripify
end

function PugnaBest.GetItems()
	ItemHex_obj = NPC.GetAbility(LocalHero, "item_sheepstick") 
	ItemDagon_obj = NPC.GetAbility(LocalHero, "item_dagon") 
	ItemDagon2_obj = NPC.GetAbility(LocalHero, "item_dagon_2") 
	ItemDagon3_obj = NPC.GetAbility(LocalHero, "item_dagon_3") 
	ItemDagon4_obj = NPC.GetAbility(LocalHero, "item_dagon_4") 
	ItemDagon5_obj = NPC.GetAbility(LocalHero, "item_dagon_5") 
	ItemBlink_obj = NPC.GetAbility(LocalHero, "item_blink") 
	ItemSBlinkA_obj = NPC.GetAbility(LocalHero, "item_swift_blink") 
	ItemSBlinkS_obj = NPC.GetAbility(LocalHero, "item_overwhelming_blink") 
	ItemSBlinkI_obj = NPC.GetAbility(LocalHero, "item_arcane_blink") 
	ItemGlimmer_obj = NPC.GetAbility(LocalHero, "item_glimmer_cape") 
	ItemEBlade_obj = NPC.GetAbility(LocalHero, "item_ethereal_blade") 
	ItemVeil_obj = NPC.GetAbility(LocalHero, "item_veil_of_discord")
	ItemNulifier_obj = NPC.GetAbility(LocalHero, "item_nullifier")
	ItemBloodThorn_obj = NPC.GetAbility(LocalHero, "item_bloodthorn")
	ItemOrchid_obj = NPC.GetAbility(LocalHero, "item_orchid")
	ItemShiva_obj = NPC.GetAbility(LocalHero, "item_shivas_guard")
	ItemAtos_obj = NPC.GetAbility(LocalHero, "item_rod_of_atos")
	ItemHalberd_obj = NPC.GetAbility(LocalHero, "item_heavens_halberd")

end


function PugnaBest.GetStructHpAfterBlast(TowerEntity) 
	local CurrentHealth = Entity.GetHealth(TowerEntity)
	local BlastDamage
	local HpAfterBlast

	if Ability.GetLevel(BlastBonusDamage_obj) == 1 then
		BlastDamage = (CurrentBlastDamage + Ability.GetLevelSpecialValueFor(BlastBonusDamage_obj, "value")) * BaseSpellAmp * 0.5
	else
		BlastDamage = CurrentBlastDamage * BaseSpellAmp * 0.5
	end

	HpAfterBlast = CurrentHealth - BlastDamage

	return HpAfterBlast
end

function PugnaBest.BlastDamageTower()
	if not Menu.IsEnabled(PugnaBest.ShowTowerBlastDamage) then
		return 
	end
	local Entities = Towers.GetAll()

	for index, ent in pairs(Entities) do

		if ent and not Entity.IsSameTeam(ent, LocalHero) and not NPC.HasState(ent, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) and Entity.IsAlive(ent) then
			local x,y = Renderer.WorldToScreen(Entity.GetOrigin(ent))
			local HpAfterBlast = PugnaBest.GetStructHpAfterBlast(ent)
			Renderer.DrawText(font, x, y, math.floor(HpAfterBlast))
		end
	end
end

function PugnaBest.BlastLastHitHelper()
	if not Menu.IsEnabled(PugnaBest.ShowBlastLastHitHelper) then
		return
	end
	
	local Entities = NPCs.GetAll()
	local TrueBlastDamage = 0 
	local EnemyMagicRes = 0

	if Ability.GetLevel(BlastBonusDamage_obj) == 1 then
		TrueBlastDamage = (CurrentBlastDamage + Ability.GetLevelSpecialValueFor(BlastBonusDamage_obj, "value")) * BaseSpellAmp 
	else
		TrueBlastDamage = CurrentBlastDamage * BaseSpellAmp
	end

	for index, ent in pairs(Entities) do
		if ent and NPC.IsLaneCreep(ent) and not Entity.IsDormant(ent) and not Entity.IsSameTeam(ent, LocalHero) and Entity.IsAlive(ent) and NPC.IsPositionInRange(LocalHero, Entity.GetOrigin(ent), Menu.GetValue(PugnaBest.LastHitHelperRange), 0) then
			EnemyMagicRes = 1 - NPC.GetMagicalArmorValue(ent)
			local CreepHp = Entity.GetHealth(ent)
			local x,y = Renderer.WorldToScreen(Entity.GetOrigin(ent))
			local HpAfterBlast = CreepHp - TrueBlastDamage * EnemyMagicRes
			if HpAfterBlast < 0 then
				Renderer.DrawText(font, x, y, "Lethal")
			else
				Renderer.DrawText(font, x, y, math.floor(HpAfterBlast))
			end
			
		end
	end
end

function PugnaBest.UpdateGlobalVars()
	BaseSpellAmp = NPC.GetBaseSpellAmp(LocalHero) * 0.01 + 1
	LocalHero = Heroes.GetLocal()
	Enemy = Input.GetNearestHeroToCursor(Entity.GetTeamNum(LocalHero), TEAM_ENEMY)
end

function PugnaBest.OnUpdate()

	if not Menu.IsEnabled(PugnaBest.IsScriptEnabled) or not Engine.IsInGame() or not (NPC.GetUnitName(LocalHero) == "npc_dota_hero_pugna") then
		if TowerParticle ~= 0 then
			Particle.Destroy(TowerParticle)			
			TowerParticle = 0
		end
		return
	end
	
	PugnaBest.UpdateGlobalVars()

	PugnaBest.GetAbilities()
	PugnaBest.GetItems()

	PugnaBest.AutoCast()

end


function PugnaBest.OnDraw()

	if not Menu.IsEnabled(PugnaBest.IsScriptEnabled) or not Engine.IsInGame() or not (NPC.GetUnitName(LocalHero) == "npc_dota_hero_pugna")then

		return
	end

	PugnaBest.CreateParticleToTarget()
	PugnaBest.DrawEnemyHpAfterBlast()
	PugnaBest.BlastDamageTower()
	PugnaBest.BlastLastHitHelper()
end


Config.WriteInt("mini_games", "best_score", best_score)

return PugnaBest
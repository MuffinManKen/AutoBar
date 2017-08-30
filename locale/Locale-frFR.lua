﻿--
-- AutoBar
-- http://muffinmangames.com
-- Courtesy of Cinedelle
--

if (GetLocale() == "frFR") then
	AutoBar.locale = {
	    ["AutoBar"] = "AutoBar",
	    ["CONFIG_WINDOW"] = "Fenêtre de configuration",
	    ["SLASHCMD_LONG"] = "autobar",
	    ["SLASHCMD_SHORT"] = "atb",
	    ["Button"] = "Bouton",
		["LOAD_ERROR"] = "|cff00ff00Erreur de chargement d'AutoBarConfig. Assurez-vous qu'il soit présent et activé.|r Error: ",
		["Toggle the config panel"] = "Toggle the config panel",
		["Empty"] = "Empty",

		-- Config
		["Alpha"] = "Transparence",
		["Change the alpha of the bar."] = "Modifie la transparence de la barre.",
		["Add Button"] = "Add Button",
		["Align Buttons"] = "Alignement des boutons",
		["Always Popup"] = "Always Popup";
		["Always keep Popups open for %s"] = "Always keep Popups open for %s";
		["Always Show"] = "Toujours visible";
		["Always Show %s, even if empty."] = "Toujours voir %s, même si vide.";
		["Announce to Party"] = "Announce to Party",
		["Announce to Raid"] = "Announce to Raid",
		["Announce to Say"] = "Announce to Say",
		["Bar Location"] = "Bar Location",
		["Bar the Button is located on"] = "Bar the Button is located on",
		["Bars"] = "Barres",
		["Battlegrounds only"] = "En champs de bataille seulement",
		["Button Width"] = "Largeur du bouton",
		["Change the button width."] = "Changer la largeur des boutons",
		["Button Height"] = "Hauteur du bouton",
		["Change the button height."] = "Changer la hauteur des boutons",
		["Category"] = "Catégorie",
		["Categories"] = "Catégories",
		["Categories for %s"] = "Catégories pour %s",
		["Clamp Bars to screen"] = "Clamp Bars to screen",
		["Clamped Bars can not be positioned off screen"] = "Clamped Bars can not be positioned off screen",
		["Collapse Buttons"] = "Réduction des boutons",
		["Collapse Buttons that have nothing in them."] = "Efface les boutons qui n'ont plus aucun objet",
		["Configuration for %s"] = "Configuration pour %s",
		["Delete this Custom Button completely"] = "Delete this Custom Button completely",
		["Dialog"] = "Dialogue",
		["Disable Conjure Button"] = "Disable Conjure Button",
		["Docked to"] = "Ancrer à",
		["Done"] = "OK";
		["Drag"] = "Drag",
		["Drag to move items, spells or macros using the Cursor"] = "Drag to move items, spells or macros using the Cursor",
		["Drop"] = "Drop";
		["Drop items, spells or macros onto Button to add them to its top Custom Category"] = "Drop items, spells or macros onto Button to add them to its top Custom Category";
		["Enabled"] = "Activé",
		["Enable %s."] = "Activ %s.",
		["FadeOut"] = "Fondu",
		["Fade out the Bar when not hovering over it."] = "Effectue un fondu de la barre si elle n'est pas survolée",
		["FadeOut Time"] = "FadeOut Time",
		["FadeOut takes this amount of time."] = "FadeOut takes this amount of time",
		["FadeOut Alpha"] = "FadeOut Alpha",
		["FadeOut stops at this Alpha level."] = "FadeOut stops at this Alpha level.",
		["FadeOut Cancels in combat"] = "FadeOut Cancels in combat",
		["FadeOut is cancelled when entering combat."] = "FadeOut is cancelled when entering combat.",
		["FadeOut Cancels on Shift"] = "FadeOut Cancels on Shift",
		["FadeOut is cancelled when holding down the Shift key."] = "FadeOut is cancelled when holding down the Shift key.",
		["FadeOut Cancels on Ctrl"] = "FadeOut Cancels on Ctrl",
		["FadeOut is cancelled when holding down the Ctrl key."] = "FadeOut is cancelled when holding down the Ctrl key.",
		["FadeOut Cancels on Alt"] = "FadeOut Cancels on Alt",
		["FadeOut is cancelled when holding down the Alt key."] = "FadeOut is cancelled when holding down the Alt key.",
		["FadeOut Delay"] = "FadeOut Delay",
		["FadeOut starts after this amount of time."] = "FadeOut starts after this amount of time.",
		["Frame Level"] = "Plan d'affichage",
		["Adjust the Frame Level of the Bar and its Popup Buttons so they apear above or below other UI objects"] = "Ajuste le plan d'affichage de la barre et des boutons déployés afin qu'ils apparaissent sur ou sous les éléments de l'interface",
		["General"] = "Général",
		["Hide"] = "Cacher",
		["Hide %s"] = "Cache %s",
		["Item"] = "Objet",
		["Items"] = "Objets",
		["Location"] = "Localisation",
		["Macro Text"] = "Nom des macros",
		["Show the button Macro Text"] = "Affiche les noms des macros sur les boutons.",
		["Medium"] = "Moyen",
		["Name"] = "Nom",
		["New"] = "Nouveau",
		["New Macro"] = "New Macro",
		["No Popup"] = "Pas de déploiement";
		["No Popup for %s"] = "Pas de déploiement pour %s";
		["Number of columns for %s"] = "Nombre de colonnes pour %s",
		["Non Combat Only"] = "Hors combat seulement",
		["Not directly usable"] = "Indirectement utilisable",
		["Dropdown UI"] = "Dropdown UI",
		["Options GUI"] = "Options GUI",
		["Skin the Buttons"] = "Skin the Buttons",
		["Order"] = "Ordonner",
		["Change the order of %s in the Bar"] = "Modifie l'ordre de %s dans la barre",
		["Padding"] = "Espacement",
		["Change the padding of the bar."] = "Modifie l'espacement entre les boutons.",
		["Popup Direction"] = "Orientation du déploiement des boutons",
		["Popup on Shift Key"] = "Déploiement uniquement \navec la touche Shift(MAJ)";
		["Popup while Shift key is pressed for %s"] = "Popup while Shift key is pressed for %s";
		["Rearrange Order on Use"] = "Réorganise l'ordre \nlors d'une utilisation";
		["Rearrange Order on Use for %s"] = "Réorganise l'ordre de %s lors d'une utilisation";
		["Right Click Targets Pet"] = "Clique-droit cible le familier";
		["None"] = "Aucun";
		["Refresh"] = "Rafraîchir",
		["Refresh all the bars & buttons"] = "Rafraîchie toutes les barres et boutons",
		["Remove"] = "Remove",
		["Remove this Button from the Bar"] = "Remove this Button from the Bar",
		["Reset"] = "Réinitialisation",
		["Reset Bars"] = "Réinitialiser les barres",
		["Reset everything to default values for all characters.  Custom Bars, Buttons and Categories remain unchanged."] = "Reset everything to default values for all characters.  Custom Bars, Buttons and Categories remain unchanged.",
		["Reset the Bars to default Bar settings"] = "Réinitialise les barres à la configuartion par défaut",
		["Revert"] = "Inverser";
		["Right Click casts "] = "Right Click casts ",
		["Rows"] = "Lignes",
		["Number of rows for %s"] = "Nombre de ligne pour %s",
		["RightClick SelfCast"] = "Clique-droit pour lancer sur soi",
		["SelfCast using Right click"] = "Lancement sur soi en cliqaunt droit",
		["Key Bindings"] = KEY_BINDINGS,
		["Assign Bindings for Buttons on your Bars."] = "Assign Bindings for Buttons on your Bars.",
		["Scale"] = "Echelle",
		["Change the scale of the bar."] = "Modifie l'échelle de la barre.",
		["Shared Layout"] = "Shared Layout",
		["Share the Bar Visual Layout"] = "Share the Bar Visual Layout",
		["Shared Buttons"] = "Shared Buttons",
		["Share the Bar Button List"] = "Share the Bar Button List",
		["Shared Position"] = "Shared Position",
		["Share the Bar Position"] = "Share the Bar Position",
		["Shift Dock Left/Right"] = "Inversion de l'ancrage gauche/droite";
		["Shift Dock Up/Down"] = "Inversion de l'ancrage haut/bas";
		["Show Count Text"] = "Afficher la quantité";
		["Show Count Text for %s"] = "Afficher la quantité pour %s";
		["Show Empty Buttons"] = "Afficher les boutons vide";
		["Show Empty Buttons for %s"] = "Afficher les boutons vide pour %s";
		["Show Extended Tooltips"] = "Show Extended Tooltips";
		["Show Hotkey Text"] = "Affiche le raccourci.",
		["Show Hotkey Text for %s"] = "Affiche le raccourci du %s",
		["Show Minimap Icon"] = "Afficher Minimap Icon";
		["Show Tooltips"] = "Afficher les bulles d'aides";
		["Show Tooltips for %s"] = "Afficher les bulles d'aides pour %s";
		["Show Tooltips in Combat"] = "Show Tooltips in Combat";
		["Shuffle"] = "Shuffle",
		["Shuffle replaces depleted items during combat with the next best item"] = "Shuffle replaces depleted items during combat with the next best item",
		["Snap Bars while moving"] = "Unifie les barres en un bloc lors d'un déplacement",
		["Sticky Frames"] = "Fenêtres magnétiques",
		["Style"] = "Style",
		["Change the style of the bar.  Requires ButtonFacade for non-Blizzard styles."] = "Modifie le style de la barres.  Requires ButtonFacade for non-Blizzard styles.",
		["Targeted"] = "Ciblé",
		["<Any String>"] = "<Toutes chaînes>",
		["Move the Bars"] = "Déplacer les barres",
		["Drag a bar to move it, left click to hide (red) or show (green) the bar, right click to configure the bar."] = "Déplacer la barre pour la bouger, clique-gauche pour la cacher (rouge) ou la montrer (vert), clique-droit pour la configurer",
		["Move the Buttons"] = "Déplacer les boutons",
		["Drag a Button to move it, right click to configure the Button."] = "Déplacer le bouton pour le bouger, clique-droit pour le configurer",

		["{circle}"] = "{circle}",
		["{diamond}"] = "{diamond}",
		["{skull}"] = "{skull}",
		["{square}"] = "{square}",
		["{star}"] = "{star}",
		["{triangle}"] = "{triangle}",

		["TOPLEFT"] = "Haut gauche",
		["LEFT"] = "Gauche",
		["BOTTOMLEFT"] = "Bas gauche",
		["TOP"] = "Haut",
		["CENTER"] = "Centre",
		["BOTTOM"] = "Bas",
		["TOPRIGHT"] = "Haut droit",
		["RIGHT"] = "droit",
		["BOTTOMRIGHT"] = "Bas droit",

		-- AutoBarFuBar
		["FuBarPlugin Config"] = "Configuration du plugin FuBar",
		["Configure the FuBar Plugin"] = "Configurer le plugin FuBar",

		["\n|cffffffff%s:|r %s"] = "\n|cffffffff%s:|r %s",
		["Left-Click"] = "Left-Click",
		["Right-Click"] = "Right-Click",
		["Alt-Click"] = "Alt-Click",
		["Ctrl-Click"] = "Ctrl-Click",
		["Shift-Click"] = "Shift-Click",
		["Ctrl-Shift-Click"] = "Ctrl-Shift-Click",
		["ButtonFacade is required to Skin the Buttons"] = "ButtonFacade is required to Skin the Buttons",

		-- Bar Names
		["AutoBarClassBarBasic"] = "Basic",
		["AutoBarClassBarExtras"] = "Extras",
		["AutoBarClassBarDeathKnight"] = "Death Knight",
		["AutoBarClassBarMonk"] = "Monk",
		["AutoBarClassBarDruid"] = "Druide",
		["AutoBarClassBarHunter"] = "Chasseur",
		["AutoBarClassBarMage"] = "Mage",
		["AutoBarClassBarPaladin"] = "Paladin",
		["AutoBarClassBarPriest"] = "Prêtre",
		["AutoBarClassBarRogue"] = "Voleur",
		["AutoBarClassBarShaman"] = "Chaman",
		["AutoBarClassBarWarlock"] = "Démoniste",
		["AutoBarClassBarWarrior"] = "Guerrier",

		-- Button Names
		["Buttons"] = "Boutons",
		["AutoBarButtonHeader"] = "Nom des boutons de l'AutoBar",
		["AutoBarCooldownHeader"] = "Cooldown des potions et pierres",
		["AutoBarClassBarHeader"] = "Class bar",

		["AutoBarButtonAspect"] = "Aspect",
		["AutoBarButtonPoisonLethal"] = "Poison: Lethal",
		["AutoBarButtonPoisonNonlethal"] = "Poison: Nonlethal",
		["AutoBarButtonBandages"] = "Bandages",
		["AutoBarButtonBattleStandards"] = "Etendards de bataille",
		["AutoBarButtonBuff"] = "Buff",
		["AutoBarButtonBuffWeapon1"] = "Buff d'arme main droite",
		["AutoBarButtonCharge"] = "Charge",
		["AutoBarButtonClassBuff"] = "Buff de classe",
		["AutoBarButtonClassPet"] = "Familier de classe",
		["AutoBarButtonConjure"] = "Conjuration",
		["AutoBarButtonOpenable"] = "Openable",
		["AutoBarButtonCooldownDrums"] = "Cooldown: Drums",
		["AutoBarButtonCooldownPotionCombat"] = "Potion Cooldown: Combat",
		["AutoBarButtonCooldownPotionHealth"] = "Cooldown de potion : Vie",
		["AutoBarButtonCooldownPotionMana"] = "Cooldown de potion : Mana",
		["AutoBarButtonCooldownPotionRejuvenation"] = "Cooldown de potion : Restauration",
		["AutoBarButtonCooldownStoneHealth"] = "Cooldown de pierre : Vie",
		["AutoBarButtonCooldownStoneMana"] = "Cooldown de pierre : Mana",
		["AutoBarButtonCooldownStoneRejuvenation"] = "Cooldown de pierre : Restauration",
		["AutoBarButtonCrafting"] = "Artisanat",
		["AutoBarButtonDebuff"] = "Debuff",
		["AutoBarButtonElixirBattle"] = "Elixir de bataille",
		["AutoBarButtonElixirGuardian"] = "Elixir du Guardien",
		["AutoBarButtonElixirBoth"] = "Elixir de bataille et du Gardien",
		["AutoBarButtonER"] = "ER",
		["AutoBarButtonExplosive"] = "Explosif",
		["AutoBarButtonFishing"] = "Pêche",
		["AutoBarButtonFood"] = "Nourriture",
		["AutoBarButtonFoodBuff"] = "Nourriture apportant un Buff",
		["AutoBarButtonFoodCombo"] = "Nourriture Vie/Mana",
		["AutoBarButtonFoodPet"] = "Nourriture pour familier",
		["AutoBarButtonFreeAction"] = "Action Libre",
		["AutoBarButtonHeal"] = "Soin",
		["AutoBarButtonHearth"] = "Pierre de foyer",
		["AutoBarButtonPickLock"] = "Crochetage",
		["AutoBarButtonMount"] = "Monture",
		["AutoBarButtonPets"] = "Animaux de compagnie",
		["AutoBarButtonQuest"] = "Quête",
		["AutoBarButtonMiscFun"] = "Misc, Fun",
		["AutoBarButtonGuildSpell"] = "Guild Spells",
		["AutoBarButtonRecovery"] = "Mana / Rage / Energie",
		["AutoBarButtonRotationDrums"] = "Rotation: Drums",
		["AutoBarButtonShields"] = "Shields",
		["AutoBarButtonSpeed"] = "Vitesse",
		["AutoBarButtonStance"] = "Stance",
		["AutoBarButtonStealth"] = "Camouflage",
		["AutoBarButtonSting"] = "Piqure",
		["AutoBarButtonTotemEarth"] = "Totem de terre",
		["AutoBarButtonTotemAir"] = "Totem d'air",
		["AutoBarButtonTotemFire"] = "Totem de feu",
		["AutoBarButtonTotemWater"] = "Totem d'eau",
		["AutoBarButtonTrap"] = "Piège",
		["AutoBarButtonTrinket1"] = "Bijou 1",
		["AutoBarButtonTrinket2"] = "Bijou 2",
		["AutoBarButtonWarlockStones"] = "Warlock Stones",
		["AutoBarButtonWater"] = "Eau",
		["AutoBarButtonWaterBuff"] = "Eau apportant un Buff",

		["AutoBarButtonBear"] = "Ours",
		["AutoBarButtonBoomkinTree"] = "Arbre de vie / Sélénien",
		["AutoBarButtonCat"] = "Chat",
		["AutoBarButtonTravel"] = "Voyage",


		-- AutoBarClassButton.lua
		["Num Pad "] = "Pavé num ",
		["Mouse Button "] = "Bouton de la souri ",
		["Middle Mouse"] = KEY_BUTTON3,
		["Backspace"] = KEY_BACKSPACE,
		["Spacebar"] = KEY_SPACE,
		["Delete"] = KEY_DELETE,
		["Home"] = KEY_HOME,
		["End"] = KEY_END,
		["Insert"] = KEY_INSERT,
		["Page Up"] = KEY_PAGEUP,
		["Page Down"] = KEY_PAGEDOWN,
		["Down Arrow"] = KEY_DOWN,
		["Up Arrow"] = KEY_UP,
		["Left Arrow"] = KEY_LEFT,
		["Right Arrow"] = KEY_RIGHT,
		["|c00FF9966C|r"] = "|c00FF9966C|r",
		["|c00CCCC00S|r"] = "|c00CCCC00S|r",
		["|c009966CCA|r"] = "|c009966CCA|r",
		["|c00CCCC00S|r"] = "|c00CCCC00S|r",
		["NP"] = "PN",
		["M"] = "S",
		["MM"] = "SM",
		["Bs"] = "Bs",
		["Sp"] = "Es",
		["De"] = "De",
		["Ho"] = "Ho",
		["En"] = "En",
		["Ins"] = "Ins",
		["Pu"] = "Pu",
		["Pd"] = "Pd",
		["D"] = "B",
		["U"] = "H",
		["L"] = "G",
		["R"] = "D",

		--  AutoBarConfig.lua
		["EMPTY"] = "Vide";
		["Default"] = "Défaut",
		["Zoomed"] = "Zoomé",
		["Dreamlayout"] = "Dreamlayout",
		["AUTOBAR_CONFIG_DISABLERIGHTCLICKSELFCAST"] = "Désactive le lancement sur soi par clique-droit";
		["AUTOBAR_CONFIG_REMOVECAT"] = "Effacer la catégorie actuelle";
		["Columns"] = "Colonnes";
		["AUTOBAR_CONFIG_GAPPING"] = "Espacement des icones";
		["AUTOBAR_CONFIG_ALPHA"] = "Transparence dee icones";
		["AUTOBAR_CONFIG_WIDTHHEIGHTUNLOCKED"] = "Hauteur et Largeur \ndes boutons non proportionnelle";
		["AUTOBAR_CONFIG_SHOWCATEGORYICON"] = "Afficher les icones de catégorie";
		["AUTOBAR_CONFIG_BT3BAR"] = "BarTender3 Bar";
		["AUTOBAR_CONFIG_DOCKTOMAIN"] = "Menu principal";
		["AUTOBAR_CONFIG_DOCKTOCHATFRAME"] = "Fenêtre de chat";
		["AUTOBAR_CONFIG_DOCKTOCHATFRAMEMENU"] = "Menu des fenêtre de chat";
		["AUTOBAR_CONFIG_DOCKTOACTIONBAR"] = "Barre d'action";
		["AUTOBAR_CONFIG_DOCKTOMENUBUTTONS"] = "Menu des boutons";
		["AUTOBAR_CONFIG_NOTFOUND"] = "(Objet : non trouvé ";
		["AUTOBAR_CONFIG_SLOTEDITTEXT"] = " Set (cliquer pour éditer)";
		["AUTOBAR_CONFIG_CHARACTER"] = "Personnage :";
		["Shared"] = "Partagé";
		["Account"] = "Account";
		["Class"] = "Classe";
		["AUTOBAR_CONFIG_BASIC"] = "Base";
		["AUTOBAR_CONFIG_USECHARACTER"] = "Utiliser le set personnage";
		["AUTOBAR_CONFIG_USESHARED"] = "Utiliser le set partagé";
		["AUTOBAR_CONFIG_USECLASS"] = "Utiliser le set de classe";
		["AUTOBAR_CONFIG_USEBASIC"] = "Utiliser le set de base";
		["AUTOBAR_CONFIG_HIDECONFIGTOOLTIPS"] = "Cacher les bulles d'aide de configuration";
		["AUTOBAR_CONFIG_OSKIN"] = "Utiliser oSkin";
		["Log Events"] = "Log Events";
		["Log Memory"] = "Log Memory";
		["Log Performance"] = "Enregistrer les perfomances";
		["AUTOBAR_CONFIG_CHARACTERLAYOUT"] = "Organisation pour le personnage";
		["AUTOBAR_CONFIG_SHAREDLAYOUT"] = "Organisation partagée";
		["AUTOBAR_CONFIG_SHARED1"] = "Partage 1";
		["AUTOBAR_CONFIG_SHARED2"] = "Partage 2";
		["AUTOBAR_CONFIG_SHARED3"] = "Partage 3";
		["AUTOBAR_CONFIG_SHARED4"] = "Partage 4";
		["AUTOBAR_CONFIG_EDITCHARACTER"] = "Editer le set personnage";
		["AUTOBAR_CONFIG_EDITSHARED"] = "Editer le set partagé";
		["AUTOBAR_CONFIG_EDITCLASS"] = "Editer le set de classe";
		["AUTOBAR_CONFIG_EDITBASIC"] = "Editer le set de base";
		["Share the config"] = "Share the config";

		-- AutoBarCategory
		["Misc.Engineering.Fireworks"] = "Feu d'artifice",
		["Tradeskill.Tool.Fishing.Lure"] = "Leurres de pêche",
		["Tradeskill.Tool.Fishing.Gear"] = "Equipement de pêche",
		["Tradeskill.Tool.Fishing.Other"] = "Fishing Stuff",
		["Tradeskill.Tool.Fishing.Tool"] = "Cannes à pêche",

		["Consumable.Food.Bonus"] = "Nourriture: Tout bonus";
		["Consumable.Food.Buff.Strength"] = "Nourriture : Bonus de force";
		["Consumable.Food.Buff.Agility"] = "Nourriture : Bonus d'agilité";
		["Consumable.Food.Buff.Attack Power"] = "Nourriture : Bonus de puissance d'attaque";
		["Consumable.Food.Buff.Healing"] = "Nourriture : Bonus de soin";
		["Consumable.Food.Buff.Spell Damage"] = "Nourriture : Bonus de dégat de sorts";
		["Consumable.Food.Buff.Stamina"] = "Nourriture : Bonus d'endurance";
		["Consumable.Food.Buff.Intellect"] = "Nourriture : Bonus d'intelligence";
		["Consumable.Food.Buff.Spirit"] = "Nourriture : Bonus d'esprit";
		["Consumable.Food.Buff.Mana Regen"] = "Nourriture : Bonus de régération de mana";
		["Consumable.Food.Buff.HP Regen"] = "Nourriture : Bonus de régération de vie";
		["Consumable.Food.Buff.Other"] = "Nourriture : Autre";

		["Consumable.Buff.Health"] = "Buff : Vie";
		["Consumable.Buff.Armor"] = "Buff : Armure";
		["Consumable.Buff.Regen Health"] = "Buff : Régénration de vie";
		["Consumable.Buff.Agility"] = "Buff : Agilité";
		["Consumable.Buff.Intellect"] = "Buff : Intelligence";
		["Consumable.Buff.Protection"] = "Buff : Protection";
		["Consumable.Buff.Spirit"] = "Buff : Esprit";
		["Consumable.Buff.Stamina"] = "Buff : Endurance";
		["Consumable.Buff.Strength"] = "Buff : Force";
		["Consumable.Buff.Attack Power"] = "Buff : puissance d'attaque";
		["Consumable.Buff.Attack Speed"] = "Buff : vitesse d'attaque";
		["Consumable.Buff.Dodge"] = "Buff : Esquive";
		["Consumable.Buff.Resistance"] = "Buff : Résistance";

		["Consumable.Buff Group.General.Self"] = "Buff: Général";
		["Consumable.Buff Group.General.Target"] = "Buff: Cible générale";
		["Consumable.Buff Group.Caster.Self"] = "Buff: Lanceur";
		["Consumable.Buff Group.Caster.Target"] = "Buff: Cible du lanceur";
		["Consumable.Buff Group.Melee.Self"] = "Buff: C.A.C.";
		["Consumable.Buff Group.Melee.Target"] = "Buff: Cible du C.A.C.";
		["Consumable.Buff.Other.Self"] = "Buff : Autre";
		["Consumable.Buff.Other.Target"] = "Buff : Autre cible";
		["Consumable.Buff.Chest"] = "Buff : Torse";
		["Consumable.Buff.Shield"] = "Buff : Bouclier";
		["Consumable.Weapon Buff"] = "Buff : Arme";

		["Misc.Usable.BossItem"] = "Boss Items";
		["Misc.Usable.Fun"] = "Fun Items";
		["Misc.Usable.Permanent"] = "Objets utilisables en permanance";
		["Misc.Usable.Quest"] = "Objets de quête utilisables";
		["Misc.Usable.StartsQuest"] = "Starts Quest";
		["Misc.Usable.Replenished"] = "Objets empilables";

		["Consumable.Cooldown.Potion.Health.Anywhere"] = "Potions de soin: Anywhere";
		["Consumable.Cooldown.Potion.Health.Basic"] = "Potions de soin";
		["Consumable.Cooldown.Potion.Health.Blades Edge"] = "Potions de soin : Les Tranchantes";
		["Consumable.Cooldown.Potion.Health.Coilfang"] = "Potions de soin : Réservoir de Glissecroc";
		["Consumable.Cooldown.Potion.Health.PvP"] = "Potions de soin : Champs de bataille";
		["Consumable.Cooldown.Potion.Health.Tempest Keep"] = "Potions de soin: Donjon de la tempête";
		["Consumable.Cooldown.Potion.Mana.Anywhere"] = "Potions de mana: Anywhere";
		["Consumable.Cooldown.Potion.Mana.Basic"] = "Potions de mana";
		["Consumable.Cooldown.Potion.Mana.Blades Edge"] = "Potions de mana : Les Tranchantes";
		["Consumable.Cooldown.Potion.Mana.Coilfang"] = "Potions de mana : Réservoir de Glissecroc";
		["Consumable.Cooldown.Potion.Mana.Pvp"] = "Potions de mana : Champs de bataille";
		["Consumable.Cooldown.Potion.Mana.Tempest Keep"] = "Potions de mana : Donjon de la tempête";

		["Consumable.Weapon Buff.Poison.Crippling"] = "Poison affaiblissant";
		["Consumable.Weapon Buff.Poison.Deadly"] = "Poison mortel";
		["Consumable.Weapon Buff.Poison.Instant"] = "Poison instantané";
		["Consumable.Weapon Buff.Poison.Mind Numbing"] = "Poison de distraction mentale";
		["Consumable.Weapon Buff.Poison.Wound"] = "Poison douloureux";
		["Consumable.Weapon Buff.Oil.Mana"] = "Huile de mana";
		["Consumable.Weapon Buff.Oil.Wizard"] = "Huile de sorcier";
		["Consumable.Weapon Buff.Stone.Sharpening Stone"] = "Pierres à aiguiser";
		["Consumable.Weapon Buff.Stone.Weight Stone"] = "Contre-poids";

		["Consumable.Bandage.Basic"] = "Bandages";
			["Consumable.Bandage.Battleground.Alterac Valley"] = "Bandages d'Alterac";
		["Consumable.Bandage.Battleground.Warsong Gulch"] = "Bandages du goulet";
		["Consumable.Bandage.Battleground.Arathi Basin"] = "Bandages d'Arathi";

		["Consumable.Food.Edible.Basic.Non-Conjured"] = "Nourriture : Aucun Bonus";
		["Consumable.Food.Percent.Basic"] = "Nourriture : gain de vie en %";
		["Consumable.Food.Percent.Bonus"] = "Nourriture : Gain de vie en % (Buff : bien nourri)";
		["Consumable.Food.Edible.Combo.Non-Conjured"] = "Food: combo health & mana gain, non-conjured";
		["Consumable.Food.Edible.Combo.Conjured"] = "Food: combo health & mana gain, conjured";
		["Consumable.Food.Combo Percent"] = "Nourriture : Gain de vie et mana en %";
		["Consumable.Food.Combo Health"] = "Nourriture et eau / vie et mana";
		["Consumable.Food.Edible.Bread.Conjured"] = "Nourriture : Conjuré par les Mages";
		["Consumable.Food.Conjure"] = "Nourriture conjuré";
		["Consumable.Food.Edible.Battleground.Arathi Basin.Basic"] = "Nourriture : Bassin d'Arathi";
		["Consumable.Food.Edible.Battleground.Warsong Gulch.Basic"] = "Nourriture : Goulet des Chanteguerres";
		["Consumable.Food.Feast"] = "Nourriture : Feast";

		["Consumable.Food.Pet.Bread"] = "Nourriture : Pain pour familier";
		["Consumable.Food.Pet.Cheese"] = "Nourriture : Fromage pour familier";
		["Consumable.Food.Pet.Fish"] = "Nourriture : Poisson pour familier";
		["Consumable.Food.Pet.Fruit"] = "Nourriture : Fruit pour familier";
		["Consumable.Food.Pet.Fungus"] = "Nourriture : Champignon pour familier";
		["Consumable.Food.Pet.Meat"] = "Nourriture : Viande pour familier";

		["Consumable.Buff Pet"] = "Buff: Familier";

		["Custom"] = "Personnaliser";
		["Misc.Minipet.Normal"] = "Animaux de compagnie";
		["Misc.Minipet.Snowball"] = "Animaux de compagnie hivernal";
		["AUTOBAR_CLASS_UNGORORESTORE"] = "Cristal de restauration - Un'Goro";

		["Consumable.Anti-Venom"] = "Anti-Venin";

		["Consumable.Warlock.Soulstone"] = "Soulstone";
		["Consumable.Cooldown.Stone.Health.Warlock"] = "Pierre de soin";
		["Spell.Warlock.Create Healthstone"] = "Créer une Pierre de soin";
		["Spell.Warlock.Create Soulstone"] = "Créer une Pierre d'âme";
		["Consumable.Cooldown.Stone.Mana.Mana Stone"] = "Pierres de mana";
		["Spell.Mage.Conjure Mana Stone"] = "Conjurer une Pierre de mana";
		["Consumable.Cooldown.Stone.Rejuvenation.Dreamless Sleep"] = "Sommeil sans rêve";
		["Consumable.Cooldown.Potion.Rejuvenation"] = "Potions de régénération";
		["Consumable.Cooldown.Stone.Health.Statue"] = "Statues de pierre";
		["Consumable.Cooldown.Drums"] = "Cooldown: Drums";
		["Consumable.Cooldown.Potion"] = "Cooldown: Potion";
		["Consumable.Cooldown.Potion.Combat"] = "Cooldown: Potion - Combat";
		["Consumable.Cooldown.Stone"] = "Cooldown: Stone";
		["Consumable.Leatherworking.Drums"] = "Tambours";
		["Consumable.Tailor.Net"] = "Filets";

		["Misc.Battle Standard.Guild"] = "Guild Standard";
		["Misc.Battle Standard.Battleground"] = "Etendard de bataille";
		["Misc.Battle Standard.Alterac Valley"] = "Etendard de bataille (VA)";
		["Consumable.Cooldown.Stone.Health.Other"] = "Objet de soin : Autre";
		["Consumable.Cooldown.Stone.Mana.Other"] = "Runes démoniaques et ténébreuses";
		["AUTOBAR_CLASS_ARCANE_PROTECTION"] = "Protection : Arcane";
		["AUTOBAR_CLASS_FIRE_PROTECTION"] = "Protection : Feu";
		["AUTOBAR_CLASS_FROST_PROTECTION"] = "Protection : Givre";
		["AUTOBAR_CLASS_NATURE_PROTECTION"] = "Protection : Nature";
		["AUTOBAR_CLASS_SHADOW_PROTECTION"] = "Protection : Ombre";
		["AUTOBAR_CLASS_SPELL_REFLECTION"] = "Protection : Sorts";
		["AUTOBAR_CLASS_HOLY_PROTECTION"] = "Protection : Sacré";
		["AUTOBAR_CLASS_INVULNERABILITY_POTIONS"] = "Potions d'invulnérabilité";
		["Consumable.Buff.Free Action"] = "Buff : Libre action";

		["Misc.Lockboxes"] = LOCKED;
		["AutoBar.Trinket"] = INVTYPE_TRINKET;

		["Spell.Aspect"] = "Aspect";
		["Spell.Poison.Lethal"] = "Poison: Lethal";
		["Spell.Poison.Nonlethal"] = "Poison Nonlethal";
		["Spell.Buff.Weapon"] = "Sorts de Buff : Arme";
		["Spell.Class.Buff"] = "Class Buff";
		["Spell.Class.Pet"] = "Class Pet";
		["Spell.Crafting"] = "Artisanat";
		["Spell.Critter"] = "Pet Spells";
		["Spell.Debuff.Multiple"] = "Debuff: Multiple";
		["Spell.Debuff.Single"] = "Debuff: Single";
		["Spell.Fishing"] = "Pêche";
		["Spell.Portals"] = "Portaille et téléportation";
		["Spell.Shields"] = "Shields";
		["Spell.Sting"] = "Piqure";
		["Spell.Stance"] = "Stance";
		["Spell.Totem.Earth"] = "Totem de terre";
		["Spell.Totem.Air"] = "Totem d'air";
		["Spell.Totem.Fire"] = "Totem de feu";
		["Spell.Totem.Water"] = "Totem d'eau";
		["Spell.Seal"] = "Seal";
		["Spell.Trap"] = "Piège";
		["Misc.Booze"] = "Bibine";
		["Misc.Hearth"] = "Pierre de foyer";
		["Misc.Openable"] = "Openable";
		["Consumable.Water.Basic"] = "Eau";
		["Consumable.Water.Percentage"] = "Eau : gain de mana en %";
		["AUTOBAR_CLASS_WATER_CONJURED"] = "Eau : Conjurée par les Mages";
		["Consumable.Water.Conjure"] = "Eau conjurée";
		["Consumable.Water.Buff.Spirit"] = "Eau : Bonus d'esprit";
		["Consumable.Water.Buff"] = "Eau : Bonus";
		["Consumable.Buff.Rage"] = "Potions de Rage";
		["Consumable.Buff.Energy"] = "Potions d'énergie";
		["Consumable.Buff.Speed"] = "Potions de rapidité";
		["Consumable.Buff Type.Battle"] = "Buff: Elixirs de bataille";
		["Consumable.Buff Type.Guardian"] = "Buff: Elixirs du Guardien";
		["Consumable.Buff Type.Flask"] = "Buff: Flask";
		["AUTOBAR_CLASS_SOULSHARDS"] = "Fragment d'âmes";
		["Muffin.Explosives"] = "Explosifs";

		["Spell.Mount"] = "Mount Spells";

		["Misc.Mount.Normal"] = "Monture";
		["Misc.Mount.Summoned"] = "Monture： Invoquée";
		["Misc.Mount.Ahn'Qiraj"] = "Monture: Qiraji";
		["Misc.Mount.Flying"] = "Monture: Volante";
	}

--AUTOBAR_CHAT_MESSAGE1 = "La configuration pour ce personnage vient d'une ancienne version. Effacer. Aucune tentative de mise à jour n'a été tenté.";
--
--  AutoBar_Config.xml
--AUTOBAR_CONFIG_TAB_BAR = "Barre";
--AUTOBAR_CONFIG_TAB_POPUP = "Déploiement";
--AUTOBAR_CONFIG_TAB_PROFILE = "Profile";
--AUTOBAR_CONFIG_TAB_KEYS = "Keys";
--
--AUTOBAR_TOOLTIP1 = " (Qauntité : ";
--AUTOBAR_TOOLTIP2 = " [Objet personnalisé]";
--AUTOBAR_TOOLTIP6 = " [Utilisation limité]";
--AUTOBAR_TOOLTIP7 = " [Cooldown]";
AUTOBAR_TOOLTIP8 = "\n(Clique gauche pour application sur l'arme main droite\nClique droit pour application sur l'arme main gauche)";
--AUTOBAR_CONFIG_TIPAFFECTSCHARACTER = "Les modifications ne touchent que ce personnage.";
--AUTOBAR_CONFIG_TIPAFFECTSALL = "Les modifications touchent tous les personnages.";
--AUTOBAR_CONFIG_SETUPSINGLE = "Configuration unique";
--AUTOBAR_CONFIG_SETUPSHARED = "Configuration partagée";
--AUTOBAR_CONFIG_SETUPSTANDARD = "Configuration standard";
--AUTOBAR_CONFIG_SETUPBLANKSLATE = "Remise à blanc";
--AUTOBAR_CONFIG_SETUPSINGLETIP = "Cliquer pour obtenir une configuration de personnage unique, similaire à AutoBar classique.";
--AUTOBAR_CONFIG_SETUPSHAREDTIP = "Cliquer pour obtenir une configuration partagé.\nActive les sets partagés et spécifiques à un personnage.";
--AUTOBAR_CONFIG_SETUPSTANDARDTIP = "Active l'éditon et l'utilisation de tous les sets.";
--AUTOBAR_CONFIG_SETUPBLANKSLATETIP = "Efface l'ensemble des boutons des sets partagés et de personnages.";
--AUTOBAR_CONFIG_RESETSINGLETIP = "Cliquer pour réinitialiser la configuration de personnage unique.";
--AUTOBAR_CONFIG_RESETSHAREDTIP = "Cliquer pour réinitialiser la configuration partagé.\nLe set de classe est copié vers le set de personnage.\nLe set par défaut est copié vers le set partagé.";
--AUTOBAR_CONFIG_RESETSTANDARDTIP = "Cliquer pour réinitialiser la configuration standard.\nLes boutons de classe sont dans le set de classe.\nLes boutons par défaut sont dans le set de base.\nLes sets partagés et de personnages sont réinitialisés.";
--
--  AutoBarConfig.lua
--AUTOBAR_TOOLTIP15 = "\nCible une arme\n(Clique gauche pour l'arme main droite\nClique droit pour l'arme main gauche)";
AUTOBAR_TOOLTIP17 = "\nHors-combat seulement.";
AUTOBAR_TOOLTIP18 = "\nCombat seulement.";
--AUTOBAR_TOOLTIP21 = "Requière une restauration de PV";
--AUTOBAR_TOOLTIP22 = "Requière une restauration de mana";

end

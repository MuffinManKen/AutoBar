All releases will be done on Curse.com and WoWInterface.com so grab it from wherever you prefer.

Main support site:
https://muffinmangames.com


*For Cooldown counts please use Omni Cooldown Count
*For skinning install the Masque addon

Changes:
v8.2.0.00:
 - Updated libraries
 - Data updates

v8.1.5.01:
 - More data updates

v8.1.5.00:
 - Updated data for Patch 8.1.5

v8.1.0.00:
 - Updated for Patch 8.1

v8.0.0.06:
 - Data updates
 - AutoBar's cooldown colour should match Blizzard's again
 - Added new category with a button to summon a favourite random mount
 - Added Mole Machine to portals (untested, I don't have access to it yet)

v8.0.0.05:
 - Data updates
 - Removed ancient DewDropLib. You can no longer right-click on the minimap button to get a popup menu. Leave me a comment if you used this feature and I`ll find an alternate way to implement it
 - Improved interactions between multiple What's New dialogs

v8.0.0.04:
 - Added new Mage portals
 - Added option to reverse the sorting order of mounts

v8.0.0.03:
 - Updated data libs
 - Fixed an issue where usable items weren't showing up on the bar (Blizzard lies!)

v8.0.0.02:
 - Fixed an error when opening the config window

v8.0.0.01:
 - Updated embedded libs
 - Small optimization in bag scanning
 - Scanner runs more often, but does less work each time to address "script ran too long errors"

v8.0.0.00:
 - Update for Battle for Azeroth

v7.9.9.03: BETA
 - Improved handling of macro icons
 - Hopefully fixed more stuff

v7.9.9.02: BETA
 - BETA: This is Beta code, if that makes you nervous don't use it
 - Fixed AutoBar issue with Mounts

v7.9.9.01: BETA
 - BETA: This is Beta code, if that makes you nervous don't use it
 - Fixed AutoBar issue when entering combat

v7.9.9.00: BETA
 - BETA: This is Beta code, if that makes you nervous don't use it
 - Ugly, ugly hacks to work around some issues
 - Mostly removed AceEvent-2

v7.3.5.03:
 - Workarounds for Blizzards latest rounds of quietly breaking things
 - Some small performance improvements

v7.3.5.02:
 - Updated libraries
 - Tries to be smarter about what items really are usable

v7.3.5.01:
 - Updated libraries
 - Removed a debug print statement
 - Simplified Druid shapeshift buttons
 - Toys should appear more reliably. (I hope!)
 - Added "Hack PetActionBarFrame" to fix an issue where Blizzard frame extends too far and blocks access to other things.  If you put anything too close to the Pet Action Bar, you can't click it.
 - You can no longer add duplicate items to an AutoBar Category
 - You can no longer add Toys to an AutoBar Category

v7.3.5.00:
 - Updated data libraries
 - Work-around for new Blizzard performance bug

v7.3.0.06:
 - Updated data libraries
 - Improved handling of Hearth toys
 - What's new dialog is movable, Okay button is bigger, and it gained a mascot.

v7.3.0.05:
 - Updated data libraries

v7.3.0.04:
 - Updated data libraries

v7.3.0.03:
 - Updated data libraries
 - Nethershard-yielding items appear on Order Hall Resource button
 - UI Fix: Button options (Show Favourites, etc) are visible even when a button is not enabled
 - UI Fix: When changing button options, the buttons should update immediately
 - Mount button should be better at showing proper mounts accounting for faction/professions/etc

v7.3.0.02beta:
 - Nethershard-yielding items appear on Order Hall Resource button
 - UI Fix: Button options (Show Favourites, etc) are visible even when a button is not enabled
 - UI Fix: When changing button options, the buttons should update immediately
 - Mount button should be better at showing proper mounts accounting for faction/professions/etc

v7.3.0.01:
 - Updated data libraries
 - Mounts button should remember last used mount
 - Added better handling of Class mounts for Warlocks (TODO: Other classes)

v7.3.0.00:
 - Updated data libraries
 - Fixed harmless warnings in the FrameXML.log
 - Remove references to the long-removed Offhand Buff button
 - Item # of uses can go over 99 without being replaced by *
 - Removed more unused locale entries

v7.2.0.02:
 - Updated data libraries
 - Added Archaeology button

v7.2.0.01:
 - Unblocked Falcosaur mounts since Blizzard silently unbroke them
 - Performance improvements
 - Updated data libraries
 - Added  Earthbind Totem to Earth Totem Category

v7.2.0.00:
 - TOC bump for patch 7.2
 - Updated data libraries
 - Removed all references to Combat Stones, including the Category and Button
 - Localization cleanup; removed things that no longer exist

v7.1.5.04:
 - Updated data libraries

v7.1.5.03:
 - Updated data libraries
 - Removed Powershift button

v7.1.5.02:
 - Fix for Druids and the Powershift macro

v7.1.5.01:
 - Updated Data libraries
 - Fix so #show only controls the icon, not the tooltip of custom macros
 
v7.1.5.00:
 - Updated Data libraries

v7.1.0.09:
 - Improved performance when in a party/raid or when you have a pet
 - AutoBar will try to detect when Quest items are acquired and add them to the Quest button
 - Left-clicking the minimap/LDB button will toggle the AutoBar config dialog rather than just opening it
 - Right-clicking on a button while in Move Buttons mode no longer tries to open a dropdown menu. It didn't work anyway.
 - Making progress on removing old unsupported 3rd party libraries (Ace2,etc)
 - Added Raid Target Button
 - Added/Removed abilities for Patch 7.1.5

v7.1.0.08:
 - Toys now show cooldowns
 - Added Favourite Battle Pets to the Pet button
 - Toy Box button should update immediately when you change your Favourites
 - Updated Data Libs
 - Happy Winter Veil!

v7.1.0.07:
 - Blocked the Falcosaur mounts from appearing on the Mount button until Blizzard fixes them.
 - Added Order Hall Resources Category
 - Made Toy handling a little more efficient

v7.1.0.06:
 - Hunter's Call Pet tooltip now shows the pet name instead of a number
 - Updated Data Libs
 - Added to Pet button: Summon Random Pet, Summon Random Favourite Pet, Dismiss Pet
 
v7.1.0.05:
 - The Mount button was only showing Class mounts

v7.1.0.04:
 - Simplified the handling of some spells (notably Zen Pilgrimage)
 - Changed New to New Button in the Buttons UI and added a better tooltip
 - Updated Muffin LibPT and LibPeriodicTable
 
 v7.1.0.03:
 - What's New dialog popped up on every log in

v7.1.0.02:
 - Added Show Favourites option to Toy Box button
 - Updated Muffin LibPT
 - Pet Battle button has Safari Hat and Revive Battle Pets
 - Pet Battle button has ornamental toys (leashes, etc). Optional.
 - Added more Toy-based Portals
 - Added some Fishing Toys

v7.1.0.01:
 - Fixed an issue on the Trinket button if you had extra trinkets in your bag

v7.1.0.00:
 - Fixed breakage caused by patch 7.1
 - Removed LibKeyBoundExtra since it's not needed
 - Updated LibKeyBound
 - Updated Muffin LibPT
 - Monks are now considered Mana users
 - Added Toy Box button on Extras bar. This is very basic, more is coming.
 - Optimized some stuff

v7.0.3.09:
 - Improved handling of WoW not having items cached
 - Removed global bar alpha setting since bar-level setting always took precendence
 - Lots of code cleanup
 - Improved UI docs (Category Reset)
 - Updated MuffinLibPT and LibPeriodicTable
 - Split Order Hall button into 2: Troops & Resources
 - Added Ancient Mana items to Order Hall Resources
 - Added Reputation button
 - Order Hall categories are more fine-grained for people who want more control over custom buttons

v7.0.3.08:
 - Updated MuffinLibPT and LibPeriodicTable
 - Added Bulging Barrel of Oil and Huge Ogre Cache to Garrison items
 - Removed "Sticky Frames" option since it didn't work
 - ShowExtendedTooltips was never implemented. Removed.
 - Mount button wasn't showing anything if you logged in while in an inn. Removed Blizzard filtering for professions, added my own.
 - Added more fishing stuff
 - Removed Collapse Buttons option

v7.0.3.07:
 - AutoBar should no longer forget your chosen mount
 - Mount buttons are now sorted (with the exception of your current choice and the first one)
 - Added Muffin.Garrison.Gearworks
 - Added Muffin.Order Hall.Troop Recruit
 - Added Muffin.Elixir categories
 - Updated MuffinLibPT
 - Not all built-in Categories were available to custom buttons, but now are.

v7.0.3.06:
 - Added Pet Bandages to the Battle Pet Items button
 - Added more Dalaran Lures
 - Reviewed Priest Class Bar
 - Profession-specific mounts shouldn't show up for people without that profession
 - Added Big Fountain Goldfish to Food
 - Added Pet Treats to Battle Pet Items button
 - Added Order Hall button. Right now it just has "Gain Artifact Power" items.

v7.0.3.05:
 - Updated MuffinLibPT
 - Added new Dalaran Lures to Fishing button
 - Hunter: Added Fetch/Play Dead/Wake Up
 - Ports: Dreamway, Broken Dalaran, Hall of the Guardian

v7.0.3.04:
 - Reviewed Class Bars: Death Knight, Demon Hunter
 - ER button is a normal spell button, rather than a macro

v7.0.3.03:
 - Moved Advanced/Debug settings to the bottom of the dialog
 - Fixed "SecureCmdOptionParse" bug

v7.0.3.02:
 - If you change your talents/spec, spells you no longer know won't stay on your bar
 - No longer processes COMPANION_UPDATE messages since they fire constantly when in a city
 - Removed the "New" button on custom categories since that way to add an item never worked
 - Tooltips are now shown for custom macro buttons
 - Updated MuffinLibPT

v7.0.3.01:
 - Macro Buttons now show an icon if the item/spell/etc has an odd character in it (affected MOLL-E, Blingtron, and others)
 - Added Dalaran Hearthstone and Flight Master's Whistle to Hearth
 - If you login while in combat, AutoBar will reload itself when combat completes
 - Updated MuffinLibPT
 - Making changes to button options (Mounts: Show Favourites, etc) should refresh the button immediately

v7.0.3.00:
 - Removed the Coilfang/Tempest Keep/Blade's Edge-specific categories and code.
 - Performance improvements
 - Added a per-button Max Popup Height gui control
 - Commented out PopUpOnShift references since it doesn't work
 - Updated MuffinLibPT
 - Added Battle Pet Items button to Extras bar
 - Added Interrupt button to Class Bar
 - Reviewed Class Bars: Rogue, Paladin, Hunter, Warlock
 - Monk: Zen Pilgrimage:Return is now on your Hearth. The tooltip may be wrong, but it will work.
 - The "Charge" button is now a normal button instead of a macro button. Simpler, better.
 - "Muffin.Potion.Health" category now shows up in the list
 - Demon Hunter Support
 - Added Keybinds for Garrison and Sun Song Ranch
 - Fixed Mounts for Legion
 - Qiraji Mounts are now filtered out by default
 - Mounts load much quicker now
 - Fixed Item buttons for Legion
 - TOC bump for 7.0
 - Updated Ace3-GUI
 - Bars should no longer flash while in a vehicle
 - Custom Macro buttons should now have a meaningful icon

v6.2.0.04:
 - Added keybinds for Garrisons and Sunsong Ranch

v6.2.0.03:
 - Data updates
 - Reorganized some settings on the UI
 - Added new SPELLS_CHANGED setting. If you have constant hitching every few seconds, try disabling this.

v6.2.0.02
 - Data updates
 - Bars should no longer flash in pet battles

v6.2.0.01
 - Added new "Show Class" option for Mounts to workaround yet another Blizzard bug
 - AutoBar should no longer complain about Muffin.Explosives. Really, really.
 - Minor data updates

v6.2.0.00
 - Updated libs
 - TOC bump for Patch 6.2

v6.1.0.01
 - What's New dialog kept popping

v6.1.0.00
 - Updated libs
 - TOC bump for Patch 6.1

v6.0.2.18
 - Updated the What's New dialog with the stuff from 6.0.2.17. Oops.

v6.0.2.17
 - Streamlined bag update handling; it should be faster but still accurate
 - AutoBar will no longer show items you're too low level to use
 - Monk: Fortifying Brew added to Shield button
 - Monk: Storm, Earth, and Fire added to Class Pet
 - Monk: ER button removed (was empty anyway)
 - Druid: Potion Cooldown Mana and Mana buttons will now show Rage potions
 - Rage Potions: Added Pure Rage Potion
 - Garrison: Added Weapon and Armor Enhancement Tokens

v6.0.2.16
 - Hearth: Added Wormhole Centrifuge
 - Fun: Added Walter, Blingtron 5000, Deepdive Helmet
 - Mage: Removed Frost Armor from Buffs; it's Passive
 - Mage: Conjure Refreshment Table is the right-click on Conjure Refreshment
 - Stealth: Button is now a standard spell button with tooltips
 - Hunter: Added Camouflage to Stealth button
 - Monk: Added Zen Pilgrimage to Hearth
 - New, hopefully better, What's New dialog

v6.0.2.15
 - Updated the What's New dialog with the stuff from 6.0.2.14. Oops.

v6.0.2.14
 - More throttling of crazy Blizzard events
 - Mage: Added Ancient Dalaran Portal. Disabled by default.
 - Mage: Removed Mage Armor from buffs; it's a Passive now.
 - Mage: Conjure Food button is disabled on Food and Water buttons by default
 - Food: Button can optionally include Combo Food (Health & Mana)
 - Added a first cut at mining buff potions
 - Hearth: Added Relic of Karabor

v6.0.2.13
 - Added code to throttle out of control Blizzard events
 - Added code to stop bars from popping in briefly while pet battling

v6.0.2.12
 - Milling button was showing "Custom" as its name
 - Garrison button now has data
 - Weird "Food" and "Buttons" addons are no longer added to the Interface->Addons panel
 - Milling (left-click) works again on the Milling button
 - Updated Flasks

v6.0.2.11
 - Milling Button added on Extras bar. Left-click to Mill, Right-Click to use Draenic Mortar
 - Removed Ammo categories since ammo no longer exists
 - Added Oralius' Whispering Crystal to Flasks button
 - Added Garrison button to Extras Bar: Miner's Coffee, Preserved Pick, Salvage, and Iron Traps.

v6.0.2.10
 - Lots of code clean up
 - Added bait to the fishing button
 - Added Worm Supreme and Ephemeral Fishing Pole to fishing button
 - Added Beast Lore to button for Hunters
 - Removed Rotation:Drums
 - In Options window the second "FadeOut" header label now says "General"
 - Fixed bug where newly empty buttons would cover populated ones
 - Mount buttons options: Show Favourites, Show Non-Favourites
 - What's New dialog


v6.0.2.09
 - Added support for button skinning via Masque. ButtonFacade support has been removed.
 - Options to open skinning config from Autobar has been removed; use options provided by Masque directly
 - Mounts button works, but isn't perfect. Some things show that shouldn't.
 - Keybinds menu is cleaned up a bit
 - Added Ashran ports for Mages
 - Added Instant Poison for Combat Rogues, it's an ugly hack to work around a WoW bug
 
 
v6.0.2.08
 - Combo Buff food was missing. It is now on the Combo Food button.

v6.02.07
 - Hunter: Removed Aspect of the Iron Hawk
 - Hunter: Added Aspect of the Fox
 - Removed Mage's Incanter's Flow; it's a Passive but used the same ID as Incanter's Ward which was an Active spell
 - Added Food, Bandage, Potions (Mana, Heal, Rejuv)

v6.0.2.06
 - Updated MuffinLibPTSets
 - Actually *use* the updated food categories

v6.0.2.05:
 - Updates to LibPeriodicTable & MuffinLibPTSets

v6.0.2.04:
 - Grabbed latest version of LibPeriodicTable

v6.0.2.03:
 - Grabbed latest version of MuffinLibPTSets

v6.0.2.02:
 - Removed reference to AceDB-3.0 since it was not used but was referenced.

v6.0.2.01:
 - Fixed bug with Pet button. Still doesn't work, but doesn't throw an error anymore

v6.0.2.00:
 - Updated for Warlords of Draenor pre-patch

v5.4.8.01:
(LibPT)Updated Consumable.Food.Feast
 - Added Bountiful Feast
 - Noodle Carts
 - level for sorting

v5.4.7.5:
 - Embeds MuffinLibPTSets directly since I can't get it to work as I'd like

v5.4.7.4:
 - Openable, Trinket, and Sun Song Ranch buttons should be fixed again
 - Conjure Food is no longer added to the Openable button if you're a rogue (??)

v5.4.7.3:
 - Packaging MuffinLibPTSets

v5.4.7.2:
 - Refresh LibPeriodicTable:
	 - Added Drums of Rage to the Drum Cooldown set
	 - Added Lorewalker's Lodestone, Time-Lost Artifact, Kirin Tor Beacon, and Sunreaver Beacon to Misc.Hearth
	 - Added Volatile Seaforium Blastpack to Misc.Unlock.Seaforium Charges
	 - Added various pet supply bags to Misc.Openable
 - Uses MuffinLibPTSets

v5.4.7.0:
 - Fixed issues with AutoBar disappearing and requiring a /reload

v5.4.1.0:
 - Fixed breakage caused by latest WoW patch

v5.4.0.0:
 - Refresh LibPeriodicTable
 - Improved (hopefully) handling of pet battles/vehicles
 - TOC bump

v5.2.0.0:
 - Refreshed item lists
 - TOC bump
 - Fixed Hunter Aspect button
 - AutoBar will hide when in a vehicle
 - Added code to help find future breakage

v5.1.0.1:
 - A bunch of Openables added to LibPT
 - Flasks should now be up to date

v5.1.0.0:
 - Interface bump
 - Lots of stuff added.
 
v5.0.4.11:
	- Added:
		Brilliant Mana Gem
		Quest: Brazier Torch, Softknuckle Poker, UDED, Transporter Power Cell, Prophetic Ink, Tahret Dynasty Mallet
		Openable: Sack o' Tokens, Pouch o' Tokens
		Fun: Blingotron
		Fishing: Ancient Pandaren Fishing Charm
		Hearth: Wormhole Generator: Pandaria
		Potion: Potion of the Jade Serpent, Potion of the Mountains, Virmen's Bite, Potion of Mogu Power

v5.0.4.10:
 - Hide bars during pet battles
 - For Warlocks, Soul Link is a buff not a shield
 - Added:
		Openable: Hero's Purse
		Fishing Tool:Dragon Fishing Pole
		Quest Items: Orange Painted Turnip, Li Li's Wishing Star, Mudmug's Vial, Zul'Drak Rat

v5.0.4.09:
 - Removed Darkmoon Adventurer's Guide from Misc.Usable.Quest since it is in fact not usable (LibPeriodicTable)
 - Funnel Cakes (from darkmoon faire) show up as food, even though WoW has them misclassified
 - Healing and Mana potions
 - Sunsong Farming button on the Extras bar
 - Removed the Track button, since it hasn't done anything in a long time
 
v5.0.4.08:
 - More foods and drinks added. I'm experimenting with getting data in a way that no longer relies on LibPT.

v5.0.4.07:
 - Massive updates to/of LibPeriodicTable. A lot of missing items should now be there.

v5.0.4.06:
 - Basic MoP Food added to LibPeriodicTable
 

v5.0.4.05:
 - Shaman: Mana Tide Totem is available now
 - Hunter class bar updates
 - Warrior updates
 - Paladin updates.
 - Hunter/Paladin Aura/Aspect button is replaced with Hunter-only Aspect button
 - Added new Poison buttons on the Rogue bar
 - Priests: Removed Vampiric Embrace, added Desperate Prayer to ER
 - DeathKnights have pets
 - Fishing on the Extras bar works again
 - Basic Monk support

v5.0.4.04:
 - Try to nicely deprecate removed button classes
 
v5.0.4.03:
 - Possible fix for Shaman Water Totems not showing (I can't test it)
 - Updated trinket list with a new experimental process (hopefully it works)
 - Updated LibPeriodicTable
 - Removed LibBabbleZone-3.0 and AceDebug-2.0
 - Removed handling of Burning Crusade instance-only items
 - Removed popup dialogs when right-clicking on bars
 - You should delete the original AutoBar folder before upgrading since some files were removed
 
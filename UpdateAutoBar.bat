xcopy "D:\Projects\Current\WoW\MuffinLibPTSets\classic" ".\classic\MuffinLibPTSets" /Y /S /I /EXCLUDE:xcopy_ignore.txt
xcopy "D:\Projects\Current\WoW\MuffinLibPTSets\retail" ".\retail\MuffinLibPTSets" /Y /S /I /EXCLUDE:xcopy_ignore.txt

xcopy "D:\Projects\Current\WoW\LibPeriodicTable\LibPeriodicTable-3.1-Consumable" ".\libs\LibPeriodicTable-3.1-Consumable" /Y /S /I
xcopy "D:\Projects\Current\WoW\LibPeriodicTable\LibPeriodicTable-3.1-Misc" ".\libs\LibPeriodicTable-3.1-Misc" /Y /S /I
xcopy "D:\Projects\Current\WoW\LibPeriodicTable\LibPeriodicTable-3.1-Tradeskill" ".\libs\LibPeriodicTable-3.1-Tradeskill" /Y /S /I

xcopy "D:\Projects\Current\WoW\libs\ace3\AceConfig-3.0" ".\libs\AceConfig-3.0"  /Y /S /I
xcopy "D:\Projects\Current\WoW\libs\ace3\AceConsole-3.0" ".\libs\AceConsole-3.0"  /Y /S /I
xcopy "D:\Projects\Current\WoW\libs\ ace3\AceGUI-3.0" ".\libs\AceGUI-3.0"  /Y /S /I

copy "D:\Projects\Current\WoW\MuffinUIToolkit\muffin_ui_toolkit.lua" ".\libs\"
copy "D:\Projects\Current\WoW\MuffinWhatsNew\muffin_whats_new.lua" ".\libs\"

copy "D:\Projects\Current\WoW\MuffinIcons\*.tga" ".\textures\"


xcopy "D:\Projects\Current\WoW\libs\libkeybound-1-0\LibKeyBound-1.0" ".\libs\LibKeyBound-1.0" /Y /S /I

pause

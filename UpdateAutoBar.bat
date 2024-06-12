xcopy "..\MuffinLibPTSets\classic" ".\classic\MuffinLibPTSets" /Y /S /I /EXCLUDE:xcopy_ignore.txt
xcopy "..\MuffinLibPTSets\bcc" ".\bcc\MuffinLibPTSets" /Y /S /I /EXCLUDE:xcopy_ignore.txt
xcopy "..\MuffinLibPTSets\cata" ".\cata\MuffinLibPTSets" /Y /S /I /EXCLUDE:xcopy_ignore.txt
xcopy "..\MuffinLibPTSets\retail" ".\retail\MuffinLibPTSets" /Y /S /I /EXCLUDE:xcopy_ignore.txt

copy "..\LibPeriodicTable\LibPeriodicTable-3.1\LibPeriodicTable-3.1.lua" ".\libs\LibPeriodicTable-3.1\LibPeriodicTable-3.1.lua"
xcopy "..\LibPeriodicTable\LibPeriodicTable-3.1-Consumable" ".\libs\LibPeriodicTable-3.1-Consumable" /Y /S /I
xcopy "..\LibPeriodicTable\LibPeriodicTable-3.1-Misc" ".\libs\LibPeriodicTable-3.1-Misc" /Y /S /I
xcopy "..\LibPeriodicTable\LibPeriodicTable-3.1-Tradeskill" ".\libs\LibPeriodicTable-3.1-Tradeskill" /Y /S /I

xcopy "..\libs\ace3\AceConfig-3.0" ".\libs\AceConfig-3.0"  /Y /S /I
xcopy "..\libs\ace3\AceConsole-3.0" ".\libs\AceConsole-3.0"  /Y /S /I
xcopy "..\libs\ace3\AceGUI-3.0" ".\libs\AceGUI-3.0"  /Y /S /I

copy "..\MuffinUIToolkit\muffin_ui_toolkit.lua" ".\libs\"
copy "..\MuffinWhatsNew\muffin_whats_new.lua" ".\libs\"

copy "..\MuffinIcons\muffin.tga" ".\textures\"


REM xcopy "..\libs\libkeybound-1-0\LibKeyBound-1.0" ".\libs\LibKeyBound-1.0" /Y /S /I

pause

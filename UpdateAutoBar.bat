xcopy "D:\Projects\Current\WoW\MuffinLibPTSets\classic" "D:\Projects\Current\WoW\AutoBar\libs\MuffinLibPTSets" /Y /S /I /EXCLUDE:xcopy_ignore.txt

xcopy "D:\Projects\Current\WoW\LibPeriodicTable\LibPeriodicTable-3.1-Consumable" "D:\Projects\Current\WoW\AutoBar\libs\LibPeriodicTable-3.1-Consumable" /Y /S /I
xcopy "D:\Projects\Current\WoW\LibPeriodicTable\LibPeriodicTable-3.1-Misc" "D:\Projects\Current\WoW\AutoBar\libs\LibPeriodicTable-3.1-Misc" /Y /S /I
xcopy "D:\Projects\Current\WoW\LibPeriodicTable\LibPeriodicTable-3.1-Tradeskill" "D:\Projects\Current\WoW\AutoBar\libs\LibPeriodicTable-3.1-Tradeskill" /Y /S /I

xcopy "D:\Projects\Current\WoW\ace3\AceConfig-3.0" "D:\Projects\Current\WoW\AutoBar\libs\AceConfig-3.0"  /Y /S /I
xcopy "D:\Projects\Current\WoW\ace3\AceConsole-3.0" "D:\Projects\Current\WoW\AutoBar\libs\AceConsole-3.0"  /Y /S /I
xcopy "D:\Projects\Current\WoW\ace3\AceGUI-3.0" "D:\Projects\Current\WoW\AutoBar\libs\AceGUI-3.0"  /Y /S /I
xcopy "D:\Projects\Current\WoW\ace3\AceDBOptions-3.0" "D:\Projects\Current\WoW\AutoBar\libs\AceDBOptions-3.0"  /Y /S /I

xcopy "D:\Projects\Current\WoW\libkeybound-1-0\LibKeyBound-1.0" "D:\Projects\Current\WoW\AutoBar\libs\LibKeyBound-1.0"  /Y /S /I
copy "D:\Projects\Current\WoW\libstub\*.lua" "D:\Projects\Current\WoW\AutoBar\libs\LibStub\"
copy "D:\Projects\Current\WoW\CallbackHandler\CallbackHandler-1.0\*.lua" "D:\Projects\Current\WoW\AutoBar\libs\CallbackHandler-1.0\"
copy "D:\Projects\Current\WoW\libdatabroker-1-1\*.lua" "D:\Projects\Current\WoW\AutoBar\libs\LibDataBroker-1.1\"
copy "D:\Projects\Current\WoW\libdbicon-1-0\LibDBIcon-1.0\*.lua" "D:\Projects\Current\WoW\AutoBar\libs\LibDBIcon-1.0\"


pause

xcopy "D:\Projects\WoW\MuffinLibPTSets\classic" "D:\Projects\WoW\AutoBar\libs\MuffinLibPTSets" /Y /S /I /EXCLUDE:xcopy_ignore.txt

xcopy "D:\Projects\WoW\LibPeriodicTable\LibPeriodicTable-3.1-Consumable" "D:\Projects\WoW\AutoBar\libs\LibPeriodicTable-3.1-Consumable" /Y /S /I
xcopy "D:\Projects\WoW\LibPeriodicTable\LibPeriodicTable-3.1-Misc" "D:\Projects\WoW\AutoBar\libs\LibPeriodicTable-3.1-Misc" /Y /S /I
xcopy "D:\Projects\WoW\LibPeriodicTable\LibPeriodicTable-3.1-Tradeskill" "D:\Projects\WoW\AutoBar\libs\LibPeriodicTable-3.1-Tradeskill" /Y /S /I

xcopy "D:\Projects\WoW\ace3\AceConfig-3.0" "D:\Projects\WoW\AutoBar\libs\AceConfig-3.0"  /Y /S /I
xcopy "D:\Projects\WoW\ace3\AceConsole-3.0" "D:\Projects\WoW\AutoBar\libs\AceConsole-3.0"  /Y /S /I
xcopy "D:\Projects\WoW\ace3\AceGUI-3.0" "D:\Projects\WoW\AutoBar\libs\AceGUI-3.0"  /Y /S /I
xcopy "D:\Projects\WoW\ace3\AceDBOptions-3.0" "D:\Projects\WoW\AutoBar\libs\AceDBOptions-3.0"  /Y /S /I

xcopy "D:\Projects\WoW\libkeybound-1-0\LibKeyBound-1.0" "D:\Projects\WoW\AutoBar\libs\LibKeyBound-1.0"  /Y /S /I
copy "D:\Projects\WoW\libstub\*.lua" "D:\Projects\WoW\AutoBar\libs\LibStub\"
copy "D:\Projects\WoW\CallbackHandler\CallbackHandler-1.0\*.lua" "D:\Projects\WoW\AutoBar\libs\CallbackHandler-1.0\"
copy "D:\Projects\WoW\libdatabroker-1-1\*.lua" "D:\Projects\WoW\AutoBar\libs\LibDataBroker-1.1\"
copy "D:\Projects\WoW\libdbicon-1-0\LibDBIcon-1.0\*.lua" "D:\Projects\WoW\AutoBar\libs\LibDBIcon-1.0\"


pause

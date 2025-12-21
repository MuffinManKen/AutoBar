
set SRC="."
set DST="%WOW_INSTALL_DIR%\_retail_\Interface\Addons\AutoBar"

robocopy %SRC% %DST%  /E ^
  /XF ^
    *.bat ^
    .gitignore .luacheckrc ^
    autobar.code-workspace ^
    AutoBar*.toc ^
    *.py ^
    *.txt ^
	 *.json ^
	 wow_defs.lua ^
	 *_*.tga ^
  /XD ^
    .github ^
    .git ^
    .vscode ^
    bcc ^
	 cata ^
	 classic^
	 docs ^
	 mop ^
	 tools

robocopy %SRC% %DST% AutoBar.toc
pause
exit

robocopy ".\libs" "%WOW_INSTALL_DIR%\_retail_\Interface\Addons\AutoBar\libs" /MIR /E 
robocopy ".\locale" "%WOW_INSTALL_DIR%\_retail_\Interface\Addons\AutoBar\locale" /MIR /E 
robocopy ".\retail" "%WOW_INSTALL_DIR%\_retail_\Interface\Addons\AutoBar\retail" /MIR /E 
robocopy ".\retail" "%WOW_INSTALL_DIR%\_retail_\Interface\Addons\AutoBar\retail" /MIR /E 
robocopy ".\textures" "%WOW_INSTALL_DIR%\_retail_\Interface\Addons\AutoBar\textures" /MIR /E /XF *_*
robocopy "." "%WOW_INSTALL_DIR%\_retail_\Interface\Addons\AutoBar" /MIR /LEV:1 /XF .gitignore .luacheckrc autobar.code-workspace AutoBarBCC.toc AutoBarClassic* *.bat *.py *.txt *.json wow_defs.lua


pause

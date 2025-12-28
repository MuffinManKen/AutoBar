
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


robocopy ".\libs" "%DST%\libs" /MIR /E
robocopy ".\locale" "%DST%\locale" /MIR /E
robocopy ".\retail" "%DST%\retail" /MIR /E
robocopy ".\retail" "%DST%\retail" /MIR /E
robocopy ".\textures" "%DST%\textures" /MIR /E /XF *_*
robocopy "." "%DST%" /MIR /LEV:1 /XF .gitignore .luacheckrc autobar.code-workspace AutoBarBCC.toc AutoBarClassic* *.bat *.py *.txt *.json wow_defs.lua


pause

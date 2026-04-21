
set SRC="."
set DST="%WOW_INSTALL_DIR%\_beta_\Interface\Addons\AutoBar"

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

set DST="%WOW_INSTALL_DIR%\_xptr_\Interface\Addons\AutoBar"

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

set DST="%WOW_INSTALL_DIR%\_ptr_\Interface\Addons\AutoBar"

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



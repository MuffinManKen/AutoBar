rmdir /s /q "%WOW_INSTALL_DIR%\_classic_era_\Interface\Addons\AutoBarClassic"
rmdir /s /q "%WOW_INSTALL_DIR%\_classic_\Interface\Addons\AutoBarClassic"
rmdir /s /q "%WOW_INSTALL_DIR%\_classic_era_ptr_\Interface\Addons\AutoBarClassic"
rmdir /s /q "%WOW_INSTALL_DIR%\_classic_ptr_\Interface\Addons\AutoBarClassic"
rmdir /s /q "%WOW_INSTALL_DIR%\_anniversary_\Interface\Addons\AutoBarClassic"


xcopy "." "%WOW_INSTALL_DIR%\_classic_era_\Interface\Addons\AutoBarClassic" /Y /S /I /EXCLUDE:xcopy_ignore_classic.txt+xcopy_ignore.txt
xcopy "." "%WOW_INSTALL_DIR%\_classic_\Interface\Addons\AutoBarClassic" /Y /S /I /EXCLUDE:xcopy_ignore_classic.txt+xcopy_ignore.txt
xcopy "." "%WOW_INSTALL_DIR%\_anniversary_\Interface\Addons\AutoBarClassic" /Y /S /I /EXCLUDE:xcopy_ignore_classic.txt+xcopy_ignore.txt

xcopy "." "%WOW_INSTALL_DIR%\_classic_era_ptr_\Interface\Addons\AutoBarClassic" /Y /S /I /EXCLUDE:xcopy_ignore_classic.txt+xcopy_ignore.txt
xcopy "." "%WOW_INSTALL_DIR%\_classic_ptr_\Interface\Addons\AutoBarClassic" /Y /S /I /EXCLUDE:xcopy_ignore_classic.txt+xcopy_ignore.txt

pause

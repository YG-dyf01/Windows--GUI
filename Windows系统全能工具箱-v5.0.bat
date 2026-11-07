@echo off
rem ==================================================================
rem  Windows 系统全能工具箱  v5.0      作者：Whisper-LiuBaiPeng
rem  由「系统维护工具箱 v1.0」与「系统优化增强包 v1.0」合并而成
rem  原有两个 .bat 保持独立，本文件为合并版，功能最全（33 项）
rem  用法：双击自动提权；所有可逆设置可在 [6] 恢复与日志 中还原
rem ==================================================================
chcp 936 <nul >nul 2>&1
setlocal EnableExtensions DisableDelayedExpansion
title Windows 系统全能工具箱 v5.0
mode con cols=100 lines=50 <nul >nul 2>&1
color 0F

set "DATA_DIR=%ProgramData%\WinToolbox"
set "LOG_FILE=%DATA_DIR%\all.log"
set "PS=powershell -NoProfile -ExecutionPolicy Bypass -Command"
if not exist "%DATA_DIR%" md "%DATA_DIR%" >nul 2>&1

if /i "%~1"=="--elevated" goto :admin_ok
fltmc >nul 2>&1
if not errorlevel 1 goto :admin_ok

cls
echo.
echo   ==============================================================
echo     本工具需要管理员权限才能修改系统设置
echo   ==============================================================
echo.
echo     正在请求管理员权限，请在弹出的 UAC 窗口中点击「是」...
echo.
%PS% "Start-Process -FilePath '%~f0' -ArgumentList '--elevated' -WorkingDirectory '%~dp0' -Verb RunAs" >nul 2>&1
if errorlevel 1 (
    echo.
    echo     [×] 提权失败：可能取消了 UAC 授权，或系统禁止了提权。
    echo         请关闭本窗口，右键本文件选择「以管理员身份运行」。
    echo.
    pause
)
exit /b

:admin_ok
cd /d "%~dp0"
call :log "全能版启动"
call :getfreegb

:menu
cls
color 0B
echo.
echo ============================================================================
echo.
echo                      Windows 系统全能工具箱       v5.0
echo.
echo                                作者：Whisper-LiuBaiPeng
echo.
echo               清理 / 安全 / 外观 / 网络 / 修复   共 48 项功能
echo.
echo ============================================================================
color 0F
echo.
echo   ------------------------------------------------------------------------
echo   [1] 清理与空间        垃圾、DISM、转储、旧系统、保留存储            9 项
echo   [2] 系统与更新        更新、Defender、遥测、广告、服务              8 项
echo   [3] 桌面与任务栏      图标、箭头、盾牌、时间、资源管理器            8 项
echo   [4] 外观与 Win11      右键、任务栏、启动项、照片、Copilot           5 项
echo   [5] 网络与连接        DNS、网络信息、协议栈、DNS 设置               4 项
echo   [6] 修复与报告        修复、图标缓存、报告、应用、电池              6 项
echo   [7] 硬件与性能        磁盘、电源、长路径、内存压缩                  5 项
echo   [8] 恢复与日志        一键还原、查看日志、打开目录                  3 项
echo   ------------------------------------------------------------------------
echo.
echo   C 盘可用：%FREE_GB% GB        日志：%LOG_FILE%
echo   提示：所有可逆改动都集中在 [8] 恢复与日志 中
echo.
echo   [ 0] 退出程序                                   作者：Whisper-LiuBaiPeng
echo.
<nul set /p "=>> 请选择分类（0-8）： "
set "_choice="
set /p "_choice="
if not defined _choice goto :bye
if "%_choice%"=="1" goto :sub1
if "%_choice%"=="2" goto :sub2
if "%_choice%"=="3" goto :sub3
if "%_choice%"=="4" goto :sub4
if "%_choice%"=="5" goto :sub5
if "%_choice%"=="6" goto :sub6
if "%_choice%"=="7" goto :sub7
if "%_choice%"=="8" goto :sub8
if "%_choice%"=="0" goto :bye
echo.
echo     [!] 输入无效，请输入 0 - 8 之间的数字。
ping -n 2 127.0.0.1 >nul 2>&1
goto :menu
:sub1
cls
color 0B
echo.
echo   ============================================================================
echo     【1】清理与空间
echo   ============================================================================
color 0F
echo.
echo     一键释放磁盘空间，全部操作都不会删除个人文件。
echo.
echo   [ 1] 一键清理 C 盘垃圾              [ 6] 保留存储开关
echo   [ 2] DISM 组件存储清理              [ 7] 磁盘优化与 TRIM
echo   [ 3] 内存转储与日志清理             [ 8] 还原点管理
echo   [ 4] 清理 Windows.old               [ 9] 创建系统还原点
echo   [ 5] 传递优化缓存                   
echo.
echo   [ 0] 返回主菜单                                         
echo.
<nul set /p "=>> 请选择： "
set "_s="
set /p "_s="
if not defined _s goto :menu
if "%_s%"=="1" call :b1
if "%_s%"=="2" call :p1
if "%_s%"=="3" call :n1
if "%_s%"=="4" call :n2
if "%_s%"=="5" call :n3
if "%_s%"=="6" call :n4
if "%_s%"=="7" call :p12
if "%_s%"=="8" call :n5
if "%_s%"=="9" call :b16
if "%_s%"=="0" goto :menu
goto :sub1
:sub2
cls
color 0B
echo.
echo   ============================================================================
echo     【2】系统与更新
echo   ============================================================================
color 0F
echo.
echo     更新开关、Defender、遥测、广告、服务优化。
echo.
echo   [ 1] 关闭 Windows 更新              [ 5] 关闭遥测与诊断
echo   [ 2] 开启 Windows 更新              [ 6] 关闭广告与推荐
echo   [ 3] 关闭 Windows Defender          [ 7] 关闭非必要服务
echo   [ 4] 开启 Windows Defender          [ 8] 自动播放开关
echo.
echo   [ 0] 返回主菜单                                         
echo.
<nul set /p "=>> 请选择： "
set "_s="
set /p "_s="
if not defined _s goto :menu
if "%_s%"=="1" call :b2
if "%_s%"=="2" call :b3
if "%_s%"=="3" call :b4
if "%_s%"=="4" call :b5
if "%_s%"=="5" call :p3
if "%_s%"=="6" call :p4
if "%_s%"=="7" call :p7
if "%_s%"=="8" call :n6
if "%_s%"=="0" goto :menu
goto :sub2
:sub3
cls
color 0B
echo.
echo   ============================================================================
echo     【3】桌面与任务栏
echo   ============================================================================
color 0F
echo.
echo     桌面图标、箭头、盾牌、时间、资源管理器细节。
echo.
echo   [ 1] 显示桌面自带图标               [ 5] 时间显示秒
echo   [ 2] 隐藏桌面图标小箭头             [ 6] 隐藏桌面图标小盾牌
echo   [ 3] 取消隐藏小箭头                 [ 7] 扩展名与隐藏文件
echo   [ 4] 任务栏显示星期几               [ 8] 快速访问与历史
echo.
echo   [ 0] 返回主菜单                                         
echo.
<nul set /p "=>> 请选择： "
set "_s="
set /p "_s="
if not defined _s goto :menu
if "%_s%"=="1" call :b6
if "%_s%"=="2" call :b7
if "%_s%"=="3" call :b8
if "%_s%"=="4" call :b9
if "%_s%"=="5" call :b10
if "%_s%"=="6" call :b11
if "%_s%"=="7" call :n7
if "%_s%"=="8" call :n8
if "%_s%"=="0" goto :menu
goto :sub3
:sub4
cls
color 0B
echo.
echo   ============================================================================
echo     【4】外观与 Win11
echo   ============================================================================
color 0F
echo.
echo     右键菜单、任务栏精简、启动项、Copilot。
echo.
echo   [ 1] Win11 经典右键菜单             [ 4] 经典照片查看器
echo   [ 2] 任务栏精简（Win11）            [ 5] 关闭 Copilot / Recall
echo   [ 3] 启动项查看与管理               
echo.
echo   [ 0] 返回主菜单                                         
echo.
<nul set /p "=>> 请选择： "
set "_s="
set /p "_s="
if not defined _s goto :menu
if "%_s%"=="1" call :p5
if "%_s%"=="2" call :p6
if "%_s%"=="3" call :p8
if "%_s%"=="4" call :n9
if "%_s%"=="5" call :n10
if "%_s%"=="0" goto :menu
goto :sub4
:sub5
cls
color 0B
echo.
echo   ============================================================================
echo     【5】网络与连接
echo   ============================================================================
color 0F
echo.
echo     DNS 刷新与设置、网络诊断、协议栈重置。
echo.
echo   [ 1] 刷新 DNS 缓存                  [ 3] 网络协议栈重置
echo   [ 2] 查看网络信息                   [ 4] 一键设置 DNS
echo.
echo   [ 0] 返回主菜单                                         
echo.
<nul set /p "=>> 请选择： "
set "_s="
set /p "_s="
if not defined _s goto :menu
if "%_s%"=="1" call :b12
if "%_s%"=="2" call :b13
if "%_s%"=="3" call :p10
if "%_s%"=="4" call :n11
if "%_s%"=="0" goto :menu
goto :sub5
:sub6
cls
color 0B
echo.
echo   ============================================================================
echo     【6】修复与报告
echo   ============================================================================
color 0F
echo.
echo     系统修复、图标缓存、硬件报告、应用清理。
echo.
echo   [ 1] 系统文件修复 SFC+DISM          [ 4] 生成系统信息报告
echo   [ 2] 重建图标缓存                   [ 5] 卸载精选预装应用
echo   [ 3] 系统状态概览                   [ 6] 电池健康报告
echo.
echo   [ 0] 返回主菜单                                         
echo.
<nul set /p "=>> 请选择： "
set "_s="
set /p "_s="
if not defined _s goto :menu
if "%_s%"=="1" call :p9
if "%_s%"=="2" call :n12
if "%_s%"=="3" call :b14
if "%_s%"=="4" call :p14
if "%_s%"=="5" call :p15
if "%_s%"=="6" call :n13
if "%_s%"=="0" goto :menu
goto :sub6
:sub7
cls
color 0B
echo.
echo   ============================================================================
echo     【7】硬件与性能
echo   ============================================================================
color 0F
echo.
echo     磁盘健康、休眠、电源计划、长路径、内存压缩。
echo.
echo   [ 1] 磁盘健康与 SMART               [ 4] 启用长路径支持
echo   [ 2] 关闭 / 开启休眠                [ 5] 内存压缩开关
echo   [ 3] 电源计划调整                   
echo.
echo   [ 0] 返回主菜单                                         
echo.
<nul set /p "=>> 请选择： "
set "_s="
set /p "_s="
if not defined _s goto :menu
if "%_s%"=="1" call :p11
if "%_s%"=="2" call :p2
if "%_s%"=="3" call :p13
if "%_s%"=="4" call :n14
if "%_s%"=="5" call :n15
if "%_s%"=="0" goto :menu
goto :sub7
:sub8
cls
color 0B
echo.
echo   ============================================================================
echo     【8】恢复与日志
echo   ============================================================================
color 0F
echo.
echo     一键还原所有改动，或查看历史操作记录。
echo.
echo   [ 1] 一键恢复全部设置               [ 3] 打开日志文件夹
echo   [ 2] 查看操作日志                   
echo.
echo   [ 0] 返回主菜单                                         
echo.
<nul set /p "=>> 请选择： "
set "_s="
set /p "_s="
if not defined _s goto :menu
if "%_s%"=="1" call :restore_all
if "%_s%"=="2" call :log_view
if "%_s%"=="3" call :log_dir
if "%_s%"=="0" goto :menu
goto :sub8

:pause_back
echo.
echo     ------------------------------------------------------------------------
echo     按任意键返回主菜单 ...
pause >nul
exit /b

:title
color 0B
echo.
echo   ==========================================================================
echo    %~1
echo   ==========================================================================
color 0F
echo.
exit /b

:log
if not exist "%DATA_DIR%" md "%DATA_DIR%" >nul 2>&1
>>"%LOG_FILE%" echo [%DATE% %TIME%] %~1
exit /b

:confirm
set "CONFIRMED=0"
set "_ans="
set /p "_ans=>> %~1  [Y/N]: "
if /i "%_ans%"=="Y" set "CONFIRMED=1"
exit /b

:confirm_yes
set "CONFIRMED=0"
set "_ans="
set /p "_ans=>> %~1: "
if /i "%_ans%"=="YES" set "CONFIRMED=1"
exit /b

:getfreegb
%PS% "[math]::Round((Get-PSDrive %SystemDrive:~0,1%).Free/1GB,1)" >"%DATA_DIR%\free.tmp" 2>nul
set "FREE_GB="
set /p FREE_GB=<"%DATA_DIR%\free.tmp"
if not defined FREE_GB set "FREE_GB=未知"
exit /b

:getfreemb
%PS% "[int]((Get-PSDrive %SystemDrive:~0,1%).Free/1MB)" >"%DATA_DIR%\mb.tmp" 2>nul
set "OUT="
set /p OUT=<"%DATA_DIR%\mb.tmp"
if not defined OUT set "OUT=0"
exit /b

:refresh_desktop
taskkill /f /im explorer.exe >nul 2>&1
ping -n 2 127.0.0.1 >nul 2>&1
start "" explorer.exe
exit /b

:refresh_icons
taskkill /f /im explorer.exe >nul 2>&1
del /f /q /a "%LOCALAPPDATA%\IconCache.db" >nul 2>&1
del /f /q /a "%LOCALAPPDATA%\Microsoft\Windows\Explorer\iconcache*" >nul 2>&1
del /f /q /a "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache*" >nul 2>&1
ie4uinit.exe -show >nul 2>&1
ping -n 2 127.0.0.1 >nul 2>&1
start "" explorer.exe
exit /b

:wipe
rem 静默清空 %1 目录内的全部内容（保留目录本身）
if not exist "%~1" exit /b
attrib -r -a -s -h "%~1\*" /s /d >nul 2>&1
del /f /s /q "%~1\*" >nul 2>&1
for /d %%D in ("%~1\*") do rd /s /q "%%D" >nul 2>&1
exit /b

:cleanitem
rem %1 路径  %2 显示名称
if not exist "%~1" (
    echo     [-] %~2：不存在，跳过
    exit /b
)
call :wipe "%~1"
echo     [√] %~2
exit /b

:cleanbrowser
set "BC=0"
for %%B in ("%LOCALAPPDATA%\Google\Chrome\User Data" "%LOCALAPPDATA%\Microsoft\Edge\User Data" "%LOCALAPPDATA%\BraveSoftware\Brave-Browser\User Data") do (
    if exist "%%~B" (
        for /d %%P in ("%%~B\*") do (
            for %%C in ("Cache" "Code Cache" "GPUCache" "Service Worker\CacheStorage") do (
                if exist "%%~P\%%~C" (
                    call :wipe "%%~P\%%~C"
                    set /a BC+=1
                )
            )
        )
    )
)
for /d %%P in ("%LOCALAPPDATA%\Mozilla\Firefox\Profiles\*") do (
    if exist "%%~P\cache2" (
        call :wipe "%%~P\cache2"
        set /a BC+=1
    )
)
if %BC% gtr 0 echo     [√] 浏览器缓存（共 %BC% 个缓存目录）
exit /b

:setsvc
rem %1 服务名  %2 启动类型
sc stop %~1 >nul 2>&1
sc config %~1 start= %~2 >nul 2>&1
if errorlevel 1 (
    echo     [!] %~1 设置失败，可能受系统保护
    exit /b 1
)
echo     [√] %~1  %~2
exit /b 0

:save_shortdate
if exist "%DATA_DIR%\shortdate.bak" exit /b
for /f "tokens=2,*" %%A in ('reg query "HKCU\Control Panel\International" /v sShortDate 2^>nul ^| findstr /i "sShortDate"') do >"%DATA_DIR%\shortdate.bak" echo %%B
exit /b

rem ============================ 1 清理 ============================

:b1
cls
call :title "【1】一键清理 C 盘垃圾"
echo     将清理以下内容，不会删除个人文档、照片和桌面文件：
echo.
echo       临时文件（用户 + 系统）          Windows 更新缓存
echo       浏览器缓存（Chrome/Edge/IE）     系统日志与事件
echo       回收站                           预读文件 Prefetch
echo       错误报告 WER                     缩略图缓存
echo.
call :confirm "开始清理"
if not "%CONFIRMED%"=="1" (
    echo.
    echo     已取消。
    call :pause_back
    exit /b
)
echo.
echo     正在读取当前磁盘空间 ...
call :getfreemb
set "MB1=%OUT%"
echo     开始清理，请稍候 ...
echo.
call :cleanitem "%TEMP%" "用户临时文件"
call :cleanitem "%SystemRoot%\Temp" "系统临时文件"
net stop wuauserv /y >nul 2>&1
call :cleanitem "%SystemRoot%\SoftwareDistribution\Download" "Windows 更新缓存"
net start wuauserv >nul 2>&1
call :cleanbrowser
call :cleanitem "%LOCALAPPDATA%\Microsoft\Windows\INetCache" "IE 与系统网络缓存"
for %%L in (System Application Setup) do wevtutil cl %%L >nul 2>&1
echo     [√] 系统日志（System / Application / Setup）
%PS% "Clear-RecycleBin -Force -ErrorAction SilentlyContinue" >nul 2>&1
echo     [√] 回收站
del /f /q "%SystemRoot%\Prefetch\*.pf" >nul 2>&1
echo     [√] 预读文件 Prefetch
call :cleanitem "%ProgramData%\Microsoft\Windows\WER\ReportQueue" "错误报告（队列）"
call :cleanitem "%ProgramData%\Microsoft\Windows\WER\ReportArchive" "错误报告（归档）"
call :cleanitem "%LOCALAPPDATA%\Microsoft\Windows\WER" "错误报告（用户）"
del /f /q /a "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
echo     [√] 缩略图缓存
echo.
call :getfreemb
set "MB2=%OUT%"
set /a FREED=MB2-MB1
if %FREED% lss 0 set "FREED=0"
set /a FREED_G=FREED/1024
set "FREED_TXT=%FREED% MB"
if %FREED% geq 1024 set "FREED_TXT=%FREED_G% GB"
call :getfreegb
echo     ------------------------------------------------------------------------
echo     清理完成：释放约 %FREED_TXT%，C 盘当前可用 %FREE_GB% GB
echo     提示：部分文件正被系统占用，会在下次重启后释放。
echo     ------------------------------------------------------------------------
call :log "清理 C 盘垃圾，释放 %FREED% MB"
call :pause_back
exit /b

rem ============================ 2 关闭更新 ============================

:b2
cls
call :title "【2】关闭 Windows 更新"
echo     本操作将执行三件事：
echo       1. 停止并禁用 Windows Update / 更新编排 / BITS / 传递优化 服务
echo       2. 写入组策略：禁止自动更新，并隐藏「Windows 更新」页面
echo       3. 禁用 Windows 更新相关的计划任务
echo.
echo     [!] 风险提示：系统将不再自动安装安全补丁，长期使用会增加安全风险。
echo     [!] 建议先执行 [16] 创建系统还原点，以便随时回滚。
echo.
call :confirm_yes "第 1 次确认，请输入 YES"
if not "%CONFIRMED%"=="1" goto :b2_no
call :confirm_yes "第 2 次确认，请再次输入 YES"
if not "%CONFIRMED%"=="1" goto :b2_no
echo.
echo     [1/3] 处理服务 ...
call :setsvc wuauserv disabled
call :setsvc UsoSvc disabled
call :setsvc BITS disabled
call :setsvc DoSvc disabled
call :setsvc WaaSMedicSvc disabled
echo.
echo     [2/3] 写入组策略 ...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v AUOptions /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoRebootWithLoggedOnUsers /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DisableWindowsUpdateAccess /t REG_DWORD /d 1 /f >nul 2>&1
echo     [√] NoAutoUpdate / AUOptions / DisableWindowsUpdateAccess
echo.
echo     [3/3] 禁用计划任务 ...
set /a TOK=0
for %%T in (
    "\Microsoft\Windows\WindowsUpdate\Scheduled Start"
    "\Microsoft\Windows\WindowsUpdate\sih"
    "\Microsoft\Windows\WindowsUpdate\sihboot"
    "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan"
    "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task"
    "\Microsoft\Windows\UpdateOrchestrator\USO_UxBroker_Display"
    "\Microsoft\Windows\UpdateOrchestrator\Reboot"
    "\Microsoft\Windows\WaaSMedic\PerformRemediation"
    "\Microsoft\Windows\InstallService\ScanForUpdates"
    "\Microsoft\Windows\InstallService\ScanForUpdatesAsUser"
) do (
    schtasks /change /tn %%T /disable >nul 2>&1
    if errorlevel 1 (echo     [-] %%~T：受系统保护，已跳过) else (set /a TOK+=1)
)
echo     [√] 已禁用 %TOK% 个计划任务
echo.
echo     ------------------------------------------------------------------------
echo     完成。建议重启电脑使设置完全生效。
echo     ------------------------------------------------------------------------
call :log "关闭 Windows 更新"
call :pause_back
exit /b

:b2_no
echo.
echo     已取消，未做任何修改。
call :pause_back
exit /b

rem ============================ 3 开启更新 ============================

:b3
cls
call :title "【3】开启 Windows 更新"
echo     将把 Windows 更新恢复为系统默认状态：
echo       恢复 5 项服务、清除组策略限制、重新启用计划任务
echo.
call :confirm "确认恢复"
if not "%CONFIRMED%"=="1" (
    echo.
    echo     已取消。
    call :pause_back
    exit /b
)
echo.
echo     [1/3] 恢复服务 ...
call :setsvc wuauserv demand
call :setsvc UsoSvc auto
call :setsvc BITS demand
call :setsvc DoSvc demand
call :setsvc WaaSMedicSvc demand
echo.
echo     [2/3] 清除组策略限制 ...
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /f >nul 2>&1
echo     [√] 已清除 WindowsUpdate 策略
echo.
echo     [3/3] 启用计划任务 ...
set /a TOK=0
for %%T in (
    "\Microsoft\Windows\WindowsUpdate\Scheduled Start"
    "\Microsoft\Windows\WindowsUpdate\sih"
    "\Microsoft\Windows\WindowsUpdate\sihboot"
    "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan"
    "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task"
    "\Microsoft\Windows\UpdateOrchestrator\USO_UxBroker_Display"
    "\Microsoft\Windows\UpdateOrchestrator\Reboot"
    "\Microsoft\Windows\WaaSMedic\PerformRemediation"
    "\Microsoft\Windows\InstallService\ScanForUpdates"
    "\Microsoft\Windows\InstallService\ScanForUpdatesAsUser"
) do (
    schtasks /change /tn %%T /enable >nul 2>&1
    if errorlevel 1 (echo     [-] %%~T：受系统保护，已跳过) else (set /a TOK+=1)
)
echo     [√] 已启用 %TOK% 个计划任务
echo.
sc start wuauserv >nul 2>&1
echo     [√] 已启动 Windows Update 服务
echo.
echo     ------------------------------------------------------------------------
echo     完成。建议重启后进入「设置 → Windows 更新」手动检查一次。
echo     ------------------------------------------------------------------------
call :log "开启 Windows 更新"
call :pause_back
exit /b

rem ============================ 4 关闭 Defender ============================

:b4
cls
call :title "【4】关闭 Windows Defender"
echo     将尝试关闭：实时保护 / 行为监控 / 下载扫描 / 脚本扫描 / 压缩包扫描
echo     并写入 DisableAntiSpyware 等组策略键值。
echo.
echo     [!] Windows 10 1903 之后默认开启「篡改防护」，本项很可能被系统拦截。
echo         若无效，请先到「Windows 安全中心 → 病毒和威胁防护 → 管理设置」
echo         关闭「篡改防护」，然后重新执行本项。
echo     [!] 关闭防护会让系统暴露在风险中，请自行评估并承担后果。
echo.
call :confirm_yes "第 1 次确认，请输入 YES"
if not "%CONFIRMED%"=="1" goto :b4_no
call :confirm_yes "第 2 次确认，请再次输入 YES"
if not "%CONFIRMED%"=="1" goto :b4_no
echo.
echo     [1/3] 写入组策略 ...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiVirus /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableBehaviorMonitoring /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableIOAVProtection /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableScriptScanning /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableArchiveScanning /t REG_DWORD /d 1 /f >nul 2>&1
echo     [√] 组策略已写入
echo.
echo     [2/3] 关闭实时防护（Set-MpPreference）...
%PS% "try{Set-MpPreference -DisableRealtimeMonitoring $true -DisableBehaviorMonitoring $true -DisableIOAVProtection $true -DisableScriptScanning $true -DisableArchiveScanning $true -ErrorAction Stop; '     [√] 已提交关闭请求'}catch{'     [!] 被系统拒绝：'+$_.Exception.Message}"
echo.
echo     [3/3] 处理 WinDefend 服务 ...
sc stop WinDefend >nul 2>&1
sc config WinDefend start= disabled >nul 2>&1
if errorlevel 1 (echo     [!] WinDefend 受保护，无法修改启动类型) else (echo     [√] WinDefend 已设为禁用)
echo.
%PS% "try{$r=(Get-MpComputerStatus).RealTimeProtectionEnabled;if($r){'     当前状态：实时保护仍然开启'}else{'     当前状态：实时保护已关闭'}}catch{'     当前状态：无法读取（服务可能被禁用）'}"
echo.
echo     ------------------------------------------------------------------------
echo     结束。若实时保护仍为开启，请按上方提示关闭「篡改防护」后重试。
echo     ------------------------------------------------------------------------
call :log "尝试关闭 Windows Defender"
call :pause_back
exit /b

:b4_no
echo.
echo     已取消，未做任何修改。
call :pause_back
exit /b

rem ============================ 5 开启 Defender ============================

:b5
cls
call :title "【5】开启 Windows Defender"
echo     将清除限制策略、恢复实时保护并重新启动 WinDefend 服务。
echo.
call :confirm "确认开启"
if not "%CONFIRMED%"=="1" (
    echo.
    echo     已取消。
    call :pause_back
    exit /b
)
echo.
echo     [1/3] 清除限制策略 ...
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiVirus /f >nul 2>&1
echo     [√] 已清除 Defender 策略
echo.
echo     [2/3] 恢复服务 ...
sc config WinDefend start= auto >nul 2>&1
sc start WinDefend >nul 2>&1
echo     [√] 已尝试启动 WinDefend
echo.
echo     [3/3] 恢复实时防护 ...
%PS% "try{Set-MpPreference -DisableRealtimeMonitoring $false -DisableBehaviorMonitoring $false -DisableIOAVProtection $false -DisableScriptScanning $false -DisableArchiveScanning $false -ErrorAction Stop; '     [√] 已恢复'}catch{'     [!] 恢复失败：'+$_.Exception.Message}"
echo.
%PS% "try{$r=(Get-MpComputerStatus).RealTimeProtectionEnabled;if($r){'     当前状态：实时保护已开启'}else{'     当前状态：实时保护未开启，请重启后检查'}}catch{'     当前状态：无法读取，请重启后检查'}"
echo.
echo     ------------------------------------------------------------------------
echo     完成。建议重启电脑，并运行一次「快速扫描」确认防护正常。
echo     ------------------------------------------------------------------------
call :log "开启 Windows Defender"
call :pause_back
exit /b

rem ============================ 6 桌面图标 ============================

:b6
cls
call :title "【6】显示桌面自带图标"
echo     将在桌面显示：此电脑、用户文件夹、网络、回收站、控制面板
echo.
call :confirm "立即设置并刷新桌面"
if not "%CONFIRMED%"=="1" (
    echo.
    echo     已取消。
    call :pause_back
    exit /b
)
set "K=HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons"
reg add "%K%\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%K%\NewStartPanel" /v "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%K%\NewStartPanel" /v "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%K%\NewStartPanel" /v "{645FF040-5081-101B-9F08-00AA002F954E}" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%K%\NewStartPanel" /v "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%K%\ClassicStartMenu" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%K%\ClassicStartMenu" /v "{645FF040-5081-101B-9F08-00AA002F954E}" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideIcons /t REG_DWORD /d 0 /f >nul 2>&1
echo     [√] 注册表已更新
echo     正在刷新桌面，屏幕会闪一下 ...
call :refresh_desktop
echo     [√] 完成，桌面图标已显示
call :log "显示桌面自带图标"
call :pause_back
exit /b

rem ============================ 7 隐藏箭头 ============================

:b7
cls
call :title "【7】隐藏桌面图标小箭头"
echo     将把快捷方式图标左下角的小箭头替换为透明图标。
echo.
call :confirm "确认修改"
if not "%CONFIRMED%"=="1" (
    echo.
    echo     已取消。
    call :pause_back
    exit /b
)
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29 /t REG_SZ /d "%SystemRoot%\System32\shell32.dll,-50" /f >nul 2>&1
echo     [√] 注册表已更新
echo     正在重建图标缓存 ...
call :refresh_icons
echo     [√] 完成，小箭头已隐藏
call :log "隐藏快捷方式箭头"
call :pause_back
exit /b

rem ============================ 8 恢复箭头 ============================

:b8
cls
call :title "【8】取消隐藏小箭头（恢复默认）"
echo     将删除 Shell Icons 中的 29 号覆盖项，恢复系统默认箭头。
echo.
call :confirm "确认恢复"
if not "%CONFIRMED%"=="1" (
    echo.
    echo     已取消。
    call :pause_back
    exit /b
)
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29 /f >nul 2>&1
echo     [√] 已删除自定义箭头设置
echo     正在重建图标缓存 ...
call :refresh_icons
echo     [√] 完成，小箭头已恢复
call :log "恢复快捷方式箭头"
call :pause_back
exit /b

rem ============================ 9 星期几 ============================

:b9
cls
call :title "【9】任务栏显示星期几"
echo       [1] 开启：日期格式改为 yyyy/M/d dddd（如 2026/10/25 星期日）
echo       [2] 还原：恢复系统原来的日期格式
echo       [0] 返回主菜单
echo.
set "_s="
set /p "_s=>> 请选择： "
if "%_s%"=="1" goto :b9_on
if "%_s%"=="2" goto :b9_off
exit /b

:b9_on
call :save_shortdate
reg add "HKCU\Control Panel\International" /v sShortDate /t REG_SZ /d "yyyy/M/d dddd" /f >nul 2>&1
echo.
echo     [√] 已设置为 yyyy/M/d dddd
echo     正在刷新任务栏 ...
call :refresh_desktop
echo     [√] 完成
echo     提示：若显示的是英文星期，请把「区域格式」设为中文（简体）。
call :log "开启任务栏星期"
call :pause_back
exit /b

:b9_off
set "SD=yyyy/M/d"
if exist "%DATA_DIR%\shortdate.bak" set /p SD=<"%DATA_DIR%\shortdate.bak"
reg add "HKCU\Control Panel\International" /v sShortDate /t REG_SZ /d "%SD%" /f >nul 2>&1
echo.
echo     [√] 已恢复为 %SD%
call :refresh_desktop
echo     [√] 完成
call :log "还原日期格式 %SD%"
call :pause_back
exit /b

rem ============================ 10 秒 ============================

:b10
cls
call :title "【10】任务栏时间显示秒"
echo       [1] 开启：在任务栏时钟显示秒数
echo       [2] 关闭：恢复只显示时和分
echo       [0] 返回主菜单
echo.
set "_s="
set /p "_s=>> 请选择： "
if "%_s%"=="1" goto :b10_on
if "%_s%"=="2" goto :b10_off
exit /b

:b10_on
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSecondsInSystemClock /t REG_DWORD /d 1 /f >nul 2>&1
echo.
echo     [√] 已开启
echo     正在刷新任务栏 ...
call :refresh_desktop
echo     [√] 完成
call :log "开启时钟秒数"
call :pause_back
exit /b

:b10_off
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSecondsInSystemClock /t REG_DWORD /d 0 /f >nul 2>&1
echo.
echo     [√] 已关闭
call :refresh_desktop
echo     [√] 完成
call :log "关闭时钟秒数"
call :pause_back
exit /b

rem ============================ 11 小盾牌 ============================

:b11
cls
call :title "【11】隐藏桌面图标小盾牌"
echo     将把 UAC 盾牌覆盖图标替换为透明图标。
echo.
echo     [!] 仅隐藏图标显示，UAC 本身仍然生效，系统安全性不受影响。
echo.
call :confirm "确认修改"
if not "%CONFIRMED%"=="1" (
    echo.
    echo     已取消。
    call :pause_back
    exit /b
)
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 77 /t REG_SZ /d "%SystemRoot%\System32\shell32.dll,-50" /f >nul 2>&1
echo     [√] 注册表已更新
echo     正在重建图标缓存 ...
call :refresh_icons
echo     [√] 完成
echo     提示：个别系统版本可能需要注销后重新登录，盾牌才会消失。
call :log "隐藏 UAC 盾牌图标"
call :pause_back
exit /b

rem ============================ 12 DNS ============================

:b12
cls
call :title "【12】刷新 DNS 缓存"
echo     正在刷新 DNS 解析缓存 ...
echo.
ipconfig /flushdns
nbtstat -R >nul 2>&1
echo     [√] NetBIOS 名称缓存已清理
echo.
echo     提示：修改 hosts 文件、更换 DNS 或网站无法访问时，本操作常能立即生效。
call :log "刷新 DNS 缓存"
call :pause_back
exit /b

rem ============================ 13 网络信息 ============================

:b13
cls
call :title "【13】查看网络信息"
echo     计算机名：%COMPUTERNAME%        当前用户：%USERNAME%
echo.
echo     ---- 已连接的网络适配器 ----
%PS% "try{Get-NetIPConfiguration | Where-Object {$_.IPv4Address} | ForEach-Object {'  ['+$_.InterfaceAlias+']   IP '+(($_.IPv4Address.IPAddress) -join ', ')+'   网关 '+(($_.IPv4DefaultGateway.NextHop) -join ', ')}}catch{'  读取失败'}"
echo.
echo     ---- DNS 服务器 ----
%PS% "try{'  '+(((Get-DnsClientServerAddress -AddressFamily IPv4 | Where-Object {$_.ServerAddresses}).ServerAddresses | Select-Object -Unique) -join '   ')}catch{'  读取失败'}"
echo.
echo       [1] 查看完整信息（ipconfig /all，分页显示）
echo       [2] 生成网络诊断报告到桌面
echo       [0] 返回主菜单
echo.
set "_s="
set /p "_s=>> 请选择： "
if "%_s%"=="1" goto :b13_all
if "%_s%"=="2" goto :b13_report
exit /b

:b13_all
cls
ipconfig /all | more
echo.
call :pause_back
exit /b

:b13_report
%PS% "Get-Date -Format yyyyMMdd_HHmmss" >"%DATA_DIR%\ts.tmp" 2>nul
set "TS="
set /p TS=<"%DATA_DIR%\ts.tmp"
if not defined TS set "TS=report"
set "DESK=%USERPROFILE%\Desktop"
if not exist "%DESK%" set "DESK=%USERPROFILE%\OneDrive\Desktop"
if not exist "%DESK%" set "DESK=%USERPROFILE%"
set "REP=%DESK%\网络诊断报告_%TS%.txt"
echo.
echo     正在生成报告 ...
(
    echo ================ 网络诊断报告 ================
    echo 生成时间：%DATE% %TIME%
    echo 计算机名：%COMPUTERNAME%
    echo 当前用户：%USERNAME%
    echo.
    echo ---------------- ipconfig /all ----------------
    ipconfig /all
    echo.
    echo ---------------- 路由表 ----------------
    route print
    echo.
    echo ---------------- MAC 地址 ----------------
    getmac /v
    echo.
    echo ---------------- 无线网络 ----------------
    netsh wlan show interfaces
    echo.
    echo ---------------- 连通性测试 ----------------
    ping -n 2 223.5.5.5
    echo.
    ping -n 2 www.baidu.com
    echo.
    echo ---------------- 报告结束 ----------------
)>"%REP%" 2>&1
echo     [√] 报告已保存到：%REP%
call :log "生成网络诊断报告"
call :pause_back
exit /b

rem ============================ 14 系统概览 ============================

:b14
cls
call :title "【14】系统状态概览"
%PS% "$o=Get-CimInstance Win32_OperatingSystem;$c=Get-CimInstance Win32_ComputerSystem;$u=Get-CimInstance Win32_Processor;'  操作系统 : '+$o.Caption+'  ['+$o.Version+']';'  计算机名 : '+$env:COMPUTERNAME+'    当前用户 : '+$env:USERNAME;'  处理器   : '+$u.Name;'  物理内存 : '+[math]::Round($c.TotalPhysicalMemory/1GB,1)+' GB';'  运行时长 : '+[math]::Round(((Get-Date)-$o.LastBootUpTime).TotalHours,1)+' 小时';'  启动时间 : '+$o.LastBootUpTime.ToString('yyyy-MM-dd HH:mm')"
echo.
%PS% "$d=Get-PSDrive %SystemDrive:~0,1%;$t=$d.Free+$d.Used;'  磁盘可用 : '+[math]::Round($d.Free/1GB,2)+' GB / 共 '+[math]::Round($t/1GB,2)+' GB';'  磁盘已用 : '+[math]::Round(($d.Used/$t)*100,1)+' %';'  系统目录 : '+$env:SystemRoot"
echo.
echo     提示：更详细的实时数据可在「任务管理器 → 性能」中查看。
call :pause_back
exit /b

rem ============================ 15 恢复默认 ============================

:b15
cls
call :title "【15】一键恢复默认设置"
echo     将把下列项目恢复为系统默认状态：
echo       - Windows 更新服务、组策略与计划任务
echo       - Windows Defender 策略与服务
echo       - 快捷方式小箭头、UAC 小盾牌
echo       - 任务栏日期格式、时钟秒数
echo       - 图标缓存与资源管理器
echo.
call :confirm "确认恢复"
if not "%CONFIRMED%"=="1" (
    echo.
    echo     已取消。
    call :pause_back
    exit /b
)
echo.
echo     [1/5] 恢复 Windows 更新 ...
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /f >nul 2>&1
call :setsvc wuauserv demand
call :setsvc UsoSvc auto
call :setsvc BITS demand
call :setsvc DoSvc demand
call :setsvc WaaSMedicSvc demand
for %%T in (
    "\Microsoft\Windows\WindowsUpdate\Scheduled Start"
    "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan"
    "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task"
    "\Microsoft\Windows\UpdateOrchestrator\Reboot"
    "\Microsoft\Windows\WaaSMedic\PerformRemediation"
    "\Microsoft\Windows\InstallService\ScanForUpdates"
) do schtasks /change /tn %%T /enable >nul 2>&1
sc start wuauserv >nul 2>&1
echo     [√] 完成
echo.
echo     [2/5] 恢复 Windows Defender ...
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiVirus /f >nul 2>&1
sc config WinDefend start= auto >nul 2>&1
sc start WinDefend >nul 2>&1
%PS% "try{Set-MpPreference -DisableRealtimeMonitoring $false -DisableBehaviorMonitoring $false -DisableIOAVProtection $false -DisableScriptScanning $false -DisableArchiveScanning $false -ErrorAction Stop}catch{}" >nul 2>&1
echo     [√] 完成
echo.
echo     [3/5] 恢复桌面外观 ...
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29 /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 77 /f >nul 2>&1
echo     [√] 完成
echo.
echo     [4/5] 恢复任务栏 ...
set "SD=yyyy/M/d"
if exist "%DATA_DIR%\shortdate.bak" set /p SD=<"%DATA_DIR%\shortdate.bak"
reg add "HKCU\Control Panel\International" /v sShortDate /t REG_SZ /d "%SD%" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSecondsInSystemClock /t REG_DWORD /d 0 /f >nul 2>&1
echo     [√] 完成（日期格式 %SD%）
echo.
echo     [5/5] 重建图标缓存并刷新资源管理器 ...
call :refresh_icons
echo     [√] 完成
echo.
echo     ------------------------------------------------------------------------
echo     全部设置已恢复默认。若桌面仍显示旧图标，注销后重新登录即可。
echo     ------------------------------------------------------------------------
call :log "一键恢复默认设置"
call :pause_back
exit /b

rem ============================ 16 还原点 ============================

:b16
cls
call :title "【16】创建系统还原点"
echo     正在创建还原点，通常需要 10 到 60 秒，请勿关闭窗口 ...
echo.
%PS% "try{Checkpoint-Computer -Description 'WinToolbox' -RestorePointType 'MODIFY_SETTINGS' -ErrorAction Stop;'     [√] 还原点创建成功'}catch{'     [!] 创建失败：'+$_.Exception.Message}"
echo.
call :confirm "是否尝试自动开启系统保护并重试"
if not "%CONFIRMED%"=="1" (
    echo.
    echo     已跳过。
    call :pause_back
    exit /b
)
echo.
echo     正在开启系统保护 ...
%PS% "try{Enable-ComputerRestore -Drive '%SystemDrive%\';'     [√] 系统保护已开启'}catch{'     [!] 开启失败：'+$_.Exception.Message}"
echo     正在重新创建还原点 ...
%PS% "try{Checkpoint-Computer -Description 'WinToolbox' -RestorePointType 'MODIFY_SETTINGS' -ErrorAction Stop;'     [√] 还原点创建成功'}catch{'     [!] 仍然失败：'+$_.Exception.Message}"
echo.
echo     提示：Windows 默认限制每 24 小时只能创建一个还原点。
call :log "创建系统还原点"
call :pause_back
exit /b

:p1
cls
call :title "【1】DISM 组件存储清理"
echo     分析并清理 WinSxS 组件存储，通常可释放数 GB 空间。
echo.
echo     [!] 分析约 1-3 分钟，清理约 10-30 分钟，请勿关闭窗口。
echo     [!] 清理不会影响已安装的程序；/ResetBase 会让已装更新无法卸载。
echo.
echo       [1] 仅分析（推荐先做，只读不改）
echo       [2] 清理旧组件（安全，可回滚更新）
echo       [3] 清理并重置基线 /ResetBase（不可回滚更新）
echo       [0] 返回主菜单
echo.
set "_s="
set /p "_s=>> 请选择： "
if "%_s%"=="1" goto :p1_a
if "%_s%"=="2" goto :p1_b
if "%_s%"=="3" goto :p1_c
exit /b

:p1_a
echo.
echo     正在分析组件存储 ...
echo.
Dism /Online /Cleanup-Image /AnalyzeComponentStore
echo.
call :log "DISM 分析组件存储"
call :pause_back
exit /b

:p1_b
echo.
call :confirm "清理旧组件，可能持续 10-30 分钟"
if not "%CONFIRMED%"=="1" goto :p1_no
echo.
Dism /Online /Cleanup-Image /StartComponentCleanup
echo.
call :log "DISM 清理组件存储"
call :pause_back
exit /b

:p1_c
echo.
echo     [!] /ResetBase 之后将无法卸载任何已安装的更新。
call :confirm "确认执行 ResetBase"
if not "%CONFIRMED%"=="1" goto :p1_no
call :confirm_yes "再输入一次 YES 最终确认"
if not "%CONFIRMED%"=="1" goto :p1_no
echo.
Dism /Online /Cleanup-Image /StartComponentCleanup /ResetBase
echo.
call :log "DISM 清理并重置基线"
call :pause_back
exit /b

:p1_no
echo.
echo     已取消。
call :pause_back
exit /b

rem ============================ 2 休眠 ============================

:p2
cls
call :title "【2】休眠文件（hiberfil.sys）"
echo     休眠文件通常占用物理内存的 40%-100%，关闭后可释放数 GB。
echo.
echo       [1] 关闭休眠（同时关闭快速启动）
echo       [2] 开启休眠
echo       [0] 返回主菜单
echo.
set "_s="
set /p "_s=>> 请选择： "
if "%_s%"=="1" goto :p2_off
if "%_s%"=="2" goto :p2_on
exit /b

:p2_off
powercfg -h off
if errorlevel 1 (
    echo     [!] 关闭失败，请确认以管理员身份运行
    call :pause_back
    exit /b
)
echo     [√] 休眠已关闭，hiberfil.sys 已删除
echo     注意：快速启动同时失效，开机会慢几秒。
call :getfreegb
echo     当前 C 盘可用：%FREE_GB% GB
call :log "关闭休眠"
call :pause_back
exit /b

:p2_on
powercfg -h on
if errorlevel 1 (
    echo     [!] 开启失败，请确认以管理员身份运行
    call :pause_back
    exit /b
)
echo     [√] 休眠已开启（快速启动同时恢复）
call :log "开启休眠"
call :pause_back
exit /b

rem ============================ 3 遥测 ============================

:p3
cls
call :title "【3】关闭遥测与诊断数据"
echo     将关闭诊断跟踪服务、遥测计划任务，并写入 AllowTelemetry 策略。
echo.
echo       [1] 关闭遥测
echo       [2] 恢复默认
echo       [0] 返回主菜单
echo.
set "_s="
set /p "_s=>> 请选择： "
if "%_s%"=="1" goto :p3_off
if "%_s%"=="2" goto :p3_on
exit /b

:p3_off
echo.
call :confirm "关闭遥测与诊断数据"
if not "%CONFIRMED%"=="1" goto :p3_no
echo.
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
echo     [√] AllowTelemetry = 0
call :setsvc DiagTrack disabled
call :setsvc dmwappushservice disabled
set /a NT=0
for %%T in (
    "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
    "\Microsoft\Windows\Application Experience\ProgramDataUpdater"
    "\Microsoft\Windows\Application Experience\AitAgent"
    "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
    "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
    "\Microsoft\Windows\Feedback\Siuf\DmClient"
    "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload"
) do (
    schtasks /change /tn %%T /disable >nul 2>&1
    if not errorlevel 1 set /a NT+=1
)
echo     [√] 已禁用 %NT% 个遥测计划任务
echo.
echo     [!] 家庭版 Windows 最低只允许 Basic 级遥测，策略可能被系统忽略。
call :log "关闭遥测"
call :pause_back
exit /b

:p3_on
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /f >nul 2>&1
call :setsvc DiagTrack auto
call :setsvc dmwappushservice demand
for %%T in (
    "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
    "\Microsoft\Windows\Application Experience\ProgramDataUpdater"
    "\Microsoft\Windows\Application Experience\AitAgent"
    "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
    "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
    "\Microsoft\Windows\Feedback\Siuf\DmClient"
    "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload"
) do schtasks /change /tn %%T /enable >nul 2>&1
echo     [√] 遥测相关设置已恢复默认
call :log "恢复遥测设置"
call :pause_back
exit /b

:p3_no
echo.
echo     已取消。
call :pause_back
exit /b

rem ============================ 4 广告 ============================

:p4
cls
call :title "【4】关闭系统广告与推荐"
echo     包括：开始菜单推荐、设置建议、锁屏提示、静默安装商店应用、
echo           同步提供程序通知、广告 ID。
echo.
echo       [1] 全部关闭
echo       [2] 恢复默认
echo       [0] 返回主菜单
echo.
set "_s="
set /p "_s=>> 请选择： "
if "%_s%"=="1" goto :p4_off
if "%_s%"=="2" goto :p4_on
exit /b

:p4_off
echo.
call :confirm "关闭广告与推荐"
if not "%CONFIRMED%"=="1" goto :p4_no
echo.
set "CDM=HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
for %%V in (SilentInstalledAppsEnabled SystemPaneSuggestionsEnabled SoftLandingEnabled RotatingLockScreenOverlayEnabled) do reg add "%CDM%" /v %%V /t REG_DWORD /d 0 /f >nul 2>&1
for %%V in (SubscribedContent-338388Enabled SubscribedContent-338389Enabled SubscribedContent-338387Enabled SubscribedContent-353694Enabled SubscribedContent-353696Enabled) do reg add "%CDM%" /v %%V /t REG_DWORD /d 0 /f >nul 2>&1
echo     [√] ContentDeliveryManager 推荐项已关闭
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableSoftLanding /t REG_DWORD /d 1 /f >nul 2>&1
echo     [√] 已禁用系统推送与建议
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSyncProviderNotifications /t REG_DWORD /d 0 /f >nul 2>&1
echo     [√] 广告 ID 与同步通知已关闭
call :log "关闭广告推荐"
call :pause_back
exit /b

:p4_on
set "CDM=HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
for %%V in (SilentInstalledAppsEnabled SystemPaneSuggestionsEnabled SoftLandingEnabled RotatingLockScreenOverlayEnabled) do reg add "%CDM%" /v %%V /t REG_DWORD /d 1 /f >nul 2>&1
for %%V in (SubscribedContent-338388Enabled SubscribedContent-338389Enabled SubscribedContent-338387Enabled SubscribedContent-353694Enabled SubscribedContent-353696Enabled) do reg add "%CDM%" /v %%V /t REG_DWORD /d 1 /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 1 /f >nul 2>&1
echo     [√] 广告与推荐设置已恢复默认
call :log "恢复广告推荐设置"
call :pause_back
exit /b

:p4_no
echo.
echo     已取消。
call :pause_back
exit /b

rem ============================ 5 右键菜单 ============================

:p5
cls
call :title "【5】Win11 经典右键菜单"
echo     Win11 默认的二级菜单可以改回 Win10 的完整菜单。
echo     本项仅对 Win11 生效，Win10 无需设置。
echo.
echo       [1] 恢复经典右键菜单
echo       [2] 还原为 Win11 默认
echo       [0] 返回主菜单
echo.
set "_s="
set /p "_s=>> 请选择： "
if "%_s%"=="1" goto :p5_on
if "%_s%"=="2" goto :p5_off
exit /b

:p5_on
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve >nul 2>&1
echo     [√] 已写入经典菜单配置
echo     正在重启资源管理器 ...
call :refresh_desktop
echo     [√] 完成
call :log "Win11 经典右键菜单"
call :pause_back
exit /b

:p5_off
reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f >nul 2>&1
echo     [√] 已还原为 Win11 默认菜单
call :refresh_desktop
echo     [√] 完成
call :log "还原 Win11 右键菜单"
call :pause_back
exit /b

rem ============================ 6 任务栏 ============================

:p6
cls
call :title "【6】任务栏精简（Win11）"
echo     关闭小组件、聊天按钮、任务视图，搜索框改为仅图标。
echo.
echo       [1] 精简任务栏
echo       [2] 恢复默认
echo       [0] 返回主菜单
echo.
set "_s="
set /p "_s=>> 请选择： "
if "%_s%"=="1" goto :p6_on
if "%_s%"=="2" goto :p6_off
exit /b

:p6_on
set "ADV=HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
reg add "%ADV%" /v TaskbarDa /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%ADV%" /v TaskbarMn /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%ADV%" /v ShowTaskViewButton /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%ADV%" /v SearchboxTaskbarMode /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" /v ShellFeedsTaskbarViewMode /t REG_DWORD /d 2 /f >nul 2>&1
echo     [√] 任务栏配置已写入
call :refresh_desktop
echo     [√] 完成
call :log "任务栏精简"
call :pause_back
exit /b

:p6_off
set "ADV=HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
reg add "%ADV%" /v TaskbarDa /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%ADV%" /v TaskbarMn /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%ADV%" /v ShowTaskViewButton /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%ADV%" /v SearchboxTaskbarMode /t REG_DWORD /d 2 /f >nul 2>&1
echo     [√] 已恢复默认
call :refresh_desktop
echo     [√] 完成
call :log "还原任务栏"
call :pause_back
exit /b

rem ============================ 7 服务 ============================

:p7
cls
call :title "【7】关闭非必要服务"
echo       [1] 轻度：远程注册表、传真、WMP 共享、地图、零售演示
echo       [2] 中度：轻度 + SysMain、Windows 搜索、诊断跟踪
echo       [3] 恢复默认
echo       [0] 返回主菜单
echo.
echo     [!] 中度会关闭剪贴板历史、开始菜单搜索联网与超级预读，
echo         机械硬盘用户请不要关闭 SysMain。
echo.
set "_s="
set /p "_s=>> 请选择： "
if "%_s%"=="1" goto :p7_light
if "%_s%"=="2" goto :p7_mid
if "%_s%"=="3" goto :p7_reset
exit /b

:p7_light
echo.
for %%S in (RemoteRegistry Fax WMPNetworkSvc MapsBroker RetailDemo) do call :setsvc %%S disabled
echo.
echo     [√] 轻度优化完成
call :log "关闭非必要服务（轻度）"
call :pause_back
exit /b

:p7_mid
echo.
for %%S in (RemoteRegistry Fax WMPNetworkSvc MapsBroker RetailDemo SysMain WSearch DiagTrack) do call :setsvc %%S disabled
echo.
echo     [√] 中度优化完成，建议重启后观察系统响应
call :log "关闭非必要服务（中度）"
call :pause_back
exit /b

:p7_reset
echo.
call :setsvc RemoteRegistry disabled
call :setsvc Fax demand
call :setsvc WMPNetworkSvc demand
call :setsvc MapsBroker auto
call :setsvc RetailDemo demand
call :setsvc SysMain auto
call :setsvc WSearch auto
call :setsvc DiagTrack auto
sc start SysMain >nul 2>&1
sc start WSearch >nul 2>&1
echo.
echo     [√] 服务已恢复为默认启动类型
call :log "恢复默认服务"
call :pause_back
exit /b

rem ============================ 8 启动项 ============================

:p8
cls
call :title "【8】启动项查看与管理"
echo     ---- 当前开机启动项 ----
%PS% "try{Get-CimInstance Win32_StartupCommand | ForEach-Object {'  ['+$_.Location+']  '+$_.Name; '        '+$_.Command}}catch{'  读取失败'}"
echo.
echo       [1] 打开设置·启动 页面
echo       [2] 打开任务管理器
echo       [3] 导出启动项到桌面
echo       [0] 返回主菜单
echo.
set "_s="
set /p "_s=>> 请选择： "
if "%_s%"=="1" start "" ms-settings:startupapps
if "%_s%"=="1" goto :p8_done
if "%_s%"=="2" start "" taskmgr
if "%_s%"=="2" goto :p8_done
if "%_s%"=="3" goto :p8_export
exit /b

:p8_done
echo.
echo     已在系统中打开对应窗口。
call :pause_back
exit /b

:p8_export
%PS% "Get-Date -Format yyyyMMdd_HHmmss" >"%DATA_DIR%\ts.tmp" 2>nul
set "TS="
set /p TS=<"%DATA_DIR%\ts.tmp"
if not defined TS set "TS=report"
set "DESK=%USERPROFILE%\Desktop"
if not exist "%DESK%" set "DESK=%USERPROFILE%"
set "REP=%DESK%\启动项清单_%TS%.txt"
(
    echo ============ 开机启动项 ============
    echo 生成时间：%DATE% %TIME%
    echo 计算机：%COMPUTERNAME%
    echo.
    %PS% "Get-CimInstance Win32_StartupCommand | Format-List Name,Command,Location,User"
    echo.
    echo ============ 计划任务中的登录项 ============
    schtasks /query /fo list /fi "logonmode eq 'interactive/background'" 2>nul
)>"%REP%" 2>&1
echo.
echo     [√] 已导出：%REP%
call :pause_back
exit /b

rem ============================ 9 系统修复 ============================

:p9
cls
call :title "【9】系统文件修复 SFC + DISM"
echo     修复系统文件损坏、组件存储损坏导致的蓝屏、更新失败、应用打不开。
echo.
echo     [!] 全程可能需要 15-60 分钟，请保持供电，期间可以最小化窗口。
echo.
call :confirm "开始扫描并修复"
if not "%CONFIRMED%"=="1" (
    echo.
    echo     已取消。
    call :pause_back
    exit /b
)
echo.
echo     [1/2] 正在扫描系统文件（sfc /scannow）...
echo.
sfc /scannow
echo.
echo     [2/2] 正在修复组件存储（DISM /RestoreHealth）...
echo.
Dism /Online /Cleanup-Image /RestoreHealth
echo.
echo     ------------------------------------------------------------------------
echo     完成。若提示「无法修复」，请查看 CBS.log 或重装对应组件。
echo     ------------------------------------------------------------------------
call :log "执行 SFC + DISM 修复"
call :pause_back
exit /b

rem ============================ 10 网络重置 ============================

:p10
cls
call :title "【10】网络协议栈重置"
echo     修复：能上网但浏览器打不开、DNS 异常、VPN 残留、代理异常。
echo.
echo     [!] 重置后需要重启电脑，部分网络配置需要重新填写。
call :confirm "开始重置"
if not "%CONFIRMED%"=="1" (
    echo.
    echo     已取消。
    call :pause_back
    exit /b
)
echo.
echo     正在重置 Winsock ...
netsh winsock reset
echo.
echo     正在重置 TCP/IP 协议栈 ...
netsh int ip reset
echo.
ipconfig /flushdns >nul 2>&1
echo     [√] DNS 缓存已刷新
echo.
echo     ------------------------------------------------------------------------
echo     完成，请重启电脑后生效。
echo     ------------------------------------------------------------------------
call :log "重置网络协议栈"
call :pause_back
exit /b

rem ============================ 11 磁盘健康 ============================

:p11
cls
call :title "【11】磁盘健康与 SMART 检测"
echo     ---- 物理磁盘 ----
%PS% "try{Get-PhysicalDisk | ForEach-Object {'  '+$_.FriendlyName+'  |  '+$_.MediaType+'  |  健康：'+$_.HealthStatus+'  |  状态：'+$_.OperationalStatus}}catch{'  读取失败'}"
echo.
echo     ---- 卷信息 ----
%PS% "try{Get-Volume | Where-Object {$_.DriveLetter} | ForEach-Object {'  '+$_.DriveLetter+':  '+$_.FileSystemLabel+'  '+$_.FileSystem+'  可用 '+[math]::Round($_.SizeRemaining/1GB,1)+' GB / '+[math]::Round($_.Size/1GB,1)+' GB  '+$_.HealthStatus}}catch{'  读取失败'}"
echo.
echo     ---- SMART 故障预测 ----
%PS% "try{Get-CimInstance -Namespace root\wmi -ClassName MSStorageDriver_FailurePredictStatus -ErrorAction Stop | ForEach-Object {'  预测故障：'+$_.PredictFailure}}catch{'  [!] 无法读取 SMART（虚拟机或 RAID 常见）'}"
echo.
echo       [1] 在线扫描系统盘（chkdsk C: /scan，约 1-5 分钟）
echo       [0] 返回主菜单
echo.
set "_s="
set /p "_s=>> 请选择： "
if "%_s%"=="1" goto :p11_scan
exit /b

:p11_scan
echo.
echo     正在在线扫描系统盘，请稍候 ...
echo.
chkdsk %SystemDrive% /scan
echo.
echo     ------------------------------------------------------------------------
echo     提示：chkdsk /scan 为在线只读检查，不会锁盘，也不会修改文件。
echo     ------------------------------------------------------------------------
call :log "chkdsk /scan"
call :pause_back
exit /b

rem ============================ 12 磁盘优化 ============================

:p12
cls
call :title "【12】磁盘优化与 TRIM"
%PS% "try{$d=Get-PhysicalDisk | Select-Object -First 1;'  介质类型：'+$d.MediaType}catch{''}"
echo     SSD 执行 TRIM，机械硬盘执行碎片整理。
echo.
echo     [!] 机械硬盘碎片整理可能持续数十分钟，SSD 通常只需几秒。
call :confirm "开始优化系统盘"
if not "%CONFIRMED%"=="1" (
    echo.
    echo     已取消。
    call :pause_back
    exit /b
)
echo.
defrag %SystemDrive% /O
echo.
echo     ------------------------------------------------------------------------
echo     完成。可在「驱动器属性 → 工具 → 优化」中查看上次优化时间。
echo     ------------------------------------------------------------------------
call :log "磁盘优化"
call :pause_back
exit /b

rem ============================ 13 电源计划 ============================

:p13
cls
call :title "【13】电源计划调整"
echo     当前电源计划：
%PS% "powercfg /getactivescheme"
echo.
echo       [1] 平衡（默认，省电与性能兼顾）
echo       [2] 高性能（台式机推荐）
echo       [3] 节能（笔记本外出使用）
echo       [4] 卓越性能（隐藏方案，需要手动添加）
echo       [0] 返回主菜单
echo.
set "_s="
set /p "_s=>> 请选择： "
if "%_s%"=="1" powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e
if "%_s%"=="1" goto :p13_done
if "%_s%"=="2" powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
if "%_s%"=="2" goto :p13_done
if "%_s%"=="3" powercfg /setactive a1841308-3541-4fab-bc81-f71556f20b4a
if "%_s%"=="3" goto :p13_done
if "%_s%"=="4" goto :p13_ult
exit /b

:p13_done
echo.
echo     [√] 已切换，当前计划：
%PS% "powercfg /getactivescheme"
call :log "切换电源计划"
call :pause_back
exit /b

:p13_ult
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61
echo.
echo     [√] 已添加并切换到「卓越性能」
call :log "开启卓越性能"
call :pause_back
exit /b

rem ============================ 14 报告 ============================

:p14
cls
call :title "【14】生成系统信息报告"
echo     将把系统、硬件、磁盘、网络、最近补丁与启动项写入一个 txt 文件。
echo.
call :confirm "生成报告到桌面"
if not "%CONFIRMED%"=="1" (
    echo.
    echo     已取消。
    call :pause_back
    exit /b
)
%PS% "Get-Date -Format yyyyMMdd_HHmmss" >"%DATA_DIR%\ts.tmp" 2>nul
set "TS="
set /p TS=<"%DATA_DIR%\ts.tmp"
if not defined TS set "TS=report"
set "DESK=%USERPROFILE%\Desktop"
if not exist "%DESK%" set "DESK=%USERPROFILE%"
set "REP=%DESK%\系统信息报告_%TS%.txt"
echo.
echo     正在采集，请稍候 ...
(
    echo ================== 系统信息报告 ==================
    echo 生成时间：%DATE% %TIME%
    echo 计算机名：%COMPUTERNAME%
    echo 用户名  ：%USERNAME%
    echo.
    echo ------------------ 操作系统 ------------------
    %PS% "Get-CimInstance Win32_OperatingSystem | Format-List Caption,Version,BuildNumber,InstallDate,LastBootUpTime,OSArchitecture"
    echo.
    echo ------------------ 硬件 ------------------
    %PS% "Get-CimInstance Win32_ComputerSystem | Format-List Manufacturer,Model,TotalPhysicalMemory"
    %PS% "Get-CimInstance Win32_Processor | Format-List Name,NumberOfCores,NumberOfLogicalProcessors,MaxClockSpeed"
    %PS% "Get-CimInstance Win32_VideoController | Format-List Name,DriverVersion,VideoModeDescription"
    echo.
    echo ------------------ 磁盘 ------------------
    %PS% "Get-PhysicalDisk | Format-Table FriendlyName,MediaType,HealthStatus,Size -AutoSize"
    %PS% "Get-Volume | Where-Object {$_.DriveLetter} | Format-Table DriveLetter,FileSystemLabel,FileSystem,HealthStatus,SizeRemaining,Size -AutoSize"
    echo.
    echo ------------------ 网络 ------------------
    ipconfig /all
    echo.
    echo ------------------ 最近补丁 ------------------
    %PS% "Get-CimInstance Win32_QuickFixEngineering | Sort-Object InstalledOn -Descending | Select-Object -First 15 | Format-Table HotFixID,Description,InstalledOn -AutoSize"
    echo.
    echo ------------------ 启动项 ------------------
    %PS% "Get-CimInstance Win32_StartupCommand | Format-List Name,Command,Location"
    echo.
    echo ================== 报告结束 ==================
)>"%REP%" 2>&1
echo     [√] 报告已保存：%REP%
call :log "生成系统信息报告"
call :pause_back
exit /b

rem ============================ 15 预装应用 ============================

:p15
cls
call :title "【15】卸载精选预装应用"
echo     只针对微软自带、且大多数人用不到的应用，不涉及第三方软件。
echo.
echo       [1] 卸载精选清单（约 10 个）
echo       [2] 查看已安装的微软应用
echo       [3] 输入包名精确卸载
echo       [0] 返回主菜单
echo.
set "_s="
set /p "_s=>> 请选择： "
if "%_s%"=="1" goto :p15_pre
if "%_s%"=="2" goto :p15_list
if "%_s%"=="3" goto :p15_one
exit /b

:p15_list
echo.
%PS% "Get-AppxPackage | Where-Object {$_.Name -notlike '*Windows*' -or $_.Name -like 'Microsoft.Windows*'} | Sort-Object Name | ForEach-Object {'  '+$_.Name}"
echo.
call :pause_back
exit /b

:p15_pre
echo.
echo     清单：Bing 新闻/天气、获取帮助、入门、纸牌、人脉、反馈中心、
echo           待办、地图、Clipchamp、Teams 消费者版
call :confirm "确认卸载这些应用"
if not "%CONFIRMED%"=="1" goto :p15_no
echo.
%PS% "$a='Microsoft.BingNews','Microsoft.BingWeather','Microsoft.GetHelp','Microsoft.Getstarted','Microsoft.MicrosoftSolitaireCollection','Microsoft.People','Microsoft.WindowsFeedbackHub','Microsoft.Todos','Microsoft.WindowsMaps','Clipchamp.Clipchamp','MicrosoftTeams'; foreach($n in $a){$p=Get-AppxPackage -Name $n -AllUsers -ErrorAction SilentlyContinue; if($p){try{$p|Remove-AppxPackage -AllUsers -ErrorAction Stop; '  [√] '+$n}catch{'  [!] '+$n+' 卸载失败'}}else{'  [-] '+$n+' 未安装'}}"
echo.
echo     ------------------------------------------------------------------------
echo     完成。部分应用会在下次登录时自动重装，可用「设置」中的“应用”复查。
echo     ------------------------------------------------------------------------
call :log "卸载精选预装应用"
call :pause_back
exit /b

:p15_one
echo.
set "_pkg="
set /p "_pkg=>> 输入应用包名（如 Microsoft.BingNews）: "
if not defined _pkg (
    echo     已取消。
    call :pause_back
    exit /b
)
%PS% "$p=Get-AppxPackage -Name '%_pkg%' -AllUsers -ErrorAction SilentlyContinue; if($p){$p|Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue; '  [√] 已卸载 %_pkg%'}else{'  [-] 未找到 %_pkg%'}"
echo.
call :log "卸载应用 %_pkg%"
call :pause_back
exit /b

:p15_no
echo.
echo     已取消。
call :pause_back
exit /b

rem ============================ 16 恢复 ============================

:p16
cls
call :title "【16】一键恢复本工具改动"
echo     将还原：遥测、广告推荐、经典右键、任务栏、非必要服务、电源计划。
echo     不处理：DISM 清理、磁盘优化、已卸载的预装应用（这些不可逆）。
echo.
call :confirm "确认恢复"
if not "%CONFIRMED%"=="1" (
    echo.
    echo     已取消。
    call :pause_back
    exit /b
)
echo.
echo     [1/5] 遥测 ...
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /f >nul 2>&1
call :setsvc DiagTrack auto
call :setsvc dmwappushservice demand
for %%T in (
    "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
    "\Microsoft\Windows\Application Experience\ProgramDataUpdater"
    "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
    "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
    "\Microsoft\Windows\Feedback\Siuf\DmClient"
    "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload"
) do schtasks /change /tn %%T /enable >nul 2>&1
echo     [√] 完成
echo.
echo     [2/5] 广告与推荐 ...
set "CDM=HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
for %%V in (SilentInstalledAppsEnabled SystemPaneSuggestionsEnabled SoftLandingEnabled RotatingLockScreenOverlayEnabled) do reg add "%CDM%" /v %%V /t REG_DWORD /d 1 /f >nul 2>&1
for %%V in (SubscribedContent-338388Enabled SubscribedContent-338389Enabled SubscribedContent-338387Enabled SubscribedContent-353694Enabled SubscribedContent-353696Enabled) do reg add "%CDM%" /v %%V /t REG_DWORD /d 1 /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 1 /f >nul 2>&1
echo     [√] 完成
echo.
echo     [3/5] 右键菜单与任务栏 ...
reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f >nul 2>&1
set "ADV=HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
reg add "%ADV%" /v TaskbarDa /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%ADV%" /v TaskbarMn /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%ADV%" /v ShowTaskViewButton /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%ADV%" /v SearchboxTaskbarMode /t REG_DWORD /d 2 /f >nul 2>&1
echo     [√] 完成
echo.
echo     [4/5] 服务与电源计划 ...
call :setsvc RemoteRegistry disabled
call :setsvc Fax demand
call :setsvc WMPNetworkSvc demand
call :setsvc MapsBroker auto
call :setsvc RetailDemo demand
call :setsvc SysMain auto
call :setsvc WSearch auto
powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e >nul 2>&1
sc start SysMain >nul 2>&1
sc start WSearch >nul 2>&1
echo     [√] 完成
echo.
echo     [5/5] 重启资源管理器 ...
call :refresh_desktop
echo     [√] 完成
echo.
echo     ------------------------------------------------------------------------
echo     本工具所做的可逆改动已全部还原。
echo     ------------------------------------------------------------------------
call :log "一键恢复增强包改动"
call :pause_back
exit /b


rem ============================ 合并恢复 ============================

:restore_all
cls
call :title "【6-1】一键恢复全部设置"
echo     将恢复为系统默认：
echo       1. Windows 更新服务、组策略与计划任务
echo       2. Windows Defender 策略与实时保护
echo       3. 快捷方式小箭头、UAC 图标盾牌
echo       4. 日期格式、时钟秒数
echo       5. 遥测、广告推荐、经典右键菜单、任务栏
echo       6. 非必要服务与电源计划
echo       7. 自动播放、扩展名、快速访问、照片查看器、
echo          Copilot、长路径、内存压缩
echo.
echo     [!] 不会处理：DISM 清理、磁盘优化、已卸载的预装应用、
echo         以及休眠开关（这些属于不可逆或需手动确认的操作）。
echo.
call :confirm "确认恢复全部设置"
if not "%CONFIRMED%"=="1" (
    echo.
    echo     已取消。
    call :pause_back
    exit /b
)
echo.
echo     [1/7] Windows 更新 ...
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /f >nul 2>&1
call :setsvc wuauserv demand
call :setsvc UsoSvc auto
call :setsvc BITS demand
call :setsvc DoSvc demand
call :setsvc WaaSMedicSvc demand
for %%T in (
    "\Microsoft\Windows\WindowsUpdate\Scheduled Start"
    "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan"
    "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task"
    "\Microsoft\Windows\UpdateOrchestrator\Reboot"
    "\Microsoft\Windows\WaaSMedic\PerformRemediation"
    "\Microsoft\Windows\InstallService\ScanForUpdates"
) do schtasks /change /tn %%T /enable >nul 2>&1
sc start wuauserv >nul 2>&1
echo     [√] 完成
echo.
echo     [2/7] Windows Defender ...
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiVirus /f >nul 2>&1
sc config WinDefend start= auto >nul 2>&1
sc start WinDefend >nul 2>&1
%PS% "try{Set-MpPreference -DisableRealtimeMonitoring $false -DisableBehaviorMonitoring $false -DisableIOAVProtection $false -DisableScriptScanning $false -DisableArchiveScanning $false -ErrorAction Stop}catch{}" >nul 2>&1
echo     [√] 完成
echo.
echo     [3/7] 桌面外观 ...
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29 /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 77 /f >nul 2>&1
echo     [√] 完成
echo.
echo     [4/7] 日期与时钟 ...
set "SD=yyyy/M/d"
if exist "%DATA_DIR%\shortdate.bak" set /p SD=<"%DATA_DIR%\shortdate.bak"
reg add "HKCU\Control Panel\International" /v sShortDate /t REG_SZ /d "%SD%" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSecondsInSystemClock /t REG_DWORD /d 0 /f >nul 2>&1
echo     [√] 完成（日期格式 %SD%）
echo.
echo     [5/7] 隐私与外观 ...
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /f >nul 2>&1
call :setsvc DiagTrack auto
call :setsvc dmwappushservice demand
for %%T in (
    "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
    "\Microsoft\Windows\Application Experience\ProgramDataUpdater"
    "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
    "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
    "\Microsoft\Windows\Feedback\Siuf\DmClient"
    "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload"
) do schtasks /change /tn %%T /enable >nul 2>&1
set "CDM=HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
for %%V in (SilentInstalledAppsEnabled SystemPaneSuggestionsEnabled SoftLandingEnabled RotatingLockScreenOverlayEnabled) do reg add "%CDM%" /v %%V /t REG_DWORD /d 1 /f >nul 2>&1
for %%V in (SubscribedContent-338388Enabled SubscribedContent-338389Enabled SubscribedContent-338387Enabled SubscribedContent-353694Enabled SubscribedContent-353696Enabled) do reg add "%CDM%" /v %%V /t REG_DWORD /d 1 /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 1 /f >nul 2>&1
reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f >nul 2>&1
set "ADV=HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
reg add "%ADV%" /v TaskbarDa /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%ADV%" /v TaskbarMn /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%ADV%" /v ShowTaskViewButton /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%ADV%" /v SearchboxTaskbarMode /t REG_DWORD /d 2 /f >nul 2>&1
echo     [√] 完成
echo.
echo     [6/7] 服务与电源计划 ...
call :setsvc RemoteRegistry disabled
call :setsvc Fax demand
call :setsvc WMPNetworkSvc demand
call :setsvc MapsBroker auto
call :setsvc RetailDemo demand
call :setsvc SysMain auto
call :setsvc WSearch auto
powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e >nul 2>&1
sc start SysMain >nul 2>&1
sc start WSearch >nul 2>&1
echo     [√] 完成
echo.
echo     [7/7] 其他优化项 ...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" /v DisableAutoplay /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackDocs /t REG_DWORD /d 1 /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /f >nul 2>&1
reg delete "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowCopilotButton /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v LongPathsEnabled /t REG_DWORD /d 0 /f >nul 2>&1
%PS% "try{Enable-MMAgent -MemoryCompression -ErrorAction Stop}catch{}" >nul 2>&1
echo     [√] 完成
echo     说明：DNS 与保留存储属于按需选项，不在此次恢复范围内。
echo.
echo     ------------------------------------------------------------------------
echo     全部可逆设置已恢复默认，正在重启资源管理器 ...
echo     ------------------------------------------------------------------------
call :refresh_icons
call :log "一键恢复全部设置"
call :pause_back
exit /b

rem ============================ 日志 ============================

:log_view
cls
call :title "【6-2】查看操作日志"
if not exist "%LOG_FILE%" (
    echo     还没有任何操作记录。
    call :pause_back
    exit /b
)
echo     日志文件：%LOG_FILE%
echo.
type "%LOG_FILE%" | more
call :pause_back
exit /b

:log_dir
if not exist "%DATA_DIR%" md "%DATA_DIR%" >nul 2>&1
start "" "%DATA_DIR%"
echo.
echo     [√] 已在资源管理器中打开：%DATA_DIR%
call :pause_back
exit /b

:bye
cls
color 0B
echo.
echo   ==========================================================================
echo.
echo                          感谢使用，再见！
echo.
echo                            作者：Whisper-LiuBaiPeng
echo.
echo   ==========================================================================
color 0F
echo.
ping -n 2 127.0.0.1 >nul 2>&1
exit /b


rem ============================ 新增：清理 ============================

:n1
cls
call :title "【1-3】内存转储与系统日志清理"
echo     将清理：MEMORY.DMP、崩溃转储 Minidump、LiveKernelReports、
echo             CBS 组件日志、DISM 日志、Windows 错误报告缓存。
echo.
echo     [!] 崩溃转储只用于事后分析，删除不影响系统运行。
call :confirm "开始清理"
if not "%CONFIRMED%"=="1" (
    echo.
    echo     已取消。
    call :pause_back
    exit /b
)
echo.
call :getfreemb
set "MB1=%OUT%"
del /f /q "%SystemRoot%\MEMORY.DMP" >nul 2>&1
echo     [√] MEMORY.DMP
del /f /q "%SystemRoot%\Minidump\*.dmp" >nul 2>&1
for /d %%D in ("%SystemRoot%\Minidump\*") do rd /s /q "%%D" >nul 2>&1
echo     [√] Minidump 崩溃转储
del /f /q "%SystemRoot%\LiveKernelReports\*.dmp" >nul 2>&1
echo     [√] LiveKernelReports
del /f /q "%SystemRoot%\Logs\CBS\*.log" >nul 2>&1
echo     [√] CBS 组件日志
del /f /q "%SystemRoot%\Logs\DISM\*.log" >nul 2>&1
echo     [√] DISM 日志
call :cleanitem "%ProgramData%\Microsoft\Windows\WER\ReportQueue" "错误报告缓存"
call :getfreemb
set "MB2=%OUT%"
set /a FREED=MB2-MB1
if %FREED% lss 0 set "FREED=0"
echo.
echo     ------------------------------------------------------------------------
echo     清理完成，释放约 %FREED% MB
echo     ------------------------------------------------------------------------
call :log "清理内存转储与系统日志"
call :pause_back
exit /b

:n2
cls
call :title "【1-4】清理 Windows.old"
if not exist "%SystemDrive%\Windows.old" (
    echo     本机没有 Windows.old，无需清理。
    echo.
    echo     提示：该文件夹只在系统升级或重装后出现，通常 10 天后自动删除。
    call :pause_back
    exit /b
)
echo     该文件夹是升级前的旧系统备份，通常占用 10-30 GB。
echo.
echo     [!] 删除后无法再通过「回退到上一版本」还原旧系统。
echo     [!] 若刚升级不久且系统不稳定，建议先保留几天。
echo.
call :confirm_yes "输入 YES 确认删除"
if not "%CONFIRMED%"=="1" (
    echo.
    echo     已取消。
    call :pause_back
    exit /b
)
echo.
echo     正在获取所有权，可能需要几分钟 ...
takeown /f "%SystemDrive%\Windows.old" /r /d y >nul 2>&1
icacls "%SystemDrive%\Windows.old" /grant *S-1-5-32-544:F /t /c /q >nul 2>&1
rd /s /q "%SystemDrive%\Windows.old" >nul 2>&1
if exist "%SystemDrive%\Windows.old" (
    echo     [!] 未能完全删除，可能仍被占用，请重启后重试
) else (
    echo     [√] 已删除
)
echo.
echo     提示：也可以在「设置 → 系统 → 存储 → 临时文件」中清理该项。
call :log "清理 Windows.old"
call :pause_back
exit /b

:n3
cls
call :title "【1-5】传递优化缓存"
echo     清理 Windows 更新与商店的 P2P 分发缓存，通常几十到几百 MB。
echo.
call :confirm "开始清理"
if not "%CONFIRMED%"=="1" (
    echo.
    echo     已取消。
    call :pause_back
    exit /b
)
echo.
%PS% "try{Delete-DeliveryOptimizationCache -Force -ErrorAction Stop;'     [√] 传递优化缓存已清理'}catch{'     [!] 清理失败：'+$_.Exception.Message}"
echo.
echo     提示：若经常占用带宽，可在「设置 → Windows 更新 → 高级选项 →
echo           传递优化」中关闭「允许从其他电脑下载」。
call :log "清理传递优化缓存"
call :pause_back
exit /b

:n4
cls
call :title "【1-6】保留存储"
echo     系统默认预留约 7 GB 空间用于更新与临时文件，关闭后可释放。
echo.
echo       [1] 查看当前状态
echo       [2] 关闭保留存储（约释放 7 GB）
echo       [3] 开启保留存储（推荐长期保留）
echo       [0] 返回主菜单
echo.
set "_s="
set /p "_s=>> 请选择： "
if "%_s%"=="1" goto :n4_state
if "%_s%"=="2" goto :n4_off
if "%_s%"=="3" goto :n4_on
exit /b

:n4_state
echo.
Dism /Online /Get-ReservedStorageState
echo.
call :pause_back
exit /b

:n4_off
echo.
echo     [!] 关闭后更新需要更多可用空间，建议保证 C 盘有 20 GB 以上空闲。
call :confirm "确认关闭保留存储"
if not "%CONFIRMED%"=="1" goto :n4_no
echo.
Dism /Online /Set-ReservedStorageState /State:Disabled
echo.
echo     提示：部分系统需要重启后生效。
call :log "关闭保留存储"
call :pause_back
exit /b

:n4_on
echo.
Dism /Online /Set-ReservedStorageState /State:Enabled
echo.
call :log "开启保留存储"
call :pause_back
exit /b

:n4_no
echo.
echo     已取消。
call :pause_back
exit /b

:n5
cls
call :title "【1-8】系统还原点管理"
echo     当前还原点：
echo.
%PS% "try{Get-ComputerRestorePoint | Format-Table SequenceNumber,Description,CreationTime -AutoSize}catch{'     系统保护未开启，或没有可用还原点'}"
echo.
echo       [1] 删除最旧的还原点
echo       [2] 删除全部还原点
echo       [3] 现在创建一个还原点
echo       [0] 返回主菜单
echo.
set "_s="
set /p "_s=>> 请选择： "
if "%_s%"=="1" goto :n5_old
if "%_s%"=="2" goto :n5_all
if "%_s%"=="3" call :b16
exit /b

:n5_old
echo.
vssadmin delete shadows /for=%SystemDrive% /oldest /quiet
echo.
echo     [√] 已删除最旧的还原点
call :log "删除最旧还原点"
call :pause_back
exit /b

:n5_all
echo.
echo     [!] 删除后将无法通过系统还原回滚任何改动。
call :confirm_yes "输入 YES 确认删除全部还原点"
if not "%CONFIRMED%"=="1" (
    echo.
    echo     已取消。
    call :pause_back
    exit /b
)
vssadmin delete shadows /for=%SystemDrive% /all /quiet
echo.
echo     [√] 已删除全部还原点
call :log "删除全部还原点"
call :pause_back
exit /b

rem ============================ 新增：系统 ============================

:n6
cls
call :title "【2-8】自动播放开关"
echo     关闭后插入 U 盘、光盘不会再自动弹窗或运行内容。
echo.
echo       [1] 关闭自动播放（推荐）
echo       [2] 开启自动播放
echo       [0] 返回主菜单
echo.
set "_s="
set /p "_s=>> 请选择： "
if "%_s%"=="1" reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" /v DisableAutoplay /t REG_DWORD /d 1 /f >nul 2>&1
if "%_s%"=="1" echo     [√] 自动播放已关闭
if "%_s%"=="2" reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" /v DisableAutoplay /t REG_DWORD /d 0 /f >nul 2>&1
if "%_s%"=="2" echo     [√] 自动播放已开启
if "%_s%"=="0" exit /b
call :log "设置自动播放"
call :pause_back
exit /b

rem ============================ 新增：资源管理器 ============================

:n7
cls
call :title "【3-7】扩展名与隐藏文件"
echo     资源管理器的两个常用开关，改完会重启一次资源管理器。
echo.
echo       [1] 显示文件扩展名（推荐）
echo       [2] 显示隐藏文件
echo       [3] 恢复默认（隐藏扩展名与隐藏文件）
echo       [0] 返回主菜单
echo.
set "_s="
set /p "_s=>> 请选择： "
set "ADV=HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
if "%_s%"=="1" goto :n7_ext
if "%_s%"=="2" goto :n7_hid
if "%_s%"=="3" goto :n7_def
exit /b

:n7_ext
reg add "%ADV%" /v HideFileExt /t REG_DWORD /d 0 /f >nul 2>&1
echo.
echo     [√] 已显示文件扩展名
call :refresh_desktop
call :pause_back
exit /b

:n7_hid
reg add "%ADV%" /v Hidden /t REG_DWORD /d 1 /f >nul 2>&1
echo.
echo     [√] 已显示隐藏文件
call :refresh_desktop
call :pause_back
exit /b

:n7_def
reg add "%ADV%" /v HideFileExt /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%ADV%" /v Hidden /t REG_DWORD /d 2 /f >nul 2>&1
echo.
echo     [√] 已恢复默认设置
call :refresh_desktop
call :pause_back
exit /b

:n8
cls
call :title "【3-8】快速访问与历史记录"
echo     控制资源管理器「快速访问」是否记录最近使用的文件。
echo.
echo       [1] 关闭记录并清空历史
echo       [2] 恢复记录
echo       [0] 返回主菜单
echo.
set "_s="
set /p "_s=>> 请选择： "
if "%_s%"=="1" goto :n8_off
if "%_s%"=="2" goto :n8_on
exit /b

:n8_off
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackDocs /t REG_DWORD /d 0 /f >nul 2>&1
del /f /s /q "%APPDATA%\Microsoft\Windows\Recent\*" >nul 2>&1
echo.
echo     [√] 已关闭最近文件记录，并清空历史
call :refresh_desktop
call :pause_back
exit /b

:n8_on
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackDocs /t REG_DWORD /d 1 /f >nul 2>&1
echo.
echo     [√] 已恢复记录
call :refresh_desktop
call :pause_back
exit /b

rem ============================ 新增：Win11 ============================

:n9
cls
call :title "【4-4】经典照片查看器"
echo     为 Win10/11 注册「Windows 照片查看器」，恢复轻量的看图体验。
echo.
call :confirm "注册经典照片查看器"
if not "%CONFIRMED%"=="1" (
    echo.
    echo     已取消。
    call :pause_back
    exit /b
)
set "PV=HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations"
for %%E in (.jpg .jpeg .png .bmp .gif .tif) do reg add "%PV%" /v %%E /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul 2>&1
echo.
echo     [√] 已注册
echo.
echo     使用方法：右键任意图片 → 打开方式 → 选择其他应用 →
echo               Windows 照片查看器 → 勾选「始终使用此应用」。
call :log "注册经典照片查看器"
call :pause_back
exit /b

:n10
cls
call :title "【4-5】Copilot / Recall"
echo     针对 Windows 11 的 AI 组件开关。
echo.
echo       [1] 关闭 Copilot 按钮（任务栏）
echo       [2] 卸载 Recall 功能（24H2）
echo       [3] 恢复 Copilot
echo       [0] 返回主菜单
echo.
set "_s="
set /p "_s=>> 请选择： "
if "%_s%"=="1" goto :n10_off
if "%_s%"=="2" goto :n10_recall
if "%_s%"=="3" goto :n10_on
exit /b

:n10_off
reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v TurnOffWindowsCopilot /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowCopilotButton /t REG_DWORD /d 0 /f >nul 2>&1
echo.
echo     [√] Copilot 已关闭
call :refresh_desktop
echo     提示：任务栏图标消失需要几秒或重新登录。
call :log "关闭 Copilot"
call :pause_back
exit /b

:n10_recall
Dism /Online /Disable-Feature /FeatureName:Recall /NoRestart >nul 2>&1
if errorlevel 1 (
    echo.
    echo     [-] 当前系统不支持 Recall 功能，无需处理
) else (
    echo.
    echo     [√] Recall 已关闭
)
call :log "关闭 Recall"
call :pause_back
exit /b

:n10_on
reg delete "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowCopilotButton /t REG_DWORD /d 1 /f >nul 2>&1
echo.
echo     [√] Copilot 已恢复
call :refresh_desktop
call :log "恢复 Copilot"
call :pause_back
exit /b

rem ============================ 新增：网络 ============================

:n11
cls
call :title "【5-4】一键设置 DNS"
echo     当前 DNS：
%PS% "try{Get-DnsClientServerAddress -AddressFamily IPv4 | Where-Object {$_.ServerAddresses} | ForEach-Object {'  ['+$_.InterfaceAlias+']  '+($_.ServerAddresses -join ', ')}}catch{'  读取失败'}"
echo.
echo       [1] 阿里 DNS      223.5.5.5   / 223.6.6.6
echo       [2] 腾讯 DNS      119.29.29.29 / 182.254.116.116
echo       [3] 114 DNS       114.114.114.114 / 114.114.115.115
echo       [4] 恢复自动获取
echo       [0] 返回主菜单
echo.
set "_s="
set /p "_s=>> 请选择： "
if "%_s%"=="1" goto :n11_ali
if "%_s%"=="2" goto :n11_tx
if "%_s%"=="3" goto :n11_114
if "%_s%"=="4" goto :n11_auto
exit /b

:n11_ali
%PS% "$a=@('223.5.5.5','223.6.6.6'); Get-NetAdapter | Where-Object {$_.Status -eq 'Up'} | ForEach-Object {Set-DnsClientServerAddress -InterfaceIndex $_.ifIndex -ServerAddresses $a -ErrorAction SilentlyContinue; '     [√] '+$_.Name}"
ipconfig /flushdns >nul 2>&1
echo.
echo     [√] 已切换到阿里 DNS，并刷新缓存
call :log "设置阿里 DNS"
call :pause_back
exit /b

:n11_tx
%PS% "$a=@('119.29.29.29','182.254.116.116'); Get-NetAdapter | Where-Object {$_.Status -eq 'Up'} | ForEach-Object {Set-DnsClientServerAddress -InterfaceIndex $_.ifIndex -ServerAddresses $a -ErrorAction SilentlyContinue; '     [√] '+$_.Name}"
ipconfig /flushdns >nul 2>&1
echo.
echo     [√] 已切换到腾讯 DNS，并刷新缓存
call :log "设置腾讯 DNS"
call :pause_back
exit /b

:n11_114
%PS% "$a=@('114.114.114.114','114.114.115.115'); Get-NetAdapter | Where-Object {$_.Status -eq 'Up'} | ForEach-Object {Set-DnsClientServerAddress -InterfaceIndex $_.ifIndex -ServerAddresses $a -ErrorAction SilentlyContinue; '     [√] '+$_.Name}"
ipconfig /flushdns >nul 2>&1
echo.
echo     [√] 已切换到 114 DNS，并刷新缓存
call :log "设置 114 DNS"
call :pause_back
exit /b

:n11_auto
%PS% "Get-NetAdapter | Where-Object {$_.Status -eq 'Up'} | ForEach-Object {Set-DnsClientServerAddress -InterfaceIndex $_.ifIndex -ResetServerAddresses -ErrorAction SilentlyContinue; '     [√] '+$_.Name+' 已恢复自动'}"
ipconfig /flushdns >nul 2>&1
echo.
echo     [√] 已恢复 DHCP 自动获取 DNS
call :log "恢复自动 DNS"
call :pause_back
exit /b

rem ============================ 新增：修复与硬件 ============================

:n12
cls
call :title "【6-2】重建图标缓存"
echo     修复桌面图标变白、变成空白文档、显示错乱等问题。
echo.
echo     [!] 会重启一次资源管理器，未保存的窗口位置可能被打乱。
call :confirm "开始重建"
if not "%CONFIRMED%"=="1" (
    echo.
    echo     已取消。
    call :pause_back
    exit /b
)
echo.
echo     正在清理图标缓存 ...
call :refresh_icons
echo     [√] 完成，图标已重建
echo     提示：若个别图标仍异常，可注销后重新登录。
call :log "重建图标缓存"
call :pause_back
exit /b

:n13
cls
call :title "【6-6】电池健康报告"
echo     生成 HTML 格式的电池报告，含设计容量、循环次数、续航估算。
echo.
%PS% "Get-Date -Format yyyyMMdd_HHmmss" >"%DATA_DIR%\ts.tmp" 2>nul
set "TS="
set /p TS=<"%DATA_DIR%\ts.tmp"
if not defined TS set "TS=report"
set "DESK=%USERPROFILE%\Desktop"
if not exist "%DESK%" set "DESK=%USERPROFILE%"
set "REP=%DESK%\电池报告_%TS%.html"
powercfg /batteryreport /output "%REP%" >nul 2>&1
if not exist "%REP%" (
    echo     [-] 本机没有检测到电池，或系统不支持该命令
    call :pause_back
    exit /b
)
echo     [√] 已生成：%REP%
echo.
echo     正在用浏览器打开 ...
start "" "%REP%"
call :log "生成电池报告"
call :pause_back
exit /b

:n14
cls
call :title "【7-4】启用长路径支持"
echo     解除 260 字符的路径长度限制，方便开发与深层目录。
echo.
echo       [1] 启用长路径（重启后生效）
echo       [2] 关闭长路径
echo       [0] 返回主菜单
echo.
set "_s="
set /p "_s=>> 请选择： "
if "%_s%"=="1" reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v LongPathsEnabled /t REG_DWORD /d 1 /f >nul 2>&1
if "%_s%"=="1" echo     [√] 已启用，重启后生效
if "%_s%"=="2" reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v LongPathsEnabled /t REG_DWORD /d 0 /f >nul 2>&1
if "%_s%"=="2" echo     [√] 已关闭
if "%_s%"=="0" exit /b
call :log "设置长路径支持"
call :pause_back
exit /b

:n15
cls
call :title "【7-5】内存压缩开关"
echo     Windows 会压缩内存中的冷数据以节省物理内存。
echo     内存充足（16 GB 以上）时可关闭以降低 CPU 占用。
echo.
%PS% "try{'     当前状态：内存压缩='+((Get-MMAgent).MemoryCompression)}catch{'     当前状态：读取失败'}"
echo.
echo       [1] 关闭内存压缩
echo       [2] 开启内存压缩
echo       [0] 返回主菜单
echo.
set "_s="
set /p "_s=>> 请选择： "
if "%_s%"=="1" goto :n15_off
if "%_s%"=="2" goto :n15_on
exit /b

:n15_off
%PS% "try{Disable-MMAgent -MemoryCompression -ErrorAction Stop;'     [√] 已关闭内存压缩'}catch{'     [!] 操作失败：'+$_.Exception.Message}"
call :log "关闭内存压缩"
call :pause_back
exit /b

:n15_on
%PS% "try{Enable-MMAgent -MemoryCompression -ErrorAction Stop;'     [√] 已开启内存压缩'}catch{'     [!] 操作失败：'+$_.Exception.Message}"
call :log "开启内存压缩"
call :pause_back
exit /b

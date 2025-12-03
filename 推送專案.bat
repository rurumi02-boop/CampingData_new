@echo off
chcp 65001 >nul
title 推送 CampingData 到 GitHub
color 0A

echo.
echo ========================================
echo   推送 CampingData 專案到 GitHub
echo ========================================
echo.

REM 檢查是否在正確的目錄
if not exist "manage.py" (
    echo [錯誤] 請在專案根目錄執行此腳本
    echo 當前目錄：%CD%
    pause
    exit /b 1
)

REM 嘗試多個可能的 Git 路徑
set GIT_CMD=
set GIT_PATHS[0]=git
set GIT_PATHS[1]=C:\Program Files\Git\bin\git.exe
set GIT_PATHS[2]=C:\Program Files (x86)\Git\bin\git.exe
set GIT_PATHS[3]=%LOCALAPPDATA%\Programs\Git\bin\git.exe
set GIT_PATHS[4]=%USERPROFILE%\AppData\Local\Programs\Git\bin\git.exe

REM 測試每個路徑
for /L %%i in (0,1,4) do (
    call set "TEST_PATH=%%GIT_PATHS[%%i]%%"
    call "%%TEST_PATH%%" --version >nul 2>&1
    if not errorlevel 1 (
        set GIT_CMD=%%TEST_PATH%%
        goto :found_git
    )
)

echo [錯誤] 未找到 Git！
echo.
echo 可能的原因：
echo 1. Git 未安裝
echo 2. Git 未加入 PATH 環境變數
echo 3. 需要重新啟動命令提示字元
echo.
echo 解決方法：
echo 1. 確認 Git 已安裝
echo 2. 重新啟動命令提示字元（關閉並重新開啟）
echo 3. 或手動執行以下命令（請替換為實際的 Git 路徑）：
echo.
echo    "C:\Program Files\Git\bin\git.exe" init
echo    "C:\Program Files\Git\bin\git.exe" remote add origin https://YOUR_GITHUB_TOKEN_HERE@github.com/rurumi02-boop/CampingData.git
echo    "C:\Program Files\Git\bin\git.exe" add .
echo    "C:\Program Files\Git\bin\git.exe" commit -m "Initial commit: CampingData Django e-commerce project"
echo    "C:\Program Files\Git\bin\git.exe" branch -M main
echo    "C:\Program Files\Git\bin\git.exe" push -u origin main
echo.
pause
exit /b 1

:found_git
echo [✓] 找到 Git：%GIT_CMD%
echo.

REM Token 和倉庫設定
set TOKEN=YOUR_GITHUB_TOKEN_HERE
set USERNAME=rurumi02-boop
set REPO=CampingData

echo [資訊] 遠程倉庫：https://github.com/%USERNAME%/%REPO%
echo.

REM 初始化 Git（如果尚未初始化）
if not exist ".git" (
    echo [步驟 1/6] 初始化 Git 倉庫...
    "%GIT_CMD%" init
    if errorlevel 1 (
        echo [錯誤] 無法初始化 Git 倉庫
        pause
        exit /b 1
    )
    echo [✓] Git 倉庫初始化完成
) else (
    echo [✓] Git 倉庫已存在
)

echo.

REM 設置遠程倉庫
echo [步驟 2/6] 設置遠程倉庫...
"%GIT_CMD%" remote remove origin >nul 2>&1
"%GIT_CMD%" remote add origin https://%TOKEN%@github.com/%USERNAME%/%REPO%.git
if errorlevel 1 (
    "%GIT_CMD%" remote set-url origin https://%TOKEN%@github.com/%USERNAME%/%REPO%.git
)
echo [✓] 遠程倉庫設置完成
echo.

REM 添加所有文件
echo [步驟 3/6] 添加文件到暫存區...
"%GIT_CMD%" add .
if errorlevel 1 (
    echo [錯誤] 無法添加文件
    pause
    exit /b 1
)
echo [✓] 文件已添加到暫存區
echo.

REM 提交更改
echo [步驟 4/6] 提交更改...
"%GIT_CMD%" commit -m "Initial commit: CampingData Django e-commerce project"
if errorlevel 1 (
    echo [警告] 提交時出現問題，可能沒有變更需要提交
    echo 繼續執行推送...
)
echo.

REM 設定主分支
echo [步驟 5/6] 設定主分支...
"%GIT_CMD%" branch -M main
echo [✓] 主分支設定完成
echo.

REM 推送到 GitHub
echo [步驟 6/6] 推送到 GitHub...
echo.
echo ⚠️  如果這是首次推送，可能需要幾秒鐘時間...
echo.
"%GIT_CMD%" push -u origin main

if errorlevel 1 (
    echo.
    echo ========================================
    echo [❌] 推送失敗
    echo ========================================
    echo.
    echo 可能的原因：
    echo 1. Token 無效或已過期
    echo 2. 倉庫不存在或無權限
    echo 3. 網路連接問題
    echo.
    echo 請檢查：
    echo - GitHub 倉庫是否已創建：https://github.com/%USERNAME%/%REPO%
    echo - Token 是否有 'repo' 權限
    echo - 網路連接是否正常
    echo.
    echo 如果推送時要求輸入認證資訊：
    echo   Username: %USERNAME%
    echo   Password: %TOKEN%
    echo.
    pause
    exit /b 1
)

echo.
echo ========================================
echo [✅] 推送成功！
echo ========================================
echo.
echo 您的專案已成功推送到：
echo https://github.com/%USERNAME%/%REPO%
echo.
echo ⚠️  重要安全提醒：
echo    1. Token 已保存在本地 Git 配置中
echo    2. 建議到 GitHub 撤銷此 Token 並生成新的
echo    3. 前往：https://github.com/settings/tokens
echo.
pause



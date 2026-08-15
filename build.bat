@echo off
echo ================================
echo  Gotify Client - Build Script
echo ================================
echo.

echo Cleaning previous builds...
rmdir /s /q bin 2>nul
rmdir /s /q obj 2>nul

echo.
echo Compiling in Release mode...
dotnet build -c Release

if %errorlevel% equ 0 (
    echo.
    echo ================================
    echo Build successful!
    echo ================================
    echo.
    echo Executable located at:
    echo bin\Release\net10.0-windows\GotifyClient.exe
    echo.

    choice /C YN /M "Do you want to publish a self-contained version (no .NET required)"
    if %errorlevel% equ 1 (
        echo.
        echo Publishing self-contained version...
        dotnet publish -c Release -r win-x64 --self-contained true -p:PublishSingleFile=true

        if %errorlevel% equ 0 (
            echo.
            echo ================================
            echo Publish successful!
            echo ================================
            echo.
            echo Self-contained version located at:
            echo bin\Release\net10.0-windows\win-x64\publish\GotifyClient.exe
        )
    )
) else (
    echo.
    echo ================================
    echo Build failed!
    echo ================================
    echo.
    echo Make sure the latest .NET 10 SDK is installed.
    echo Download: https://dotnet.microsoft.com/en-us/download/dotnet/10.0
)

echo.
pause

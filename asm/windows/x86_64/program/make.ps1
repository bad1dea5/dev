Param (
    [Parameter()]
    [string]$Name = "program",
    [Parameter()]
    [switch]$IsDebug = $PSBoundParameters.ContainsKey("Debug"),
    [Parameter()]
    [Alias("Arch")]
    [string]$Architecture = "amd64",
    [Parameter()]
    [switch]$Clean
)

$CFLAGS = ""
$LFLAGS = "/SUBSYSTEM:windows /ENTRY:WinMainCRTStartup"

if($clean) {
    Remove-Item -LiteralPath (Join-Path $PSScriptRoot -ChildPath "bin") -Force -Recurse
    Remove-Item -LiteralPath (Join-Path $PSScriptRoot -ChildPath "obj") -Force -Recurse

    Write-Host "Build files removed" -ForegroundColor Yellow

    exit 0
}

Write-Host "Name          : $Name" -ForegroundColor Yellow
Write-Host "Debug         : $IsDebug" -ForegroundColor Yellow
Write-Host "Architecture  : $Architecture" -ForegroundColor Yellow

function Find-Vsdevcmd {
    $ProgramFilesDir = Split-Path -Parent ${Env:CommonProgramFiles(x86)}
    $VsWhere = Join-Path -Path $ProgramFilesDir -ChildPath "Microsoft Visual Studio\Installer\vswhere.exe"
    $InstallDir = $(& "$VsWhere" "-latest", "-products", "*", "-requires", "Microsoft.VisualStudio.Component.VC.Tools.x86.x64", "-property", "installationPath")
    
    if(-Not $InstallDir) {
        Write-Host "install directory not found" -ForegroundColor Red
        exit -1
    }

    $Vsdevcmd = Join-Path $InstallDir -ChildPath "Common7\Tools\VsDevCmd.bat"

    if(-Not (Test-Path $Vsdevcmd)) {
        Write-Host "vsdevcmd not found" -ForegroundColor Red
        exit -1
    }

    $Vsdevcmd
}

function Set-Environment {
    Param(
        [Parameter()]
        [string]$Vsdevcmd,
        [Parameter(Mandatory)]
        [Alias("Architecture")]
        [string]$Arch
    )

    Write-Host "Initializing environment" -ForegroundColor Green

    & "${Env:COMSPEC}" /s /c "`"$Vsdevcmd`" -arch=$Arch -no_logo && set" | ForEach-Object {
        $lhs, $rhs = $_ -Split "=", 2
        Set-Content Env:\"$lhs" $rhs
    }
}

Set-Environment -Vsdevcmd (Find-Vsdevcmd) -Arch $Architecture

New-Item -Path $PSScriptRoot -Name "bin" -ItemType Directory -Force
New-Item -Path $PSScriptRoot -Name "obj" -ItemType Directory -Force

ml64 /Fo obj\program.obj $CFLAGS.Split(' ') -c "${Name}.asm"
link $LFLAGS.Split(' ') /OUT:bin\${Name}.exe "obj\${Name}.obj"

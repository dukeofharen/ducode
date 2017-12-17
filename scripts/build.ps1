$ErrorActionPreference = 'Stop'

function Assert-Cmd-Ok
{
    if($LASTEXITCODE -ne 0)
    {
        Write-Error "Build not succeeded... See errors"
        Exit -1
    }
}

$sitePath = Join-Path -Path $PSScriptRoot ".."
$htaccessPath = Join-Path -Path $PSScriptRoot "..\.htaccess"
$publicPath = Join-Path -Path $sitePath "public"

$env:HUGO_ENV = "production"
& cmd /c "cd $sitePath && hugo"
Assert-Cmd-Ok

Copy-Item $htaccessPath $publicPath
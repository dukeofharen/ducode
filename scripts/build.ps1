$ErrorActionPreference = 'Stop'

function Assert-Cmd-Ok
{
    if($LASTEXITCODE -ne 0)
    {
        Write-Error "Build not succeeded... See errors"
        Exit -1
    }
}

$env:HUGO_ENV = "production"
& cmd /c "cd .. && hugo --uglyURLs"
Assert-Cmd-Ok
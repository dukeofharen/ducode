$ErrorActionPreference = 'Stop'

function FileTransferred
{
    param($e)
 
    if ($e.Error -eq $Null)
    {
        Write-Host "Upload of $($e.FileName) succeeded"
    }
    else
    {
        Write-Host "Upload of $($e.FileName) failed: $($e.Error)"
    }
 
    if ($e.Chmod -ne $Null)
    {
        if ($e.Chmod.Error -eq $Null)
        {
            Write-Host "Permissions of $($e.Chmod.FileName) set to $($e.Chmod.FilePermissions)"
        }
        else
        {
            Write-Host "Setting permissions of $($e.Chmod.FileName) failed: $($e.Chmod.Error)"
        }
 
    }
    else
    {
        Write-Host "Permissions of $($e.Destination) kept with their defaults"
    }
 
    if ($e.Touch -ne $Null)
    {
        if ($e.Touch.Error -eq $Null)
        {
            Write-Host "Timestamp of $($e.Touch.FileName) set to $($e.Touch.LastWriteTime)"
        }
        else
        {
            Write-Host "Setting timestamp of $($e.Touch.FileName) failed: $($e.Touch.Error)"
        }
 
    }
    else
    {
        # This should never happen during "local to remote" synchronization
        Write-Host "Timestamp of $($e.Destination) kept with its default (current time)"
    }
}

$buildOutputDir = Join-Path -Path $PSScriptRoot "..\public"

$winscpType = "C:\Program Files (x86)\WinSCP\WinSCPnet.dll"
if(!(Test-Path $winscpType))
{
    throw "Path not found $winscpType"
}

if(!(Test-Path $buildOutputDir))
{
    throw "Path not found $buildOutputDir"
}

Add-Type -Path $winscpType

$sessionOptions = New-Object WinSCP.SessionOptions -Property @{
    Protocol = [WinSCP.Protocol]::Ftp
    HostName = $env:ftp_host
    UserName = $env:ftp_username
    Password = $env:ftp_password
}

$session = New-Object WinSCP.Session
try
{
    $session.add_FileTransferred( { FileTransferred($_) } )
    $session.Open($sessionOptions)
    $synchronizationResult = $session.SynchronizeDirectories([WinSCP.SynchronizationMode]::Remote, $env:local_directory, $env:remote_directory, $True, $True)
    $synchronizationResult.Check()
}
finally
{
    $session.Dispose()
}
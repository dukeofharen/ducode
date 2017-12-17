---
title: "New Blog"
date: 2017-12-17T21:58:42+01:00
draft: false
featured_image: "new-blog.jpg"
tags: ["hugo", "static site"]
categories: ["hugo"]
---

Hi,

I've taken up blogging again. In the past I've written a lot of scripts and tutorials and put them online. I always hosted my blog on either WordPress or my own created blogging platform. I never liked both options (WordPress too bloaded / insecure and own blogging platform cost me too much time), so a little while ago I removed my blog. Thank goodness we are in an age where there is a type of blogging platform that is both easy to use, has a small footprint and is used if you value speed: the static site generator. You check in a new post, a build server produces some HTML files and pushes them to your hosting provider.

I've chosen [Hugo](https://gohugo.io/) for my static site needs. Why? Because it is really, really fast with generating my site, it's built with Go (so no extra dependencies like Ruby, Node.js etc.) and it has a huge community.

![Hugo](/hugo-logo.png)

I use [AppVeyor](https://www.appveyor.com/) to build and publish the website. AppVeyor is a build platform (free for open source projects) which uses the Windows platform. I chose AppVeyor, and not for example Travis CI, because I'm a .NET guy and am a little more knowledgeable with Windows than with Linux.

So, how does my website publishing pipeline works?

1. Upload new content to GitHub.
1. AppVeyor responds to the changes and kicks off a new build.
1. The software toolchain (Hugo and WinSCP) is installed.
1. A small PowerShell script starts the Hugo build.
1. If the Hugo build went OK, WinSCP is kicked into action. Because I don't upload to GitHub pages, but have a shared hosting account (I have a reseller account), I want to use FTP to upload my newest blog. WinSCP is callable from PowerShell and has a really nifty "sync" function which mirrors your local changes to a remote FTP (or SSH, SFTP for that matter) server.

```
# Piece of code needed to sync my blog through FTP
$sessionOptions = New-Object WinSCP.SessionOptions -Property @{
    Protocol = [WinSCP.Protocol]::Ftp
    HostName = $env:ftp_host
    UserName = $env:ftp_username
    Password = $env:ftp_password
}

$session = New-Object WinSCP.Session
try
{
    $localDirectory = Join-Path -Path $PSScriptRoot $env:relative_local_directory
    Write-Host "Public directory: $localDirectory"
    $session.add_FileTransferred( { FileTransferred($_) } )
    $session.Open($sessionOptions)
    $synchronizationResult = $session.SynchronizeDirectories([WinSCP.SynchronizationMode]::Remote, $localDirectory, $env:remote_directory, $True, $True)
    $synchronizationResult.Check()
}
finally
{
    $session.Dispose()
}
```

It took me only a few hours to figure out Hugo, how to build it and how to deploy my site using FTP. I don't see myself using a "full" blogging platform in the foreseeable future.

I'm looking forward to posting new scripts, tutorials and other random stuff to my site.

If you're curious on how I made this site, take a look at the [GitHub repository](https://github.com/dukeofharen/ducode).

_Image by [doria150](https://pixabay.com/en/engine-race-car-chrome-horsepower-3009242/)_
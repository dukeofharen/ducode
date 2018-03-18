---
title: "Powershell Complete Clean"
date: 2017-12-17T22:54:33+01:00
draft: false
featured_image: "powershell-clean.png"
tags: ["powershell", ".net"]
categories: ["powershell", ".net"]
---

Hi,

Everybody who works with Visual Studio (no matter which version) has probably, at some point, ran a "Clean solution" on the project, only to discover that nothing was cleaned. In other cases, your code doesn't build for no reason. In this case, it might help to run this little PowerShell oneliner:

```
Get-ChildItem .\ -include bin,obj -Recurse | foreach ($_) { remove-item $_.fullname -Force -Recurse }
```

From the folder this script is executed in, it searches recursively to all folders named `bin` or `obj` and deletes those folders. For me, this fixes the nonsensical build errors in Visual Studio in about 90% of the cases.

_Image by [RyanMcGuire](https://pixabay.com/en/laundry-washing-machines-housewife-413688/)_
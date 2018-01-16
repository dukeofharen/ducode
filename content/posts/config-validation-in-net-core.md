---
title: "Configuration validation in .NET Core"
date: 2018-01-16T20:08:02+01:00
draft: true
tags: [".net core", "c#"]
categories: [".net core"]
---

Hi,

The customer I currently work at has a large and very intricate collection of .NET reusable libraries. One of these libraries contains code to validate and read custom configuration sections in Web.config and App.config files. With the dawn of .NET Core, the "classic" configuration model is replaced by a newer and more modular one. The new .NET Core configuration libraries enable you to use any sort of configuration file (e.g. JSON files, XML files, YAML files etc.) and also simplifies the deserialization of said file to an object.

We needed to develop a .NET Core application, so the old "full .NET" libraries were unusable. The use of the new .NET Core configuration library is a no-brainer, but what about the validation part? Well, .NET already has a complete assembly available for model validation: System.ComponentModel.DataAnnotations. This class contains several validators and attributes that you can use to validate models. This assembly is already used by both the "old" ASP.NET MVC and ASP.NET MVC Core for the validation of posted content. Let's take a look at the following example:

```
public class ConfigurationModel
{
    [Required]
    public string ApplicationName { get; set; }

    [Required]
    [Url]
    public string RootUrl { get; set; }

    [Required]
    [EmailAddress]
    public string AdminEmail { get; set; }
}
```

Like you can see in the code above, all fields are required, RootUrl should be a valid URL and AdminEmail should be a valid email address. Easy, right?

TODO:

- Create sample solution with necessary code
- Pick samples of code, put them in the post and explain
- Header image
- Upload code to GitHub and add URL to article
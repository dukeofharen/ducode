---
title: "Git Submodules"
date: 2019-01-02T22:16:04+01:00
draft: false
featured_image: "headers/git.jpg"
tags: ["git", "scm"]
categories: ["git"]
---

Hi,

I always forget those damn commands for adding and deleting submodules from a GIT repository. I thought it might be wise to put those commands on my website, for future reference.

## Adding submodules

```
git submodule add https://github.com/dukeofharen/Ducode.Essentials
```

## Initializing submodules

If you've already checked out your repository, but haven't pulled the submodules yet, execute the following command.

```
git submodule update --init --recursive
```

## Pull all changes for all submodules

```
git submodule update --remote
```

## Deleting submodules

Source: https://gist.github.com/myusuf3/7f645819ded92bda6677

```
git submodule deinit <path_to_submodule>
git rm <path_to_submodule>
git commit-m "Removed submodule "
rm -rf .git/modules/<path_to_submodule>
```
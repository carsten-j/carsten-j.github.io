---
layout: post
title: Where is .NET Core installed on macOS?
date: '2017-07-05 6:33:00'
---
And exactly what versions are installed?

In a recent  [blog](http://irisclasson.com/2017/06/27/net-core-finding-out-sdk-installed-runtime-and-framework-host-versions/) post [Iris Classon](https://twitter.com/irisclasson) wrote a PowerShell script that lists installed .NET Core SDK, runtime, and Framework Host versions installed on a Windows machine.

I am mostly using my Mac for .NET Core development so it got me thinking about where .NET Core actually is installed on macOS. The answer is

> /usr/local/share/dotnet/

The following script

``` bash
#!/bin/sh
DOTNET="/usr/local/share/dotnet"

if [ -d $DOTNET ] ; then

  printf "\nSDK versions:\n"
  ls -1 $DOTNET/sdk

  printf "\nInstalled runtime versions:\n"
  ls -1 $DOTNET/shared/Microsoft.NETCore.App

  printf "\nFramework host versions:\n"
  ls -1 $DOTNET/host/fxr
fi
```

will list installed .NET Core SDK, runtime, and Framework Host versions installed on a Mac.

If you run `dotnet --info` from the commandline you will see the default SDK version. You can change what SDK version to use by adding a section in the `global.json` file. The `dotnet` executable will look for such a file in the root folder of your project.

The format of the `global.json` looks like

``` json
{
  "sdk": {
    "version": "1.0.4"
  }
}
```
If you now run `dotnet --info` you should see:

``` bash
tmp ➜ dotnet --info
.NET Command Line Tools (1.0.4)

Product Information:
 Version:            1.0.4
```

---
layout: post
title: windows notes
date: 2010-01-03
tag: Iaas
---

# turn on IE proxy
```
@ECHO OFF
ECHO Turn on proxy! please wait...
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
```
# turn off IE proxy
```
@ECHO OFF
ECHO Turn off IE Proxy! please wait...
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f
```

# PSDisableAndClearShadowCopyOnC
 [Link to file](https://github.com/mrdatawolf/PSDisableAndClearShadowCopyOnC/raw/main/ClearCShadowCopyAndDisable.ps1)
Make sure you run this in a powershell console. I have only tested this in PS 7+

## Two ways to run
This will run on C Drive:
.\ClearShadowCopyAndDisable.ps1


This will run on D Drive:
.\ClearShadowCopyAndDisable.ps1 -Drive "D:"

<!-- Purpose:  Runs a set of lower level commands to flush the shadow buildup that can happen-->
<!-- INSTALL_COMMAND: curl -o ClearShadowCopyAndDisable.ps1 https://github.com/mrdatawolf/PSDisableAndClearShadowCopyOnC/raw/main/ClearShadowCopyAndDisable.ps1 -->
<!-- RUN_COMMAND: ClearShadowCopyAndDisable.ps1 -->
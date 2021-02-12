Menu, Tray, Icon, %A_WorkingDir%/icon.ico
SetWorkingDir %A_ScriptDir%
#SingleInstance, Force
#Persistent
#NoEnv

;--------------- CONFIG ------------------------------------------------------------------------------------------------------
; DEVICE NAME (triggers monitor switch)
global DEVICE_NAME := "USB Audio Device"

; PC NAMES
global PC1_NAME := "DESKTOP"
global PC2_NAME := "NEDLAPTOP"

; MONITOR NAMES
global MONITOR1_NAME := "PVJVW4CI15LL"
global MONITOR2_NAME := "VVF203600230"
global MONITOR3_NAME := "PVJVW4CI1E7L"

; INPUTS NUMBERS
global PC1_INPUTS := { (MONITOR1_NAME) : "17", (MONITOR2_NAME) : "15", (MONITOR3_NAME) : "17" }
global PC2_INPUTS := { (MONITOR1_NAME) : "16", (MONITOR2_NAME) : "17", (MONITOR3_NAME) : "16" }

; MISC
CHECK_ON_INTERVAL := true
CHECK_INTERVAL_MS := 5000
;------------------------------------------------------------------------------------------------------------------------------
if (CHECK_ON_INTERVAL)
    SetTimer, RunCheck, %CHECK_INTERVAL_MS%

RunCheck() {
    if (A_ComputerName = PC1_NAME and DeviceIsConnected() = true)
        CheckInputs(PC1_INPUTS)
    else if (A_ComputerName = PC1_NAME and DeviceIsConnected() = false)
        CheckInputs(PC2_INPUTS)
    else if (A_ComputerName = PC2_NAME and DeviceIsConnected() = true)
        CheckInputs(PC1_INPUTS)
    else if (A_ComputerName = PC2_NAME and DeviceIsConnected() = false)
        CheckInputs(PC2_INPUTS)
}

DeviceIsConnected() {
    for device in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_PnPEntity")
        If InStr(device.name, DEVICE_NAME)
            return true

    return false
}

CheckInputs(aInputs) {
    for monitorName,inputNumber in aInputs 
        Run, ControlMyMonitor/ControlMyMonitor.exe /SetValueIfNeeded %monitorName% 60 %inputNumber%
}
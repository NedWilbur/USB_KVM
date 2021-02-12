# USB_KVM
This is a AutoHotKey (AHK) script that will allow you to use a basic USB switch as a full automatic monitor switch.

This script heavily utilizes [ControlMyMonitor](https://www.nirsoft.net/utils/control_my_monitor.html) to switch the inputs programmatically. This script simply adds logic around it.

This is currently written for myself, with two PC's and three monitors. The code can be easily adjusted for more or less PCs and monitors (virtually any number of PC's and monitors)

## How does it work
On a set interval, this script checks if a configured USB device is connected to the machine. If it is, it switches all the monitors to the specified input. If it is not, it switches all monitor's inputs to the other PC's.

## Why
Triple monitor KVM switches are stupid expensive ($100+)

## Requirements
- Windows
- [AutoHotKey](https://www.autohotkey.com/)
- Two machines, connected to the same set of monitors, but each PC plugged into the same set of monitors, but on different inputs
   - Example: PC1 is plugged into the HDMI2 ports on all three monitors, while PC2 is plugged into the DVI ports on all three monitors
- USB Switch with a device with a unique named connected
   - Example: My USB sound card is plugged into my USB Switch. This is listed as `USB Audio Device` in `Device Manager` only on the machine the switch is currently switched to
   - My USB switch (but should work with any): https://www.amazon.com/gp/product/B07XDT6K82

## Config
Below are the various variables that can be changed within the script (open in notepad, notepad++, vscode, et cetera...). Note, getting these values just right can be a bitch, ensure you are copying the correct values from ControlMyMonitor.
| Config Name | Description |
| - | - |
| `DEVICE_NAME` | The name of the USB device to check for. This should be a USB device plugged into the USB switch. This lets the script know if the monitors should be connected to PC1 or PC2. The device name can be found in Window's Device Manager. For example, I used my USB sound card which has the name `USB AUDIO DEVICE`. |
| `PC#_NAME`| Name of PC1 and PC2. This can be retrieved by running `hostname` in command prompt. |
| `MONITOR#_NAME` | Name of the monitor. These can be retrieved from running `ControlMyMonitor.exe` (included). See [ControlMyMonitor](https://www.nirsoft.net/utils/control_my_monitor.html) docs for more information on getting the monitor name (`Command-Line Options` section). |
| `PC#_INPUTS` | The inputs numbers that are used for each monitor. These can be retrieved from running `ControlMyMonitor.exe` (included) and looking at the current value of `60` (Input select)  |
| `CHECK_ON_INTERVAL` | Enables the timer to check if the inputs are on their expected value. If they are not, they will be switched to the correct input. If disabled, it must be manually ran via hotkey (TODO - Not implemented at this time) |
| `CHECK_INTERVAL_MS` | The interval to check if the monitors are connected to the correct machine (in milliseconds) |

## Using
Once configured, run the script (double-click). It will stay running in your system tray. If configured properly, pressing the switch button on your USB switch should trigger it to automatically switch all monitor inputs the the machine the USB device is currently connect to.

It is recommend to run this script on both PC1 and PC2 at the same time but can still work if only running on one. 
It is also recommended to have this run on startup (create a shortcut to the script and place in `shell:startup`

## TODO
- [ ] Trigger on USB connect/disconnect (instead of interval check)
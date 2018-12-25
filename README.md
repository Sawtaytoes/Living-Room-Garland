# Living Room Garland - Smart Home WebServer

## NodeMCU-Tool Config

1. `npx nodemcu-tool init`
2. `npx nodemcu-tool mkfs` // first-time config write

## Example Project Config

1. Create a an `initialize-wifi.lua` file in the project root like so:
```lua
wifi
.setmode(
	(
		wifi
		.STATION
	),
	(
		true
	)
)

wifi
.sta
.config({
	auto = true,
	pwd = 'YOUR_WIFI_PASSWORD',
	save = true,
	ssid = 'YOUR_SSID',
})
```
2. Run `yarn setup`.
3. Delete `initialize-wifi.lua` as Wi-Fi credentials are now stored on the device.

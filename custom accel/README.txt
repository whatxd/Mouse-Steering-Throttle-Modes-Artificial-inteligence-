THIS WAS MADE ENTIRELY USING CHATGPT 🤖🤖🤖

csp 0.2.4

Mouse Steering – Throttle Percentage Modes + Smooth Version

This mod adds 3 throttle modes to Assetto Corsa’s Mouse Steering:
40% – 70% – 100%, switched using Left Shift.

There are two versions:

1️ BaseIA (AC%) – Percentage Modes 🗿

✔ Throttle modes (40/70/100)
✔ Switch mode with Left Shift
✔ Instant throttle response

2️ BaseIA2 (AC%SOFT) – Percentage Modes + Smooth Throttle 🗿

✔ Everything from BaseIA 🤑
✔ Throttle rises smoothly to the selected percentage (better traction control)

Installation!!!!!!!!!! 🙀🙀🙀

Choose the version you want (baseAI or baseAI2) and go to:

Steam/steamapps/common/assettocorsa/extension/lua/mouse-steering/ ← drop here

Now go to Settings>Custom shaders patch>General patch settings and search for "mouse steering tweaks"
Mouse steering tweaks
Enable "use script" and select in "script" AC% or AC%SOFT


How to use? 🤔

Left Shift → cycles between 40 / 70 / 100% (one direction only) 🤓

Customization 🎨 🖼️
How do I change the key for switching modes? 🤔

Line 22:

local shift = ac.isKeyDown(ui.KeyIndex."HERE")

How do I change the throttle percentages? 🤔

Line 10:

local throttleModes = {0.40, 0.70, 1.00}

How do I change the smoothness? 🤔

Line 43:

smoothSpeed = 8

Lower = smoother effect

(translated and almost only written by chatgpt)

if you need help better ask chatgpt honestly
But if you really want ask me (bad idea and i don't even speak English properly)

https://www.reddit.com/user/daanielnoob/

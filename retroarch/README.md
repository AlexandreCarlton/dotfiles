# RetroArch Notes

You can install pre-compiled cores using the interface, or compile ones using
the AUR. They are listed as 'libretro-<core>-git'. I'm not sure if compiling
it leads to better performance; the only advantage seems to be their
installation in /usr/lib/libretro/libretro-*.so, and automatic update through
the AUR.


## Controller woes
I have this configured for a Logitech Dual Action controller. Unfortunately,
connecting this also moves the mouse. To disable this, go to the
[Joystick wiki page](https://wiki.archlinux.org/index.php/Joystick#Disable_Joystick_From_Controlling_Mouse)
and add in the relevant section. It should be fine after that.

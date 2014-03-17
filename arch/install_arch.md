# Alexandre's commands to set up Arch
These are in no way meant to replace the [Wiki](https://wiki.archlinux.org).
They are merely meant to streamline the process of installing Arch for myself, and does not account for any errors that may be encountered.
Alternatively, use [ArchBang](https://wiki.archbang.org).

## Language
Change font so symbols from foreign languages don't appear as blank squares.
```bash
    setfont Lat2-Terminus16
```
## Internet
Check internet access (most likely off):
```bash
    ping -c 3 www.google.com
```
Get the interface name
```bash
    iw dev
```
Bring interface up
```bash
    ip link set <interface> up
```
Verify interface is up (`UP` in ``<BROADCAST,MULTICAST,UP,LOWER_UP>``)
```bash
    ip link show <interface>
```
Connect to network, select the router and enter the password
```bash
    wifi-menu <interface>
```

## Partitioning
Generally your hard drives (that you want to install Arch on) will lie under `dev/sda`. To check which drives correspond to your harddrive :
```bash
    lsblk
```
Format your drive as per this format below. When entering the HEX code for the bios partition, enter `ef02` to make it bootable.
We use cgdisk instead of parted because we can select to write after making changes.
```
    cgdisk /dev/sda

    Part. #     Size            Partition Type          Partition Name
    ------------------------------------------------------------------
     2          1007.0 KiB      BIOS boot partition     bios
     1          200.0 MiB       Linux filesystem        boot
     3          2.0 GiB         Linux filesystem        swap
     4          12.0 GiB        Linux filesystem        var
     5          20.0 GiB        Linux filesystem        root
     6          <rest>          Linux filesystem        home
```
Create file systems.
```bash
    mkfs.ext2 /dev/sda1
    mkfs.ext4 /dev/sda4
    mkfs.ext4 /dev/sda5
    mkfs.ext4 /dev/sda6
```
Turn the swap partition on.
```bash
    mkswap /dev/sda3
    swapon /dev/sda3
```    
Mount the partitions.
```bash
    mount /dev/sda5 /mnt

    mkdir /mnt/boot
    mount /dev/sda1 /mnt/boot

    mkdir /mnt/var
    mount /dev/sda4 /mnt/var

    mkdir /mnt/home
    mount /dev/sda6 /mnt/home
```
<!-- This should be a bigger header.-->
## Installing the base system
Stick your local server at the top of `/etc/pacman.d/mirrorlist`
```
    ##
    ## Arch Linux repository mirrorlist
    ## Sorted by mirror score from mirror status page
    ## Generated on 2014-02-01
    ##

    # Prioritise Australia's server.
    Server = http://mirror.aarnet.edu.au/pub/archlinux/$repo/os/$arch

    ## Score: 0.4, United States
    Server = http://mirror.us.leaseweb.net/archlinux/$repo/os/$arch
    ...
```
Install the base system
```bash
    pacstrap -i /mnt base
```
If the above command failed with `error: failed to commit transaction (invalid or corrupted package)`, run:
```bash
    pacman-key --init && pacman-key --populate archlinux
```
Generate your `fstab` file with labels. The last column should have values `2` for everything except for `root`.
```bash
    genfstab -L -p /mnt >> /mnt/etc/fstab
```
Chroot in to configure
```bash
    arch-chroot /mnt /bin/bash
```

## Locale
Uncomment your desired encoding in `/etc/locale.gen`
```
    # THING
    en_US.UTF-8 UTF-8
    # OTHER THING
```
Generate locals.
```
    locale-gen
```
Create locale conf and export your chosen locale.
```
    echo LANG=en_US.UTF-8 > /etc/locale.conf
    export LANG=en_US.UTF-8
```

## Font
Use the same font used at the beginning of the installation.
```bash
    loadkeys us
    setfont Lat2-Terminus16
```
Set your keymap in `/etc/vconsole.conf`
```
    KEYMAP=us
    FONT=Lat2-Terminus16
```

## Time Zone
Set local time zone
```bash
    ln -s /usr/share/zoneinfo/Australia/Sydney /etc/localtime
```
Set hardware clock uniformly between operating systems.
```bash
    hwclock --systohc --utc
```

## Network
Download packages to connect wirelessly:
```
    pacman -S iw wpa_supplicant
```
Download NetworkManager for a nice, easy-to-use GUI.
```
    pacman -S networkmanager network-manager-gnome
```
Activate NetworkManager on startup (note the case).
```
    systemctl enable NetworkManager.service
```

## Hooks
Append the following hooks in `/etc/mkinitcpio.conf` if `/usr` was allocated its own partition (if you followed this guide then you did).
```
    HOOKS="... usr fsk shutdown"
```
Regenerate the image
```bash
    mkinitcpio -p linux
```

## Bootloader
`grub` is used for its rich feature set.
If you haven't already, make the first partition (of size 1007KiB which `cgdisk` kept free) a GRUB partition.
In `parted`, where `<num>` is the partition number:
```
    set <num> bios_grub on
```
Install grub.
```bash
pacman -S grub
grub-install --target=i386-pc --recheck /dev/sda
```
Generate the config file.
```bash
    grub-mkconfig -o /boot/grub/grub.cfg
```

## Finishing touches
Create your hostname (e.g. `arch`).
```bash
    echo arch > /etc/hostname
```
Set the root password (ideally different to that of your regular login).
```bash
    passwd
```

## Finish the installation
Exit `arch-chroot`
```bash
    exit
```
Unmount the partitions.
```
    umount -R /mnt
```
Restart (make sure to take the USB drive out).
```
    reboot
```

# Post installation
The following takes place after reboot.

# Setup regular user(s).
Create a normal user with the following groups:
- `wheel`: Give `sudo` access
- `storage`: Give removable drive (e.g. USB) access
- `power`: Give power control access
```bash
    useradd -m -g users -G wheel,storage,power -s /bin/bash alexandre
    passwd alexandre
```
Go into the sudoers file and uncomment the following line to give members of `wheel` `sudo` access.
```
    EDITOR=nano visudo
    ------------------
    ## Uncomment to allow members of group wheel to execute any command
    %wheel ALL=(ALL) ALL
```

## Brightness
If the brightness keys don't work, try appending (and setting) `acpi_backlight` to `vendor` in `/etc/default/grub`:
```
    GRUB_CMDLINE_LINUX_DEFAULT="... acpi_backlight=vendor"
```
Regenerate the `GRUB` config file:
```bash
grub-mkconfig -o /boot/grub/grub.cfg
```
Failing that, set `acpi_backlight` to either `Linux` or `!Windows 2012` (and then regenerate the config file).


## Sound
Install `alsa-utils` and run it, turning the master volume up to `100`.
```bash
    pacman -S alsa-utils
    alsamixer
```
If the font looks odd, then you need to dive back into `/etc/mkinitcpio.conf` and insert the `sd-vconsole` hook. Additionally, you must insert a module depending on your graphics card:
 - Intel: `i915`
 - NVidia: `nouveau`
 - AMD: `radeon`
```
    MODULES="... i915"
    ...
    HOOKS="... sd-vconsole"
```
Recompile with
```
    mkinitcpio -p linux
```

## Touchpad (for laptops)
Install relevant drivers
```bash
    pacman -S xf86-input-synaptics
```
Edit the file `/etc/X11/xorg.conf.d/50-synaptics.conf` and set `ClickPad` to `0` to enable 2-finger tap as a right click.
```
Section "InputClass"
        Identifier "touchpad catchall"
        ...
        Option "ClickPad" "0"
        ...
EndSection
```

## GUI
Rather than stick this in  ```packages-official.txt```, we set up the drivers according to the graphics chipset.

Install video driver (depending on graphics card)
```bash
    pacman -S xf86-video-intel
```
Enable 32 bit on 64:
```bash
    pacman -S lib32-intel-dri
```

# Customise bootloader
TODO
plymouth

# Git
To set up extra files that I need, install git and set up ssh keys.
```bash
    pacman -S git
```
Now, as per the original readme:
```bash
    git clone git@github.com:AlexandreCarlton/dotfiles.git ~/.dotfiles
    chmod u+x ~/.dotfiles/setup-dotfiles.sh
    chmod u+x ~/.dotfiles/arch/setup-arch.sh
    ~/.dotfiles/arch/setup-arch.sh
```
This will download other 

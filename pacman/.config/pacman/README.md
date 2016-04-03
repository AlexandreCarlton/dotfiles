# Pacman

Things of note:

 - Our Make flags have "-j$(nproc)" to easily adapt to different machines.
 - Ccache is enabled.
 - Allow gcc to automatically detect and enable safe, architecture-specific
   optimisations.

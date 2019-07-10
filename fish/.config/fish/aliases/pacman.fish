# Ripped from https://github.com/sorin-ionescu/prezto/blob/master/modules/pacman/init.zsh

set _pacman_frontend 'pacman'
set _pacman_sudo 'sudo '

# Pacman.
alias pac "$_pacman_frontend"

# Installs packages from repositories.
alias paci "$_pacman_sudo$_pacman_frontend --sync"

# Installs packages from files.
alias pacI "$_pacman_sudo$_pacman_frontend --upgrade"

# Removes packages and unneeded dependencies.
alias pacx "$_pacman_sudo$_pacman_frontend --remove"

# Removes packages, their configuration, and unneeded dependencies.
alias pacX "$_pacman_sudo$_pacman_frontend --remove --nosave --recursive"

# Displays information about a package from the repositories.
alias pacq "$_pacman_frontend --sync --info"

# Displays information about a package from the local database.
alias pacQ "$_pacman_frontend --query --info"

# Searches for packages in the repositories.
alias pacs "$_pacman_frontend --sync --search"

# Searches for packages in the local database.
alias pacS "$_pacman_frontend --query --search"

# Lists orphan packages.
alias pacman-list-orphans "$_pacman_sudo$_pacman_frontend --query --deps --unrequired"

# Synchronizes the local package database
alias pacu "$_pacman_sudo$_pacman_frontend --sync --refresh"

# Synchronizes the local package database against the repositories then
# upgrades outdated packages.
alias pacU "$_pacman_sudo$_pacman_frontend --sync --refresh --sysupgrade"

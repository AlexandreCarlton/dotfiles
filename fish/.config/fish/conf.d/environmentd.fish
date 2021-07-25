#!/usr/bin/fish

# If environment.d fails to kick in for whatever reason, load it manually.
if ! set -q SYSTEMD_ENVIRONMENTD_LOADED;
  /usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator \
    | while read -d= -l var val
    set -gx $var $val
  end
end

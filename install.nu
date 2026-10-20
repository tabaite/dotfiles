def stow_install [path] {
  try { stow -v --no -t ~/.config $path }
}

def main [] {
  print "usage: \"nu install.nu ( install | uninstall )\""
}

def "main install" [] {
  print "installing nushell dots..."
  stow_install nushell

  print "\ninstalling helix dots..."
  stow_install helix


  print "\ninstalling waybar, sway, fuzzel dots..."
  stow_install fuzzel
  stow_install sway
  stow_install waybar


  print "\ninstalling foot confs..."
  stow_install foot
}


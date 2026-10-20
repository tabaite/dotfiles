def stow_install [name] {
  let path = $"($env.HOME)/.config/($name)"
  mkdir $path
  try { stow -v -d . -t $path $name } catch { |e| print $"Error for ($name): ($e.msg)" }
}

def stow_remove [name] {
  let path = $"($env.HOME)/.config/($name)"
  try { stow -D -v -d . -t $path $name } catch { |e| print $"Error for ($name): ($e.msg)" }
}

def main [] {
  print "usage: \"nu install.nu ( install | uninstall )\""
}

def "main clean" [] {
  rm -rf ~/.config/nushell
  rm -rf ~/.config/helix
  rm -rf ~/.config/fuzzel
  rm -rf ~/.config/sway
  rm -rf ~/.config/waybar
  rm -rf ~/.config/foot
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

def "main uninstall" [] {
  print "installing nushell dots..."
  stow_remove nushell

  print "\ninstalling helix dots..."
  stow_remove helix


  print "\ninstalling waybar, sway, fuzzel dots..."
  stow_remove fuzzel
  stow_remove sway
  stow_remove waybar


  print "\ninstalling foot confs..."
  stow_remove foot
}


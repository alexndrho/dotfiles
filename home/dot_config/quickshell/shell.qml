//@ pragma IconTheme Papirus-Dark
import Quickshell
import qs.modules.bar
import qs.modules.popouts
import qs.modules.wallpaper
import qs.modules.powermenu
import qs.modules.lockscreen

ShellRoot {
  Bar { id: bar }
  PopoutLayer { margins.left: bar.width }
  Wallpaper {}
  Powermenu {}
  Lockscreen {}
}

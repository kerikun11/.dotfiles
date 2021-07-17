#!/bin/sh

# xrandr --current
# xrandr --setmonitor "monitor_name" "width_px"/"width_mm"x"height_px"/"height_mm"+"x_offset_px"+"y_offset_px" "output_name"

# xrandr --delmonitor DP2-1
# xrandr --delmonitor DP2-2
# xrandr --setmonitor DP2-1 2294/574x1440/335+0+0 DP2
# xrandr --setmonitor DP2-2 1146/226x1440/335+2294+0 none

# xrandr --delmonitor DP-1
# xrandr --delmonitor DP-2
# xrandr --setmonitor DP-1 1920/147x2160/165+0+0 eDP1
# xrandr --setmonitor DP-2 1920/147x2160/165+1920+0 none
# xrandr --fb 3840x2161
# xrandr --fb 3840x2160

xrandr --listmonitors

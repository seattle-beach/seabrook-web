module Layout.Theme exposing (..)

import Css exposing (rgb, rgba, Color)

theme : { primary : Color, secondary : Color }
theme =
    { primary = rgb 0 255 120
    , secondary = rgb 120 180 255
    }

lighten_ : Color -> Int -> Color
lighten_ color amount =
    rgba (color.red + amount) (color.green + amount) (color.blue + amount) color.alpha

module Layout.Theme exposing (..)

import Css exposing (..)


theme :
    { primary : Color
    , primaryDark : Color
    , secondary : Color
    }
theme =
    { primary = rgb 121 232 217
    , primaryDark = rgb 43 158 142
    , secondary = rgb 120 180 255
    }


lighten_ : Color -> Int -> Color
lighten_ color amount =
    rgba (color.red + amount) (color.green + amount) (color.blue + amount) color.alpha


constants : { borderRadius : Px }
constants =
    { borderRadius = px 8 }

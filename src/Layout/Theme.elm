module Layout.Theme exposing (..)

import Css exposing (..)
import Color as Mix


theme =
    { primary = lighten_ (hsl 179 0.8 0.27) 1
    , primaryDark = hsl 179 0.8 0.27
    , secondary = hex "94C5CC"

    --, secondary = rgb 120 180 255
    , pivotalTeal = rgb 0 134 116
    , pivotalMint = rgb 0 174 158
    }


lighten_ : Color -> Float -> Color
lighten_ color amount =
    let
        { hue, saturation, lightness, alpha } =
            toHsl color
    in
        hsla hue saturation (lightness * (1 + amount)) alpha


darken_ : Color -> Float -> Color
darken_ color amount =
    let
        { hue, saturation, lightness, alpha } =
            toHsl color
    in
        hsla hue saturation (lightness * (1 - amount)) alpha


toHsl { red, green, blue, alpha } =
    Mix.rgba red green blue alpha
        |> Mix.toHsl
        -- Elm core colors use "standard elm angles", AKA radians. CSS unadorned units are degrees.
        |> \({ hue } as c) -> { c | hue = (hue * 180 / pi) }


constants : { borderRadius : Px }
constants =
    { borderRadius = px 8 }

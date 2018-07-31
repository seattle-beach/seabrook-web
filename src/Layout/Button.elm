module Layout.Button exposing (..)

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css)
import Layout.Theme exposing (..)

button_ : List (Attribute msg) -> List (Html msg) -> Html msg
button_ attributes children =
    let
        custom = [ padding (px 10)
          , outline none
          , backgroundColor theme.primary
          -- TODO: I don't understand types well enough to know why this doesn't work
          -- , border none
          , border zero
          , borderRadius (px 4)
          , hover [ backgroundColor <| lighten_ theme.primary 100 ]
          , active [ backgroundColor theme.primary ]
          ]
    in
        button (css custom :: attributes) children

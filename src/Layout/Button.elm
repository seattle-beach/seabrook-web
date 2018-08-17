module Layout.Button exposing (..)

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css)
import Layout.Theme exposing (..)


button_ : List (Attribute msg) -> List (Html msg) -> Html msg
button_ attributes children =
    let
        custom =
            [ borderRadius constants.borderRadius ]
    in
        buttonNoRadius (css custom :: attributes) children


buttonNoRadius : List (Attribute msg) -> List (Html msg) -> Html msg
buttonNoRadius attributes children =
    let
        custom =
            [ padding (px 10)
            , outline none
            , backgroundColor theme.secondary
            , border zero
            , hover [ backgroundColor <| lighten_ theme.secondary 0.2 ]
            , active [ backgroundColor theme.secondary ]
            ]
    in
        button (css custom :: attributes) children

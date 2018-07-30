module Layout.Nav exposing (..)

import Msgs exposing (Msg)
import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, src)

navHeader : Maybe String -> Html Msg
navHeader maybe =
    let
        title = case maybe of
            Just value -> value
            Nothing -> "Seabrook"
    in
        div
        [ css
            [ backgroundColor theme.primary
            , fontSize (px 36)
            , padding (px 8)
            , marginBottom (px 8)
            ]
        ]
        [ img [ src "/assets/home.svg", css [ height (px 24), margin4 zero (px 16) zero (px 8) ] ] []
        , text title ]

theme : { primary : Color, secondary : Color }
theme =
    { primary = rgb 100 250 120
    , secondary = rgb 120 180 250
    }

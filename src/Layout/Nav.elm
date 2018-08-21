module Layout.Nav exposing (page, navHeader, tapTarget, item)

import Msgs exposing (Msg)
import Css exposing (..)
import Css.Colors exposing (white)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, src, href)
import Layout.Theme exposing (..)


navHeader : Maybe String -> Html msg
navHeader maybe =
    let
        title =
            case maybe of
                Just value ->
                    value

                Nothing ->
                    "Seabrook"
    in
        div
            [ css
                [ backgroundColor white
                , padding (Css.em 0.5)
                , marginBottom (px 16)
                ]
            ]
            [ homeIcon
            , text title
            ]


homeIcon : Html msg
homeIcon =
    a
        [ href "/#" ]
        [ img
            [ src "/home.svg"
            , css
                [ height (px 48)
                , margin4 zero (px 16) zero (px 8)
                ]
            ]
            []
        ]


page : Maybe String -> List (Html msg) -> Html msg
page maybeTitle children =
    div []
        [ navHeader maybeTitle
        , div
            [ css
                [ margin (px 16)
                , marginBottom zero
                ]
            ]
            children
        ]


tapTarget : List (Attribute msg) -> List (Html msg) -> Html msg
tapTarget attributes children =
    css
        [ margin (px 8)
        , hover [ backgroundColor <| lighten_ theme.secondary 0.2 ]
        , active [ backgroundColor theme.secondary ]
        , display inlineBlock
        , borderRadius constants.borderRadius
        ]
        :: attributes
        |> (flip item) children


item : List (Attribute msg) -> List (Html msg) -> Html msg
item attributes children =
    css
        [ padding (px 24)
        , backgroundColor white
        , width (pct 100)
        ]
        :: attributes
        |> (flip div) children

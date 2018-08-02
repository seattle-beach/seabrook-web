module Layout.Nav exposing (page, navHeader, tapTarget)

import Msgs exposing (Msg)
import Css exposing (..)
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
                [ backgroundColor theme.primary
                , fontSize (px 36)
                , padding (px 8)
                , marginBottom (px 8)
                ]
            ]
            [ homeIcon
            , text title
            ]


homeIcon : Html msg
homeIcon =
    a
        [ href "/" ]
        [ img
            [ src "/home.svg"
            , css
                [ height (px 24)
                , margin4 zero (px 16) zero (px 8)
                ]
            ]
            []
        ]


page : Maybe String -> List (Html msg) -> Html msg
page maybeTitle children =
    div []
        [ navHeader maybeTitle
        , div [ css [ margin (px 16) ] ] children
        ]


tapTarget : List (Html msg) -> Html msg
tapTarget children =
    span
        [ css
            [ margin (px 8)
            , padding (px 8)
            , backgroundColor theme.secondary
            , hover [ backgroundColor <| lighten_ theme.secondary 100 ]
            , active [ backgroundColor theme.secondary ]
            , display inlineBlock
            ]
        ]
        children

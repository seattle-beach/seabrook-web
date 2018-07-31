module Layout.Table exposing (..)

import Css exposing (marginTop, px)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css)

table_ : List (Attribute msg) -> List (Html msg) -> Html msg
table_ attributes children =
    let
        custom = [ marginTop (px 16) ]
    in
        table (css custom :: attributes) children

th_ : List (Attribute msg) -> List (Html msg) -> Html msg
th_ attributes children =
    let
        custom = []
    in
        th (css custom :: attributes) children

td_ : List (Attribute msg) -> List (Html msg) -> Html msg
td_ attributes children =
    let
        custom = []
    in
        td (css custom :: attributes) children

tr_ : List (Attribute msg) -> List (Html msg) -> Html msg
tr_ attributes children =
    let
        custom = []
    in
        tr (css custom :: attributes) children

thead_ : List (Attribute msg) -> List (Html msg) -> Html msg
thead_ attributes children =
    let
        custom = []
    in
        thead (css custom :: attributes) children

tbody_ : List (Attribute msg) -> List (Html msg) -> Html msg
tbody_ attributes children =
    let
        custom = []
    in
        tbody (css custom :: attributes) children

module Meetings.Form exposing (..)

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (type_, placeholder, css)
import Html.Styled.Events exposing (onSubmit, onInput)
import Msgs exposing (Msg)
import Layout.Button exposing (..)
import Layout.Theme exposing (constants)


meetingForm : Html Msg
meetingForm =
    form
        [ onSubmit Msgs.DoSubmitMeeting
        , css
            [ displayFlex
            , flexWrap wrap
            , margin (px -8)
            ]
        ]
        [ input
            [ type_ "text"
            , onInput Msgs.OnAddMeetingTitle
            , placeholder "Meeting title"
            , css
                [ borderRadius constants.borderRadius
                , padding (px 8)
                , flex3 (num 2) zero (pct 50)
                , height (Css.rem (7 / 6))
                , margin (px 8)
                ]
            ]
            []
        , input
            [ type_ "date"
            , onInput Msgs.OnAddMeetingDate
            , css
                [ borderRadius constants.borderRadius
                , padding (px 8)
                , height (Css.em (7 / 6))
                , margin (px 8)
                ]
            ]
            []
        , button_
            [ type_ "submit"
            , css [ margin (px 8) ]
            ]
            [ text "Create Meeting" ]
        ]

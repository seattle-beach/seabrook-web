module Meetings.Form exposing (..)

import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (type_, placeholder)
import Html.Styled.Events exposing (onSubmit, onInput)
import Msgs exposing (Msg)
import Layout.Button exposing (..)

meetingForm : Html Msg
meetingForm =
    form [ onSubmit Msgs.DoSubmitMeeting ]
        [ input [ type_ "date", onInput Msgs.OnAddMeetingDate ] []
        , input [ type_ "text", onInput Msgs.OnAddMeetingTitle, placeholder "Meeting title" ] []
        , button_ [ type_ "submit" ] [ text "Create Meeting" ]
        ]

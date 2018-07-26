module Meetings.Form exposing (..)

import Html exposing (..)
import Html.Attributes exposing (type_, placeholder)
import Html.Events exposing (onSubmit, onInput)
import Msgs exposing (Msg)

meetingForm : Html Msg
meetingForm =
    form [ onSubmit Msgs.DoSubmitMeeting ]
        [ input [ type_ "date", onInput Msgs.OnAddMeetingDate ] []
        , input [ type_ "text", onInput Msgs.OnAddMeetingTitle, placeholder "Meeting title" ] []
        , button [ type_ "submit" ] [ text "Create Meeting" ]
        ]

module Meetings.Form exposing (..)

import Html exposing (..)
import Html.Attributes exposing (type_)
import Html.Events exposing (onSubmit, onInput)
import Msgs exposing (Msg)

meetingForm : Html Msg
meetingForm =
    form [ onSubmit Msgs.OnSubmitMeeting ]
        [ input [ type_ "date", onInput Msgs.OnAddMeetingDate ] []
        , input [ type_ "text", onInput Msgs.OnAddMeetingTitle ] []
        , button [ type_ "submit" ] [ text "Create Meeting" ]
        ]

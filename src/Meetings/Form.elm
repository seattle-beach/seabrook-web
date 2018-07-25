module Meetings.Form exposing (..)

import Html exposing (..)
import Html.Attributes exposing (type_)
import Html.Events exposing (onClick, onInput)
import Msgs exposing (Msg)

meetingForm : Html Msg
meetingForm =
    form []
        [ input [ type_ "date", onInput Msgs.OnAddMeetingDate ] []
        , input [ type_ "text", onInput Msgs.OnAddMeetingTitle ] []
        , button [ onClick Msgs.OnSubmitMeeting ] [ text "Submit" ]
        ]

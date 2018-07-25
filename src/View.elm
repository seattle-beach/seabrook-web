module View exposing (..)

import Html exposing (Html, div, text)
import Msgs exposing (Msg)
import Models exposing (..)
import Meetings.List
import Meetings.Detail


view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        MeetingsRoute ->
            Meetings.List.view model.meetings model.showAddMeeting

        MeetingRoute meetingDate ->
            Meetings.Detail.view model.meeting

        NotFoundRoute ->
            notFoundView

notFoundView : Html msg
notFoundView =
    div [] [ text "Not found" ]

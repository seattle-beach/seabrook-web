module View exposing (view)

import Html
import Html.Styled exposing (Html, div, text, toUnstyled)
import Msgs exposing (Msg)
import Models exposing (..)
import Meetings.List
import Meetings.Detail


view : Model -> Html.Html Msg
view model =
    toUnstyled <| styledView model


styledView : Model -> Html Msg
styledView model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        MeetingsRoute ->
            Meetings.List.view model.meetings model.showAddMeeting

        MeetingRoute meetingDate ->
            Meetings.Detail.view model.meeting model.topicForm

        NotFoundRoute ->
            notFoundView


notFoundView : Html msg
notFoundView =
    div [] [ text "Not found" ]

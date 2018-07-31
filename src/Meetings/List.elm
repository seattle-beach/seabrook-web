module Meetings.List exposing (..)

import Css exposing (marginBottom, px, rgba, backgroundColor, marginRight)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href)
import Html.Styled.Events exposing(onClick)
import RemoteData exposing (WebData)
import Msgs exposing (Msg)
import Models exposing (Meeting, MeetingDate)
import Routing exposing (meetingPath)
import Meetings.Form exposing (meetingForm)
import Layout.Nav exposing (..)
import Layout.Button exposing (button_)
import Layout.Table exposing (..)
import Layout.Theme exposing (..)


view : WebData (List Meeting) -> Bool -> Html Msg
view response showAddMeeting =
    page (Just "Meetings")
        [ addMeetingForm showAddMeeting
        , maybeList response
        ]


maybeList : WebData (List Meeting) -> Html Msg
maybeList response =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success meetings ->
            list meetings

        RemoteData.Failure error ->
            text (toString error)

addMeetingForm : Bool -> Html Msg
addMeetingForm showAddMeeting =
    let
        content = if showAddMeeting then
            meetingForm
        else
            button_ [ onClick (Msgs.ShowAddMeetingForm True) ]
                [ text "Add Meeting" ]
    in
        div [ css [ marginBottom (px 16) ] ]
            [ content ]


list : List Meeting -> Html Msg
list meetings =
    let
        meetingRows = meetings
            |> List.sortBy .date
            |> List.reverse
            |> List.map meetingRow
    in
        div [] meetingRows


meetingRow : Meeting -> Html Msg
meetingRow meeting =
    div []
        [ a [ href (meetingPath meeting.date) ]
            [ tapTarget [ viewDate meeting.date, text meeting.title ]
            ]
        ]

viewDate : MeetingDate -> Html Msg
viewDate date =
    span
        [ css
            [ marginRight (px 8) ]
        ]
        [ text date ]

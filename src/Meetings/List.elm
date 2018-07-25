module Meetings.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Html.Events exposing(onClick)
import RemoteData exposing (WebData)
import Msgs exposing (Msg)
import Models exposing (Meeting)
import Routing exposing (meetingPath)
import Meetings.Form exposing (meetingForm)


view : WebData (List Meeting) -> Bool -> Html Msg
view response showAddMeeting =
    div []
        [ nav
        , addMeetingForm showAddMeeting
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

nav : Html Msg
nav =
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2" ] [ text "Meetings" ] ]

addMeetingForm : Bool -> Html Msg
addMeetingForm showAddMeeting =
    if showAddMeeting then
        div []
            [ meetingForm ]
    else
        button [ onClick (Msgs.ShowAddMeetingForm True) ]
            [ text "Add Meeting" ]


list : List Meeting -> Html Msg
list meetings =
    let
        meetingRows = meetings
            |> List.sortBy .date
            |> List.reverse
            |> List.map meetingRow
    in
        div [ class "p2" ]
            [ table []
                [ thead []
                    [ tr []
                        [ th [] [ text "Date" ]
                        , th [] [ text "Title" ]
                        , th [] [ text "Topics" ]
                        , th [] []
                        ]
                    ] , tbody [] meetingRows
                ]
            ]


meetingRow : Meeting -> Html Msg
meetingRow meeting =
    tr []
        [ td [] [ text meeting.date ]
        , td [] [ text meeting.title ]
        , td [] [ text (toString (List.length meeting.topics) ) ]
        , td [] [ meetingLink meeting ]
        ]

meetingLink : Meeting -> Html Msg
meetingLink meeting =
    a [ href (meetingPath meeting.date), class "button" ]
        [ button [] [text "view topics"] ]

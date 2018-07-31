module Meetings.List exposing (..)

import Css exposing (marginTop, px)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href)
import Html.Styled.Events exposing(onClick)
import RemoteData exposing (WebData)
import Msgs exposing (Msg)
import Models exposing (Meeting)
import Routing exposing (meetingPath)
import Meetings.Form exposing (meetingForm)
import Layout.Nav exposing (..)
import Layout.Button exposing (button_)


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
    if showAddMeeting then
        div []
            [ meetingForm ]
    else
        button_ [ onClick (Msgs.ShowAddMeetingForm True) ]
            [ text "Add Meeting" ]


list : List Meeting -> Html Msg
list meetings =
    let
        meetingRows = meetings
            |> List.sortBy .date
            |> List.reverse
            |> List.map meetingRow
    in
        div []
            [ table [ css [ marginTop (px 16) ] ]
                [ thead []
                    [ tr []
                        [ th [] [ text "Date" ]
                        , th [] [ text "Title" ]
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
        , td [] [ meetingLink meeting ]
        ]

meetingLink : Meeting -> Html Msg
meetingLink meeting =
    a [ href (meetingPath meeting.date) ]
        [ button_ [] [text "view topics"] ]

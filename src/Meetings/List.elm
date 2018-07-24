module Meetings.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import RemoteData exposing (WebData)
import Msgs exposing (Msg)
import Models exposing (Meeting)


view : WebData (List Meeting) -> Html Msg
view response =
    div []
        [ nav
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


list : List Meeting -> Html Msg
list meetings =
    div [ class "p2" ]
        [ table []
            [ thead []
                [ tr []
                    [ th [] [ text "Date" ]
                    , th [] [ text "Title" ]
                    , th [] [ text "Topics" ]
                    ]
                ] , tbody [] (List.map meetingRow meetings)
            ]
        ]


meetingRow : Meeting -> Html Msg
meetingRow meeting =
    tr []
        [ td [] [ text meeting.date ]
        , td [] [ text meeting.title ]
        , td [] [ text (toString (List.length meeting.topics) ) ]
        ]

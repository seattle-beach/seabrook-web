module Meetings.Detail exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import RemoteData exposing (WebData)
import Msgs exposing (Msg)
import Models exposing (Meeting, Topic)


view : WebData Meeting -> Html Msg
view response =
    div []
        [ nav
        , maybeMeeting response
        ]


maybeMeeting : WebData Meeting -> Html Msg
maybeMeeting response =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success meeting ->
            show meeting

        RemoteData.Failure error ->
            text (toString error)

nav : Html Msg
nav =
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2" ] [ text "Meeting Detail" ] ]


show : Meeting -> Html Msg
show meeting =
    div [ class "p2" ]
        [ text (String.join " " [ meeting.date, "-", meeting.title ])
        , table []
            [ thead []
                [ tr []
                    [ th [] [ text "Topic" ]
                    , th [] [ text "Votes" ]
                    , th [] []
                    ]
                ] , tbody [] (List.map topicRow meeting.topics)
            ]
        ]


topicRow : Topic -> Html Msg
topicRow topic =
    tr []
        [ td [] [ text topic.content ]
        , td [] [ text (toString topic.votes) ]
        , td [] [ text "placeholder for voting button" ]
        ]

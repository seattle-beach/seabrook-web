module Meetings.Detail exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, type_)
import Html.Events exposing (onSubmit, onInput)
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


newTopicForm : Meeting -> Html Msg
newTopicForm meeting =
    form [ onSubmit (Msgs.DoSubmitTopic meeting.date) ]
        [ input [ type_ "text", onInput Msgs.OnAddTopicContent ] []
        , button [ type_ "submit" ] [ text "Add Topic" ]
        ]


show : Meeting -> Html Msg
show meeting =
    div [ class "p2" ]
        [ text (String.join " " [ meeting.date, "-", meeting.title ])
        , newTopicForm meeting
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
        , td [] [ button [] [ text "+1" ] ]
        ]

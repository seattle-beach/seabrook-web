module Meetings.Detail exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, type_, placeholder, value)
import Html.Events exposing (onSubmit, onInput)
import RemoteData exposing (WebData)
import Msgs exposing (Msg)
import Models exposing (Meeting, Topic, TopicForm)


view : WebData Meeting -> TopicForm -> Html Msg
view response formData =
    div []
        [ nav
        , maybeMeeting response formData
        ]


maybeMeeting : WebData Meeting -> TopicForm -> Html Msg
maybeMeeting response formData =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success meeting ->
            show meeting formData

        RemoteData.Failure error ->
            text (toString error)

nav : Html Msg
nav =
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2" ] [ text "Meeting Detail" ] ]


newTopicForm : Meeting -> TopicForm -> Html Msg
newTopicForm meeting formData =
    form [ onSubmit (Msgs.DoSubmitTopic meeting.date) ]
        [ inputField formData
        , button [ type_ "submit" ] [ text "Add Topic" ]
        ]

inputField : TopicForm -> Html Msg
inputField formData =
    input [ type_ "text"
        , onInput Msgs.OnAddTopicContent
        , placeholder "Topic"
        , value formData.content
        ]
        []


show : Meeting -> TopicForm -> Html Msg
show meeting formData =
    div [ class "p2" ]
        [ text (String.join " " [ meeting.date, "-", meeting.title ])
        , newTopicForm meeting formData
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

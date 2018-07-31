module Meetings.Detail exposing (..)

import Css exposing (marginTop, px)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, type_, placeholder, value)
import Html.Styled.Events exposing (onSubmit, onInput, onClick)
import RemoteData exposing (WebData)
import Msgs exposing (Msg)
import Models exposing (Meeting, Topic, TopicForm, MeetingDate)
import Layout.Nav exposing (..)
import Layout.Button exposing (..)
import Layout.Table exposing (..)


view : WebData Meeting -> TopicForm -> Html Msg
view response formData =
    case response of
        RemoteData.NotAsked ->
            page Nothing [ text "" ]

        RemoteData.Loading ->
            page Nothing [ text "Loading..." ]

        RemoteData.Success meeting ->
            page (Just (String.join " " [ meeting.date, meeting.title ])) [ show meeting formData ]

        RemoteData.Failure error ->
            page Nothing [ text (toString error) ]


newTopicForm : Meeting -> TopicForm -> Html Msg
newTopicForm meeting formData =
    form [ onSubmit (Msgs.DoSubmitTopic meeting.date) ]
        [ inputField formData
        , button_ [ type_ "submit" ] [ text "Add Topic" ]
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
    div []
        [ newTopicForm meeting formData
        , table_ []
            [ tbody_ [] (topicRows meeting)
            ]
        ]

topicRows : Meeting -> (List (Html Msg))
topicRows meeting =
    meeting.topics
        |> List.sortBy .votes
        |> List.reverse
        |> List.map (topicRow meeting.date)

topicRow : MeetingDate -> Topic -> Html Msg
topicRow meetingDate topic =
    tr_ []
        [ td_ [] [ text topic.content ]
        , td_ [] [ text (toString topic.votes) ]
        , td_ [] [ button_ [ onClick (Msgs.OnTopicVote meetingDate topic.id) ] [ text "+1" ] ]
        ]

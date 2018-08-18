module Meetings.Detail exposing (..)

import Css exposing (..)
import Css.Colors exposing (white)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, type_, placeholder, value, src)
import Html.Styled.Events exposing (onSubmit, onInput, onClick)
import RemoteData exposing (WebData)
import Msgs exposing (Msg)
import Models exposing (Meeting, Topic, TopicId, TopicForm, MeetingDate)
import Layout.Nav exposing (..)
import Layout.Theme exposing (..)
import Layout.Button exposing (..)


view : WebData Meeting -> TopicForm -> Maybe TopicId -> Html Msg
view response formData editingTopic =
    case response of
        RemoteData.NotAsked ->
            page Nothing [ text "" ]

        RemoteData.Loading ->
            page Nothing [ text "Loading..." ]

        RemoteData.Success meeting ->
            page (Just (String.join " " [ meeting.date, meeting.title ])) [ show meeting formData editingTopic ]

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
    input
        [ type_ "text"
        , onInput Msgs.OnAddTopicContent
        , placeholder "Topic"
        , value formData.content
        ]
        []


show : Meeting -> TopicForm -> Maybe TopicId -> Html Msg
show meeting formData editingTopic =
    div [ css [ displayFlex, flexDirection column ] ]
        [ newTopicForm meeting formData
        , div [] (topicRows meeting editingTopic)
        ]


topicRows : Meeting -> Maybe TopicId -> List (Html Msg)
topicRows meeting editingTopic =
    meeting.topics
        |> List.sortBy .id
        |> List.reverse
        |> List.sortBy .votes
        |> List.reverse
        |> List.map (topicRow meeting.date editingTopic)


topicRow : MeetingDate -> Maybe TopicId -> Topic -> Html Msg
topicRow meetingDate editingTopic topic =
    case editingTopic of
        Just editingTopicId ->
            if topic.id == editingTopicId then
                text "TODO"
            else
                displayTopic meetingDate topic

        Nothing ->
            displayTopic meetingDate topic


displayTopic : MeetingDate -> Topic -> Html Msg
displayTopic meetingDate topic =
    div
        [ css
            [ margin (px 16)
            , borderRadius constants.borderRadius
            , displayFlex
            , alignItems stretch
            , flexDirection row
            ]
        ]
        [ voteButton meetingDate topic
        , item
            []
            [ text topic.content ]
        , editButton meetingDate topic
        ]


voteButton : MeetingDate -> Topic -> Html Msg
voteButton meetingDate topic =
    buttonNoRadius
        [ onClick (Msgs.OnTopicVote meetingDate topic.id)
        , css
            [ fontSize (pct 125)
            , paddingLeft (px 16)
            , minWidth (px 100)
            , borderRadius4 constants.borderRadius zero zero constants.borderRadius
            ]
        ]
        [ text "+"
        , span
            [ css
                [ verticalAlign Css.sub
                , fontSize (pct 50)
                ]
            ]
            [ text (toString topic.votes) ]
        ]


editButton : MeetingDate -> Topic -> Html Msg
editButton meetingDate topic =
    buttonNoRadius
        [ onClick (Msgs.ShowEditTopicForm topic.id)
        , css
            [ fontSize (pct 125)
            , paddingLeft (px 16)
            , minWidth (px 100)
            , borderRadius4 zero constants.borderRadius constants.borderRadius zero
            ]
        ]
        [ img
            [ src "/pencil.svg"
            , css [ height (px 48) ]
            ]
            []
        ]

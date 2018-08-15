module Meetings.Detail exposing (..)

import Css exposing (..)
import Css.Colors exposing (white)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, type_, placeholder, value)
import Html.Styled.Events exposing (onSubmit, onInput, onClick)
import RemoteData exposing (WebData)
import Msgs exposing (Msg)
import Models exposing (Meeting, Topic, TopicForm, MeetingDate)
import Layout.Nav exposing (..)
import Layout.Theme exposing (..)
import Layout.Button exposing (..)


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
    input
        [ type_ "text"
        , onInput Msgs.OnAddTopicContent
        , placeholder "Topic"
        , value formData.content
        ]
        []


show : Meeting -> TopicForm -> Html Msg
show meeting formData =
    div [ css [ displayFlex, flexDirection column ] ]
        [ newTopicForm meeting formData
        , div [] (topicRows meeting)
        ]


topicRows : Meeting -> List (Html Msg)
topicRows meeting =
    meeting.topics
        |> List.sortBy .id
        |> List.reverse
        |> List.sortBy .votes
        |> List.reverse
        |> List.map (topicRow meeting.date)


topicRow : MeetingDate -> Topic -> Html Msg
topicRow meetingDate topic =
    let
        voteButton =
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
    in
        div
            [ css
                [ margin (px 16)
                , borderRadius constants.borderRadius
                , displayFlex
                , alignItems stretch
                , flexDirection row
                ]
            ]
            [ voteButton
            , div
                [ css
                    [ padding (px 24)
                    , backgroundColor white
                    , width (pct 100)
                    , borderRadius4 zero constants.borderRadius constants.borderRadius zero
                    ]
                ]
                [ text topic.content ]
            ]

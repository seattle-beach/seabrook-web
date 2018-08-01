module Commands exposing (fetchMeetings, fetchMeeting, postMeeting, postTopic, voteTopic)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Json.Encode exposing (object, string, Value, encode)
import Msgs exposing (Msg)
import Models exposing (..)
import RemoteData
import Flags exposing (Flags)


fetchMeetings : Flags -> Cmd Msg
fetchMeetings flags =
    Http.get (flags.apiUri ++ "/meetings") meetingsDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchMeetings


fetchMeeting : Flags -> MeetingDate -> Cmd Msg
fetchMeeting flags meetingDate =
    Http.get (flags.apiUri ++ "/meetings/" ++ meetingDate) meetingDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchMeeting


postMeeting : Flags -> MeetingForm -> Cmd Msg
postMeeting flags meetingForm =
    Http.post (flags.apiUri ++ "/meetings/" ++ meetingForm.date)
        (Http.jsonBody <| meetingEncoder meetingForm)
        meetingDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnPostMeeting


postTopic : Flags -> MeetingDate -> TopicForm -> Cmd Msg
postTopic flags date topicForm =
    Http.post (flags.apiUri ++ "/meetings/" ++ date ++ "/topics")
        (Http.jsonBody <| topicEncoder topicForm)
        meetingDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchMeeting


voteTopic : Flags -> MeetingDate -> TopicId -> Cmd Msg
voteTopic flags date topicId =
    Http.post (flags.apiUri ++ "/meetings/" ++ date ++ "/topics/" ++ (toString topicId))
        Http.emptyBody
        meetingDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchMeeting


topicEncoder : TopicForm -> Value
topicEncoder topic =
    object
        [ ( "content", string topic.content ) ]

meetingEncoder : MeetingForm -> Value
meetingEncoder meeting =
    object
        [ ( "title", string meeting.title ) ]


meetingsDecoder : Decode.Decoder (List Meeting)
meetingsDecoder =
    Decode.list meetingDecoder


meetingDecoder : Decode.Decoder Meeting
meetingDecoder =
    decode Meeting
        |> required "date" Decode.string
        |> required "title" Decode.string
        |> required "topics" topicsDecoder


topicsDecoder : Decode.Decoder (List Topic)
topicsDecoder =
    Decode.list topicDecoder


topicDecoder : Decode.Decoder Topic
topicDecoder =
    decode Topic
        |> required "id" Decode.int
        |> required "content" Decode.string
        |> required "votes" Decode.int

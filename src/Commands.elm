module Commands exposing (fetchMeetings, fetchMeeting, postMeeting, postTopic)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Json.Encode exposing (object, string, Value, encode)
import Msgs exposing (Msg)
import Models exposing (..)
import RemoteData


fetchMeetings : Cmd Msg
fetchMeetings =
    Http.get (baseUrl ++ "/meetings") meetingsDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchMeetings


fetchMeeting : MeetingDate -> Cmd Msg
fetchMeeting meetingDate =
    Http.get (baseUrl ++ "/meetings/" ++ meetingDate) meetingDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchMeeting


postMeeting : MeetingForm -> Cmd Msg
postMeeting meetingForm =
    Http.post (baseUrl ++ "/meetings/" ++ meetingForm.date)
        (Http.jsonBody <| meetingEncoder meetingForm)
        meetingDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnPostMeeting


postTopic : MeetingDate -> TopicForm -> Cmd Msg
postTopic date topicForm =
    Http.post (baseUrl ++ "/meetings/" ++ date ++ "/topics")
        (Http.jsonBody <| topicEncoder topicForm)
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


baseUrl : String
baseUrl =
    "http://localhost:9292"


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

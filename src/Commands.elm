module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Msgs exposing (Msg)
import Models exposing (MeetingDate, Meeting)
import RemoteData


fetchMeetings : Cmd Msg
fetchMeetings =
    Http.get fetchMeetingsUrl meetingsDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchMeetings


fetchMeetingsUrl : String
fetchMeetingsUrl =
    "http://localhost:9292/meetings"


meetingsDecoder : Decode.Decoder (List Meeting)
meetingsDecoder =
    Decode.list meetingDecoder


meetingDecoder : Decode.Decoder Meeting
meetingDecoder =
    decode Meeting
        |> required "date" Decode.string
        |> required "title" Decode.string
        |> required "level" Decode.int
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

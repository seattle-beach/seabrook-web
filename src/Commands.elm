module Commands exposing (fetchMeetings, fetchMeeting)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Msgs exposing (Msg)
import Models exposing (MeetingDate, Meeting, Topic)
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

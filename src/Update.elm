module Update exposing (..)

import Msgs exposing (Msg)
import Models exposing (Model, Route(..))
import Commands exposing (..)
import Routing exposing (parseLocation)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnFetchMeetings response ->
            -- on the 'model' record, update the field 'meetings' with value 'response'
            ( { model | meetings = response }, Cmd.none )
        Msgs.OnFetchMeeting response ->
            ( { model | meeting = response }, Cmd.none )
        Msgs.OnLocationChange location ->
            let
                newRoute = parseLocation location
                command = commandFor newRoute
            in
                ( { model | route = newRoute }, command )


commandFor : Route -> Cmd Msg
commandFor route =
    case route of
        MeetingRoute meetingDate ->
            fetchMeeting meetingDate

        MeetingsRoute ->
            fetchMeetings

        _ ->
            Cmd.none



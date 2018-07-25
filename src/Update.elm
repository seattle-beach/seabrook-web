module Update exposing (..)

import Msgs exposing (Msg)
import Models exposing (Model, Route(..))
import Commands exposing (..)
import Routing exposing (parseLocation)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnFetchMeetings response ->
            ( { model | meetings = response }, Cmd.none )

        Msgs.OnFetchMeeting response ->
            ( { model | meeting = response }, Cmd.none )

        Msgs.OnSubmitMeeting ->
            -- TODO
            ( model, Cmd.none )

        Msgs.OnAddMeetingDate date ->
            ( model.meetingForm
                |> Models.setDate date
                |> Models.setForm model
            , Cmd.none )

        Msgs.OnAddMeetingTitle title ->
            ( model.meetingForm
                |> Models.setTitle title
                |> Models.setForm model
            , Cmd.none )

        Msgs.ShowAddMeetingForm shouldShow ->
            ( { model | showAddMeeting = shouldShow }, Cmd.none )

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

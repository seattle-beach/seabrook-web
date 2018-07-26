module Update exposing (..)

import Msgs exposing (Msg)
import Models exposing (Model, Route(..))
import Commands exposing (..)
import Routing exposing (parseLocation)
import RemoteData


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnFetchMeetings response ->
            ( { model | meetings = response, showAddMeeting = False }, Cmd.none )

        Msgs.OnFetchMeeting response ->
            let
                emptyForm = Models.setContent "" model.topicForm
            in
              ( { model | meeting = response, topicForm = emptyForm }, Cmd.none )

        Msgs.DoSubmitMeeting ->
            ( model, postMeeting model.meetingForm )

        Msgs.DoSubmitTopic date ->
            ( model, postTopic date model.topicForm )

        Msgs.OnAddTopicContent content ->
            ( model.topicForm
                |> Models.setContent content
                |> Models.setTopicForm model
            , Cmd.none )

        Msgs.OnPostMeeting response ->
            case response of
                RemoteData.Success meeting ->
                    ( model, fetchMeetings )

                _ ->
                    ( model, Cmd.none )

        Msgs.OnAddMeetingDate date ->
            ( model.meetingForm
                |> Models.setDate date
                |> Models.setMeetingForm model
            , Cmd.none )

        Msgs.OnAddMeetingTitle title ->
            ( model.meetingForm
                |> Models.setTitle title
                |> Models.setMeetingForm model
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

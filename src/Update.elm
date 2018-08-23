module Update exposing (..)

import Msgs exposing (Msg)
import Models exposing (..)
import Commands exposing (..)
import Routing exposing (parseLocation)
import RemoteData
import Flags exposing (Flags)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnFetchMeetings response ->
            ( { model
                | meetings = response
                , showAddMeeting = False
                , meetingForm = emptyMeetingForm
              }
            , Cmd.none
            )

        Msgs.OnFetchMeeting response ->
            ( { model
                | meeting = response
                , topicForm = emptyTopicForm
              }
            , Cmd.none
            )

        Msgs.DoSubmitMeeting ->
            ( model, postMeeting model.flags model.meetingForm )

        Msgs.DoSubmitTopic date ->
            ( model, postTopic model.flags date model.topicForm )

        Msgs.OnAddTopicContent content ->
            ( model.topicForm
                |> Models.setContent content
                |> Models.setTopicForm model
            , Cmd.none
            )

        Msgs.OnTopicVote date topicId ->
            ( model, voteTopic model.flags date topicId )

        Msgs.OnPostMeeting response ->
            case response of
                RemoteData.Success meeting ->
                    ( model, fetchMeetings model.flags )

                _ ->
                    ( model, Cmd.none )

        Msgs.OnAddMeetingDate date ->
            ( model.meetingForm
                |> Models.setDate date
                |> Models.setMeetingForm model
            , Cmd.none
            )

        Msgs.OnAddMeetingTitle title ->
            ( model.meetingForm
                |> Models.setTitle title
                |> Models.setMeetingForm model
            , Cmd.none
            )

        Msgs.ShowAddMeetingForm shouldShow ->
            ( { model | showAddMeeting = shouldShow }, Cmd.none )

        Msgs.ShowEditTopicForm topicId ->
            ( { model | showEditTopic = Just topicId }, Cmd.none )

        Msgs.OnLocationChange location ->
            let
                newRoute =
                    parseLocation location

                command =
                    commandFor newRoute
            in
                ( { model | route = newRoute }, command model.flags )


commandFor : Route -> (Flags -> Cmd Msg)
commandFor route =
    case route of
        MeetingRoute meetingDate ->
            meetingDate |> flip fetchMeeting

        MeetingsRoute ->
            fetchMeetings

        _ ->
            \_ -> Cmd.none

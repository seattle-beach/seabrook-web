module Main exposing (..)

import Commands exposing (fetchMeetings, fetchMeeting)
import Models exposing (Model, initialModel, Route(..))
import Msgs exposing (Msg)
import Navigation exposing (Location)
import Routing
import Update exposing (update)
import View exposing (view)


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute = Routing.parseLocation location
    in
        case currentRoute of
            --MeetingRoute meetingDate ->
                --( initialModel currentRoute, fetchMeeting meetingDate )

            _ ->
                ( initialModel currentRoute, fetchMeetings )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


-- MAIN

main : Program Never Model Msg
main =
    Navigation.program Msgs.OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

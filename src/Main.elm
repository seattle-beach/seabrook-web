module Main exposing (..)

import Commands exposing (fetchMeetings, fetchMeeting)
import Models exposing (Model, initialModel, Route(..))
import Msgs exposing (Msg)
import Navigation exposing (Location)
import Routing
import Update exposing (..)
import View exposing (view)


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute = Routing.parseLocation location
        command = commandFor currentRoute
    in
        ( initialModel currentRoute, command )


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

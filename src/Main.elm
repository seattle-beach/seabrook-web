module Main exposing (..)

import Models exposing (Model, initialModel, Route(..))
import Msgs exposing (Msg)
import Navigation exposing (Location)
import Routing
import Update exposing (..)
import View exposing (view)
import Flags exposing (..)


init : Flags -> Location -> ( Model, Cmd Msg )
init flags location =
    let
        currentRoute =
            Routing.parseLocation location

        command =
            commandFor currentRoute <| flags
    in
        ( initialModel flags currentRoute, command )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program Flags Model Msg
main =
    Navigation.programWithFlags Msgs.OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

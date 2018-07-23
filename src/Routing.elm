module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (MeetingDate, Route(..))
import UrlParser exposing (..)


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map MeetingsRoute top
        , map MeetingRoute (s "players" </> string)
        , map MeetingsRoute (s "players")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute

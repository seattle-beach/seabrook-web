module Models exposing (..)

import RemoteData exposing (WebData)


type alias Model =
    { meetings : WebData (List Meeting)
    , meeting : WebData Meeting
    , route : Route
    }


initialModel : Route -> Model
initialModel route =
    { meetings = RemoteData.Loading
    , meeting = RemoteData.Loading
    , route = route
    }


type alias MeetingDate = String

type alias TopicId = Int


type alias Meeting =
    { date : String
    , title : String
    , topics: (List Topic)
    }


type alias Topic =
    { id : Int
    , content : String
    , votes : Int
    }


type Route
    = MeetingsRoute
    | MeetingRoute MeetingDate
    | NotFoundRoute

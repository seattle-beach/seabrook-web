module Models exposing (..)

import RemoteData exposing (WebData)


type alias Model =
    { meetings : WebData (List Meeting)
    }


initialModel : Model
initialMode =
    { meetings = RemoteData.Loading
    }


type alias MeetingDate =
    String


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

module Models exposing (..)

import RemoteData exposing (WebData)


type alias Model =
    { meetings : WebData (List Meeting)
    , meeting : WebData Meeting
    , showAddMeeting : Bool
    , meetingForm : MeetingForm
    , route : Route
    }


type alias MeetingForm =
    { date : MeetingDate
    , title : String
    }

setDate : MeetingDate -> MeetingForm -> MeetingForm
setDate date meetingForm =
    {meetingForm | date = date}

setTitle : String -> MeetingForm -> MeetingForm
setTitle title meetingForm =
    {meetingForm | title = title}

setForm : Model -> MeetingForm -> Model
setForm model meetingForm =
    {model | meetingForm = meetingForm}

initialModel : Route -> Model
initialModel route =
    { meetings = RemoteData.Loading
    , meeting = RemoteData.Loading
    , showAddMeeting = False
    , meetingForm = { date = "", title = "" }
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

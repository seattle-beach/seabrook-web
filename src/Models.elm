module Models exposing (..)

import RemoteData exposing (WebData)
import Flags exposing (Flags)


type alias Model =
    { meetings : WebData (List Meeting)
    , meeting : WebData Meeting
    , showAddMeeting : Bool
    , showEditTopic : Maybe TopicId
    , meetingForm : MeetingForm
    , topicForm : TopicForm
    , flags : Flags
    , route : Route
    }


type alias MeetingForm =
    { date : MeetingDate
    , title : String
    }


type alias TopicForm =
    { content : String
    }


setContent : String -> TopicForm -> TopicForm
setContent content topicForm =
    { topicForm | content = content }


setTopicForm : Model -> TopicForm -> Model
setTopicForm model topicForm =
    { model | topicForm = topicForm }


setDate : MeetingDate -> MeetingForm -> MeetingForm
setDate date meetingForm =
    { meetingForm | date = date }


setTitle : String -> MeetingForm -> MeetingForm
setTitle title meetingForm =
    { meetingForm | title = title }


setMeetingForm : Model -> MeetingForm -> Model
setMeetingForm model meetingForm =
    { model | meetingForm = meetingForm }


emptyMeetingForm : MeetingForm
emptyMeetingForm =
    { date = "", title = "" }


emptyTopicForm : TopicForm
emptyTopicForm =
    { content = "" }


initialModel : Flags -> Route -> Model
initialModel flags route =
    { meetings = RemoteData.Loading
    , meeting = RemoteData.Loading
    , showAddMeeting = False
    , showEditTopic = Nothing
    , meetingForm = emptyMeetingForm
    , topicForm = emptyTopicForm
    , flags = flags
    , route = route
    }


type alias MeetingDate =
    String


type alias TopicId =
    Int


type alias Meeting =
    { date : String
    , title : String
    , topics : List Topic
    }


type alias Topic =
    { id : TopicId
    , content : String
    , votes : Int
    }


type Route
    = MeetingsRoute
    | MeetingRoute MeetingDate
    | NotFoundRoute

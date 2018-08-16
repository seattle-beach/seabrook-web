module Msgs exposing (..)

import Models exposing (Meeting, MeetingDate, TopicId)
import Navigation exposing (Location)
import RemoteData exposing (WebData)


-- should we move network-related mesages to their own type?
-- and user interaction to its own type?


type Msg
    = OnFetchMeetings (WebData (List Meeting))
    | OnFetchMeeting (WebData Meeting)
    | ShowAddMeetingForm Bool
    | ShowEditTopicForm TopicId
    | DoSubmitMeeting
    | OnPostMeeting (WebData Meeting)
    | OnAddMeetingDate MeetingDate
    | OnAddMeetingTitle String
    | DoSubmitTopic MeetingDate
    | OnAddTopicContent String
    | OnTopicVote MeetingDate TopicId
    | OnLocationChange Location

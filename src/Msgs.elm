module Msgs exposing (..)

import Models exposing (Meeting, MeetingDate)
import Navigation exposing (Location)
import RemoteData exposing (WebData)

-- should we move network-related mesages to their own type?
-- and user interaction to its own type?
type Msg
    = OnFetchMeetings (WebData (List Meeting))
    | OnFetchMeeting (WebData Meeting)
    | ShowAddMeetingForm Bool
    | OnSubmitMeeting
    | OnAddMeetingDate MeetingDate
    | OnAddMeetingTitle String
    | OnLocationChange Location

module Msgs exposing (..)

import Models exposing (Meeting)
import Navigation exposing (Location)
import RemoteData exposing (WebData)


type Msg
    = OnFetchMeetings (WebData (List Meeting))
    | OnFetchMeeting (WebData Meeting)
    | OnLocationChange Location

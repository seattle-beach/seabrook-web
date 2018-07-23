module Msgs exposing (..)

import Models exposing (Meeting)
import RemoteData exposing (WebData)


type Msg
    = OnFetchMeetings (WebData (List Meeting))

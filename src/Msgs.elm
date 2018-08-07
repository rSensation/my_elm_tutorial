module Msgs exposing (Msg(..))

import Http
import Navigation exposing (Location)
import RemoteData exposing (WebData)
import Dom

import Models exposing (Player, PlayerId)

type Msg
    = OnFetchPlayers (WebData (List Player))

    | OnLocationChange Location
    | ChangeLocation String

    | ChangeLevel Player Int
    | OnLevelChanged (Result Http.Error Player)
    
    | DeletePlayer PlayerId
    | OnPlayerDelete (Result Http.Error PlayerId)

    | ShowConfirmationModal PlayerId
    | HideConfirmationModal

    | OnCreateInputChange String
    | CreatePlayer
    | OnPlayerCreate (Result Http.Error Player)

    | StartEditPlayerName String
    | CancelEditPlayerName
    | OnEditPlayerNameInputChange String
    | ChangeName Player String
    | OnNameChanged (Result Http.Error Player)
    
    | OnFocus (Result Dom.Error ())

    | RemoveError Int
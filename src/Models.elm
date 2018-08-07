module Models exposing 
    (PlayerId
    , Player
    , Route(..)
    , ConfirmationModalStatus(..)
    , EditPlayerNameStatus(..)
    , Model
    , initialModel)

import RemoteData exposing (WebData)

type alias PlayerId =
    String

type alias Player =
    { id : PlayerId
    , name : String
    , level : Int
    }

type Route
    = PlayersRoute
    | PlayerRoute PlayerId
    | NotFoundRoute

type ConfirmationModalStatus
    = Hidden
    | Shown PlayerId

type EditPlayerNameStatus
    = NoEdit
    | Edit String

type alias Model =
    { players : WebData (List Player)
    , route : Route
    , confirmationModalStatus : ConfirmationModalStatus
    , newPlayerName : String
    , editPlayerNameStatus : EditPlayerNameStatus
    , errors : List String
    }

initialModel : Route -> Model
initialModel route =
    { players = RemoteData.Loading
    , route = route
    , confirmationModalStatus = Hidden
    , newPlayerName = ""
    , editPlayerNameStatus = NoEdit
    , errors = []
    }

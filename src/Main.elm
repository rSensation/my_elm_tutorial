module Main exposing (main)

import Navigation exposing (Location)

import Models exposing (Model, initialModel)
import Msgs exposing (Msg(OnLocationChange))
import Updates.Update exposing (update)
import View exposing (view)
import Commands.HttpCommands as HttpCommands
import Routing

init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location
    in
        ( initialModel currentRoute, HttpCommands.fetchPlayersCmd )

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

main : Program Never Model Msg
main =
    Navigation.program OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
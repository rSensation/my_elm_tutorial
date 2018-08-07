module Updates.Helpers exposing (updatePlayer, deletePlayerById, addPlayer, errorParser)

import Http
import RemoteData exposing (WebData)

import Models exposing (Model, Player, PlayerId)

updatePlayer : WebData (List Player) -> Player -> WebData (List Player)
updatePlayer players updatedPlayer =
    let
        pick currentPlayer =
            if updatedPlayer.id == currentPlayer.id then
                updatedPlayer
            else
                currentPlayer
        
        updatePlayerList players =
            List.map pick players
    in
        RemoteData.map updatePlayerList players

deletePlayerById : WebData (List Player) -> PlayerId -> WebData (List Player)
deletePlayerById players playerId =
    let
        notDeleted player =
            player.id /= playerId

        removeById players =
            List.filter notDeleted players
    in
        RemoteData.map removeById players


addPlayer : WebData (List Player) -> Player -> WebData (List Player)
addPlayer players newPlayer =
    let
        addPlayer players =
            players ++ [newPlayer]
    in
        RemoteData.map addPlayer players

errorParser : Http.Error -> String
errorParser err =
    case err of
        Http.BadUrl url ->
            "Wrong url."
        Http.Timeout ->
            "Timeout."
        Http.NetworkError ->
            "Network error. Check your connection."
        Http.BadPayload msg resp ->
            msg
        Http.BadStatus response ->
            toString response.status.code ++ " " ++ response.status.message

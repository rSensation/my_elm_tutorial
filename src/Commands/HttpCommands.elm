module Commands.HttpCommands exposing (fetchPlayersCmd, savePlayerCmd, deletePlayerCmd, createPlayerCmd)

import Http
import RemoteData
import String.Extra exposing (isBlank)

import Models exposing (PlayerId, Player)
import Msgs exposing (Msg(OnFetchPlayers, OnPlayerDelete, OnPlayerCreate))
import Commands.HttpHelpers exposing (playersUrl, playerUrl, playersDecoder, playerDecoder, playerEncoder, savePlayerEncoder)

fetchPlayersCmd : Cmd Msg
fetchPlayersCmd =
    Http.get playersUrl playersDecoder
        |> RemoteData.sendRequest
        |> Cmd.map OnFetchPlayers

savePlayerRequest : Player -> Http.Request Player
savePlayerRequest player =
    Http.request
        { body = playerEncoder player |> Http.jsonBody
        , expect = Http.expectJson playerDecoder
        , headers = []
        , method = "PATCH"
        , timeout = Nothing
        , url = playerUrl "-1" --replace -1 with playerId
        , withCredentials = False
        }

savePlayerCmd : Player -> (Result Http.Error Player -> Msg) -> Cmd Msg
savePlayerCmd player message =
    savePlayerRequest player
        |> Http.send message

deletePlayerRequest : PlayerId -> Http.Request String
deletePlayerRequest playerId =
    Http.request
        { body = Http.emptyBody 
        , expect = Http.expectStringResponse (\response -> Ok playerId )
        , headers = []
        , method = "DELETE"
        , timeout = Nothing
        , url = playerUrl "-1" -- replace -1 with playerId
        , withCredentials = False
        }

deletePlayerCmd : PlayerId -> Cmd Msg
deletePlayerCmd playerId =
    deletePlayerRequest playerId
        |> Http.send OnPlayerDelete

validateAndCreatePlayer : String -> Result String Player
validateAndCreatePlayer playerName =
    if isBlank playerName then
        Err "Player's name can't be empty."
    else
        Ok (Player "" playerName 1)

createPlayerRequest : Player -> Http.Request Player
createPlayerRequest player =
    Http.request
        { body = savePlayerEncoder player |> Http.jsonBody 
        , expect = Http.expectJson playerDecoder 
        , headers = []
        , method = "POST"
        , timeout = Nothing
        , url = playersUrl ++ "asdad" --remove asdad after testing
        , withCredentials = False
        }

createPlayerCmd : String -> Cmd Msg
createPlayerCmd playerName =
    case (validateAndCreatePlayer playerName) of
        Ok player ->
            createPlayerRequest player
                |> Http.send OnPlayerCreate
        Err error -> Cmd.none
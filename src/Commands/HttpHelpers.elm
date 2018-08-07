module Commands.HttpHelpers exposing (..)

import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (decode, required)
import Json.Encode as Encode

import Models exposing (PlayerId, Player)

playersUrl : String
playersUrl =
    "http://localhost:4000/players"

playerUrl : PlayerId -> String
playerUrl id =
    playersUrl ++ "/" ++ id

playersDecoder : Decoder (List Player)
playersDecoder =
    Decode.list playerDecoder

playerDecoder : Decoder Player
playerDecoder =
    decode Player
        |> required "id" Decode.string
        |> required "name" Decode.string
        |> required "level" Decode.int

playerEncoder : Player -> Encode.Value
playerEncoder player =
    Encode.object
        [ ( "id", Encode.string player.id )
        , ( "name", Encode.string player.name )
        , ( "level", Encode.int player.level )
        ]

savePlayerEncoder : Player -> Encode.Value
savePlayerEncoder player =
    Encode.object
        [ ( "name", Encode.string player.name )
        , ( "level", Encode.int player.level )
        ]
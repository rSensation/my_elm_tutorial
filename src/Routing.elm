module Routing exposing (playerPath, playersPath, parseLocation)

import Navigation exposing (Location)
import UrlParser exposing (..)

import Models exposing (PlayerId, Route(..))

playersPath : String
playersPath = 
    "/players"

playerPath : PlayerId -> String
playerPath id =
    playersPath ++ "/" ++ id

matchers : Parser (Route -> a) a
matchers =
    UrlParser.oneOf
        [ UrlParser.map PlayersRoute top
        , UrlParser.map PlayerRoute (s "players" </> string)
        , UrlParser.map PlayersRoute (s "players")
        ]

parseLocation : Location -> Route
parseLocation location =
    case (UrlParser.parsePath matchers location) of
        Just route ->
            route
        Nothing ->
            NotFoundRoute
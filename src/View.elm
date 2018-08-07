module View exposing (view)

import RemoteData

import Html exposing (Html, div, text)
import Models exposing (Model, PlayerId, Route(..))
import Msgs exposing (Msg)
import Views.Common.Errors exposing (errors)
import Views.Header as Header
import Views.EditPage as EditPage
import Views.PlayersPage as PlayersPage

view : Model -> Html Msg
view model =
    div []
        [ Header.view model
        , content model
        , errors model.errors
        ]

content : Model -> Html Msg
content model =
    case model.route of
        PlayersRoute ->
            PlayersPage.view model
        PlayerRoute id ->
            playerEditPage model id
        NotFoundRoute ->
            notFoundView

playerEditPage : Model -> PlayerId -> Html Msg
playerEditPage model playerId =
    case model.players of
        RemoteData.Success players ->
            let
                maybePlayer =
                    players
                        |> List.filter (\player -> player.id == playerId)
                        |> List.head
            in
                case maybePlayer of
                    Just player ->
                        EditPage.view player model.editPlayerNameStatus
                    Nothing ->
                        notFoundView
        RemoteData.NotAsked ->
            text ""
        RemoteData.Loading ->
            text "Loading..."
        RemoteData.Failure error ->
            text (toString error)

notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found" ]
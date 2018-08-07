module Views.PlayersPage exposing (view)

import Html exposing (Html, div, text)
import RemoteData exposing (WebData)

import Models exposing (Model, Player, PlayerId)
import Msgs exposing (Msg(ChangeLocation, ShowConfirmationModal))
import Views.PlayersTable as PlayersTable
import Views.PlayerDeletionModal as PlayerDeletionModal
import Views.PlayerCreationForm as PlayerCreationForm

view : Model -> Html Msg
view model =
    div []
        [ maybeList model.players
        , PlayerDeletionModal.view model.confirmationModalStatus
        , PlayerCreationForm.view
        ]

maybeList : WebData (List Player) -> Html Msg
maybeList response =
    case response of
        RemoteData.Success players ->
            PlayersTable.view players
        RemoteData.NotAsked ->
            text ""
        RemoteData.Loading ->
            text "Loading..."
        RemoteData.Failure error ->
            text (toString error)
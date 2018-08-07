module Views.PlayerDeletionModal exposing (view)

import Html exposing (Html, text)

import Models exposing (ConfirmationModalStatus(..), PlayerId)
import Msgs exposing (Msg(DeletePlayer, HideConfirmationModal))
import Views.Common.Modal exposing (modal)
import Views.Common.Btn exposing (btn)

view : ConfirmationModalStatus -> Html Msg
view confirmationModalStatus =
    case confirmationModalStatus of
        Shown playerId ->
            modal
                { title = "Are you sure?"
                , buttons = [ yesBtn playerId, noBtn ]
                }
        Hidden ->
            text ""

noBtn : Html Msg
noBtn =
    btn 
    { message = HideConfirmationModal
    , btnClass = ""
    , content = [ text "No" ]
    , disabled = False
    }

yesBtn : PlayerId -> Html Msg
yesBtn playerId =
    btn
        { message = DeletePlayer playerId
        , btnClass = ""
        , content = [ text "Yes" ]
        , disabled = False
        }
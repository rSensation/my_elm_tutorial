module Views.EditPlayerNameForm exposing (view, nameInputId)

import Html exposing (Html, div, input)
import Html.Attributes exposing (class, value, id)
import Html.Events exposing (onInput)
import String.Extra exposing (isBlank)

import Models exposing (Player)
import Msgs exposing (Msg(OnEditPlayerNameInputChange, CancelEditPlayerName, ChangeName))
import Views.Common.Btn exposing (btnDefault)

view : Player -> String -> Html Msg
view player newName =
    div [ class "edit-name-form flex max-width-1" ] 
        [ nameInput newName
        , div [ class "flex-none h6" ]
            [ saveBtn player newName
            , cancelBtn
            ]
        ]

nameInputId : String
nameInputId =
    "edit-name-input"

nameInput : String -> Html Msg
nameInput newName =
    input
        [ class "input"
        , value newName
        , id nameInputId
        , onInput OnEditPlayerNameInputChange
        ] []

validateNewName : String -> String -> Bool
validateNewName oldName newName =
    oldName /= newName && not (isBlank newName)

saveBtn : Player -> String -> Html Msg
saveBtn player newName =
    let
        disabled = not (validateNewName player.name newName)
    in
        btnDefault (ChangeName player newName) "Save" disabled

cancelBtn : Html Msg
cancelBtn =
    btnDefault CancelEditPlayerName "Cancel" False

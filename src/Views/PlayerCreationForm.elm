module Views.PlayerCreationForm exposing (view)

import Html exposing (Html, div, input, text)
import Html.Attributes exposing (placeholder, class)
import Html.Events exposing (onInput)

import Msgs exposing (Msg(OnCreateInputChange, CreatePlayer))
import Views.Common.Btn exposing (btnDefault)

view : Html Msg
view =
    div [ class "create-form flex items-baseline pl2" ]
        [ input
            [ class "input"
            , placeholder "Add new player"
            , onInput OnCreateInputChange
            ] []
        , createBtn
        ]

createBtn : Html Msg
createBtn =
    btnDefault CreatePlayer "Add" False
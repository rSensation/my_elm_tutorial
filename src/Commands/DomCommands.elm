module Commands.DomCommands exposing (focusOnEditPlayerNameInput)

import Dom
import Task

import Msgs exposing (Msg(OnFocus))
import Views.EditPlayerNameForm exposing (nameInputId)

focusCmd : String -> Cmd Msg
focusCmd elementId =
    Dom.focus elementId
        |> Task.attempt OnFocus

focusOnEditPlayerNameInput : Cmd Msg
focusOnEditPlayerNameInput =
    focusCmd nameInputId
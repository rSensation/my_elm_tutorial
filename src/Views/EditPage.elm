module Views.EditPage exposing (view)

import Html exposing (Html, div, text, span, h1)
import Html.Attributes exposing (class)

import Models exposing (Player, EditPlayerNameStatus(..))
import Msgs exposing (Msg(ChangeLevel, StartEditPlayerName))

import Views.EditPlayerNameForm as EditPlayerNameForm
import Views.Common.LinkBtn exposing (linkBtn)

view : Player -> EditPlayerNameStatus -> Html Msg
view player editNameStatus =
    div [] [ form player editNameStatus ]

form : Player -> EditPlayerNameStatus -> Html Msg
form player editNameStatus =
    div [ class "m3" ]
        [ formTitle player editNameStatus
        , formLevel player
        ]

formTitle : Player -> EditPlayerNameStatus -> Html Msg
formTitle player editNameStatus =
    case editNameStatus of
        NoEdit ->
            h1 [] 
                [ text player.name
                , editBtn player.name
                ]
        Edit playerName ->
            EditPlayerNameForm.view player playerName

formLevel : Player -> Html Msg
formLevel player =
    div [ class "clearfix py1"]
        [ div [ class "col col-5" ] [ text "Level" ]
        , div [ class "col col-7" ]
            [ span [ class "h2 bold" ] [ text (toString player.level) ]
            , btnLevelDecrease player
            , btnLevelIncrease player
            ]
        ]

btnLevelDecrease : Player -> Html Msg
btnLevelDecrease player =
    changeLevelBtn player -1 "fa-minus-circle"

btnLevelIncrease : Player -> Html Msg
btnLevelIncrease player =
    changeLevelBtn player 1 "fa-plus-circle"

changeLevelBtn : Player -> Int -> String -> Html Msg
changeLevelBtn player increment iconClass =
    linkBtn 
        { message = ChangeLevel player increment
        , btnClass = "mr1 h2 align-baseline"
        , iconClass = "fa " ++ iconClass
        }

editBtn : String -> Html Msg
editBtn playerName =
    linkBtn
        { message = StartEditPlayerName playerName
        , btnClass = "h2 align-top"
        , iconClass = "fa fa-pencil"
        }
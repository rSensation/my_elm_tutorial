module Views.PlayersTable exposing (view)

import Html exposing (Html, div, text, table, thead, tbody, tr, th, td)
import Html.Attributes exposing (class)

import Models exposing (Player, PlayerId)
import Msgs exposing (Msg(ShowConfirmationModal))
import Views.Common.NavBtn exposing (navBtn)
import Views.Common.LinkBtn exposing (linkBtn)
import Routing

view : List Player -> Html Msg
view players =
    div [ class "p2" ]
        [ table [ class "col-12" ]
            [ thead []
                [ tr []
                    [ th [ class "txta-left" ] [ text "Name" ]
                    , th [] [ text "Level" ]
                    , th [] [ text "Actions" ]
                    ]
                ]
            , tbody [] (List.map playerRow players)
            ]
        ]

playerRow : Player -> Html Msg
playerRow player =
    tr []
        [ td [] [ text player.name ]
        , td [ class "txta-center" ] [ text (toString player.level) ]
        , td [ class "txta-center" ] 
            [ editBtn player
            , deleteBtn player.id
            ]
        ]

editBtn : Player -> Html Msg
editBtn player =
    navBtn
        { btnText = "Edit"
        , iconClass = "fa fa-pencil"
        , path = Routing.playerPath player.id
        }

deleteBtn : PlayerId -> Html Msg
deleteBtn playerId =
    linkBtn
        { message = ShowConfirmationModal playerId
        , btnClass = "ml1 h2"
        , iconClass = "fa fa-trash"
        }
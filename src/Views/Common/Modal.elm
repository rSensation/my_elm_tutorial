module Views.Common.Modal exposing (modal)

import Html exposing (Html, div, text)
import Html.Attributes exposing (class)

import Msgs exposing (Msg)

type alias Props =
    { title : String
    , buttons : List (Html Msg)
    }

modal : Props -> Html Msg
modal props =
        div [ class "modal fixed all-sides-0 flex" ] 
            [ div [ class "modal-content m-auto px3 py2 border rounded txta-center" ]
                [ text props.title
                , div [] props.buttons
                ]
            ]
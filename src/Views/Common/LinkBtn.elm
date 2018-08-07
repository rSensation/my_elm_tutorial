module Views.Common.LinkBtn exposing (linkBtn)

import Html exposing (Html, a, i)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)

import Msgs exposing (Msg)

type alias Props =
    { message : Msg
    , btnClass : String
    , iconClass : String
    }

linkBtn : Props -> Html Msg
linkBtn props  =
    a 
        [ class ("btn " ++ props.btnClass)
        , onClick props.message
        ]
        [ i [ class props.iconClass ] [] ]
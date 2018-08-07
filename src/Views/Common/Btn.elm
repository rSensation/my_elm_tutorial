module Views.Common.Btn exposing (btn, btnDefault)

import Html exposing (Html, button, text)
import Html.Attributes exposing (class, type_, disabled)
import Html.Events exposing (onClick)

import Msgs exposing (Msg)

type alias Props =
    { message : Msg
    , btnClass : String
    , content : List (Html Msg)
    , disabled : Bool
    }

btn : Props -> Html Msg
btn props  =
    button 
        [ class ("btn " ++ props.btnClass)
        , type_ "button" 
        , onClick props.message
        , disabled props.disabled
        ] props.content

btnDefault : Msg -> String -> Bool -> Html Msg
btnDefault message btnText disabled =
    btn
        { message = message
        , btnClass = "white bg-green ml1"
        , content = [ text btnText ]
        , disabled = disabled
        }
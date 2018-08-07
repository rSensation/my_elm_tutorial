module Views.Common.NavBtn exposing (navBtn)

import Html exposing (Html, text, a, i)
import Html.Attributes exposing (class)
import Html.Events exposing (onWithOptions)
import Json.Decode as Decode

import Msgs exposing (Msg(ChangeLocation))

type alias Props =
    { btnText : String
    , iconClass : String
    , path : String
    }

navBtn : Props -> Html Msg
navBtn props =
    a 
        [ class "btn regular p0" 
        , onWithOptions "click"
            { stopPropagation = False
            , preventDefault = True
            } 
            ( Decode.succeed ( ChangeLocation props.path ) )
        ]
        [ i [ class (props.iconClass ++ " mr1") ] []
        , text props.btnText
        ]
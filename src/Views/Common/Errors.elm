module Views.Common.Errors exposing (errors)

import Html exposing (Html, div, text)
import Html.Attributes exposing (class)

import Msgs exposing (Msg(RemoveError))
import Views.Common.LinkBtn exposing (linkBtn)

errors : List String -> Html Msg
errors errors =
    div [ class "fixed top-0 left-0 right-0 p2"] (List.indexedMap error errors)

error : Int -> String -> Html Msg
error index error =
    div [ class "bg-green px2 py1 mb1 rounded flex justify-between" ]
        [ text error
        , linkBtn
            { message = RemoveError index
            , btnClass = "pr0 pt0"
            , iconClass = "fa fa-times"
            }
        ]
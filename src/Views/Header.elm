module Views.Header exposing (view)

import Html exposing (Html, div, text)
import Html.Attributes exposing (class)

import Models exposing (Model, Route(..))
import Msgs exposing (Msg)
import Views.Common.NavBtn exposing (navBtn)
import Routing

view : Model -> Html Msg
view model =
    div [ class "clearfix mb2 white bg-black p1" ]
        [ div [ class "left p2" ] (navContent model.route) ]

navContent : Route -> List (Html Msg)
navContent route =
    let
        headerTitle =
            [ text "Players" ]
    in
        case route of
            PlayersRoute -> headerTitle
            NotFoundRoute -> headerTitle
            PlayerRoute playerId -> [ listBtn ]

listBtn : Html Msg
listBtn =
    navBtn 
        { btnText = "List"
        , iconClass = "fa fa-chevron-left"
        , path = Routing.playersPath
        }

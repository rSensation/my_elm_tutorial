module Updates.Update exposing (update)

import Navigation
import List.Extra exposing (removeAt)

import Models exposing (Model, Player, PlayerId, ConfirmationModalStatus(..), EditPlayerNameStatus(..))
import Msgs exposing (Msg(..))
import Updates.Helpers exposing (addPlayer, deletePlayerById, updatePlayer, errorParser)
import Commands.HttpCommands as HttpCommands
import Commands.DomCommands as DomCommands
import Routing

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeLocation path ->
            ( model, Navigation.newUrl path )
        OnLocationChange location ->
            ( { model
                | route = Routing.parseLocation location
                , editPlayerNameStatus = NoEdit
                }, Cmd.none )

        OnFetchPlayers response ->
            ( { model | players = response }, Cmd.none )

        ChangeLevel player increment ->
            let
                updatedPlayer =
                    { player | level = player.level + increment }
            in
                ( model, HttpCommands.savePlayerCmd updatedPlayer OnLevelChanged )
        OnLevelChanged (Ok player) ->
            ( { model | players = updatePlayer model.players player }, Cmd.none )
        OnLevelChanged (Err error) ->
            ( { model | errors = model.errors ++ [errorParser error] }, Cmd.none )

        DeletePlayer playerId ->
            ( model, HttpCommands.deletePlayerCmd playerId )
        OnPlayerDelete (Ok playerId) ->
            ( { model
                | players = deletePlayerById model.players playerId
                , confirmationModalStatus = Hidden
                }, Cmd.none )
        OnPlayerDelete (Err error) ->
            ( { model 
                | errors = model.errors ++ [errorParser error]
                , confirmationModalStatus = Hidden
                }, Cmd.none )

        ShowConfirmationModal playerId ->
            ( { model | confirmationModalStatus = Shown playerId }, Cmd.none )
        HideConfirmationModal ->
            ( { model | confirmationModalStatus = Hidden }, Cmd.none )

        OnCreateInputChange playerName ->
            ( { model | newPlayerName = playerName }, Cmd.none )
        CreatePlayer ->
            ( model, HttpCommands.createPlayerCmd model.newPlayerName )
        OnPlayerCreate (Ok player) ->
            ( { model | players = addPlayer model.players player }, Cmd.none )
        OnPlayerCreate (Err error) ->
           ( { model | errors = model.errors ++ [errorParser error] }, Cmd.none )

        StartEditPlayerName playerName ->
            ( { model | editPlayerNameStatus = Edit playerName }
            , DomCommands.focusOnEditPlayerNameInput )
        CancelEditPlayerName ->
            ( { model | editPlayerNameStatus = NoEdit }, Cmd.none )
        OnEditPlayerNameInputChange playerName ->
            ( { model | editPlayerNameStatus = Edit playerName }, Cmd.none )
        ChangeName player newName ->
            let
                updatedPlayer =
                    { player | name = newName }
            in
                ( model, HttpCommands.savePlayerCmd updatedPlayer OnNameChanged )
        OnNameChanged (Ok player) ->
            ( { model
                | players = updatePlayer model.players player
                , editPlayerNameStatus = NoEdit
                }, Cmd.none )
        OnNameChanged (Err error) ->
            ( { model
                | errors = model.errors ++ [errorParser error ++ " pupul"]
                , editPlayerNameStatus = NoEdit
                }, Cmd.none )
        
        OnFocus (Ok ()) ->
            ( model, Cmd.none )
        OnFocus (Err error) ->
            ( model, Cmd.none )

        RemoveError index ->
            ( { model | errors = removeAt index model.errors }, Cmd.none  )
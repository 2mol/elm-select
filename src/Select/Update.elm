module Select.Update exposing (..)

import Select.Config exposing (Config)
import Select.Messages exposing (..)
import Select.Models exposing (State)
import Task


update : Config msg item -> Msg item -> State -> ( State, Cmd msg )
update config msg model =
    let
        queryChangeCmd value =
            case config.onQueryChange of
                Nothing ->
                    Cmd.none

                Just constructor ->
                    Task.succeed value
                        |> Task.perform constructor
    in
    case msg of
        NoOp ->
            ( model, Cmd.none )

        OnEsc ->
            ( { model | query = Nothing }, Cmd.none )

        OnDownArrow ->
            let
                newHightlightedItem =
                    case model.highlightedItem of
                        Nothing ->
                            Just 0

                        Just n ->
                            Just (n + 1)
            in
            ( { model | highlightedItem = newHightlightedItem }, Cmd.none )

        OnUpArrow ->
            let
                newHightlightedItem =
                    case model.highlightedItem of
                        Nothing ->
                            Nothing

                        Just 0 ->
                            Nothing

                        Just n ->
                            Just (n - 1)
            in
            ( { model | highlightedItem = newHightlightedItem }, Cmd.none )

        OnFocus ->
            let
                cmd =
                    case config.onFocus of
                        Nothing ->
                            Cmd.none

                        Just focusMessage ->
                            Task.succeed Nothing
                                |> Task.perform (\x -> focusMessage)
            in
            case config.emptySearch of
                True ->
                    ( { model | query = Just "" }
                    , Cmd.batch
                        [ cmd
                        , if config.emptySearch then
                            queryChangeCmd ""
                          else
                            Cmd.none
                        ]
                    )

                False ->
                    ( model, cmd )

        OnBlur ->
            ( { model | query = Nothing }, Cmd.none )

        OnClear ->
            let
                cmd =
                    Task.succeed Nothing
                        |> Task.perform config.onSelect
            in
            ( { model | query = Nothing }, cmd )

        OnQueryChange value ->
            { model | highlightedItem = Nothing, query = Just value }
                ! [ queryChangeCmd value
                  ]

        OnSelect item ->
            let
                cmd =
                    Task.succeed (Just item)
                        |> Task.perform config.onSelect
            in
            ( { model | query = Nothing }, cmd )

module Main exposing (main)

import Browser
import Example1
import Example2
import Example3
import Html exposing (..)
import Html.Attributes exposing (class, href)


type alias Model =
    { example1a : Example1.Model
    , example1b : Example1.Model
    , example2 : Example2.Model
    , example3 : Example3.Model
    }


initialModel : Model
initialModel =
    { example1a = Example1.initialModel "1"
    , example1b = Example1.initialModel "2"
    , example2 = Example2.initialModel "3"
    , example3 = Example3.initialModel "4"
    }


initialCmds : Cmd Msg
initialCmds =
    Cmd.batch [ Cmd.map Example2Msg Example2.initialCmds ]


init : ( Model, Cmd Msg )
init =
    ( initialModel, initialCmds )


type Msg
    = NoOp
    | Example1aMsg Example1.Msg
    | Example1bMsg Example1.Msg
    | Example2Msg Example2.Msg
    | Example3Msg Example3.Msg


update : Msg -> ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
update msg ( model, m2 ) =
    case msg of
        Example1aMsg sub ->
            let
                ( subModel, subCmd ) =
                    Example1.update sub model.example1a
            in
            ( { model | example1a = subModel }, Cmd.map Example1aMsg subCmd )

        Example1bMsg sub ->
            let
                ( subModel, subCmd ) =
                    Example1.update sub model.example1b
            in
            ( { model | example1b = subModel }, Cmd.map Example1bMsg subCmd )

        Example2Msg sub ->
            let
                ( subModel, subCmd ) =
                    Example2.update sub model.example2
            in
            ( { model | example2 = subModel }, Cmd.map Example2Msg subCmd )

        Example3Msg sub ->
            let
                ( subModel, subCmd ) =
                    Example3.update sub model.example3
            in
            ( { model | example3 = subModel }, Cmd.map Example3Msg subCmd )

        NoOp ->
            ( model, Cmd.none )


projectUrl : String
projectUrl =
    "https://github.com/sporto/elm-select"


view : ( Model, Cmd Msg ) -> Html Msg
view ( model, msg ) =
    div [ class "p3" ]
        [ h1 [] [ text "Elm Select" ]
        , a [ class "h3", href projectUrl ] [ text projectUrl ]
        , div [ class "clearfix mt2" ]
            [ div [ class "col col-6" ]
                [ Html.map Example1aMsg (Example1.view model.example1a)
                ]
            , div [ class "col col-6" ]
                [ Html.map Example1bMsg (Example1.view model.example1b)
                ]
            ]
        , div [ class "clearfix mt2" ]
            [ div [ class "col col-6" ]
                [ Html.map Example2Msg (Example2.view model.example2)
                ]
            , div [ class "col col-6" ]
                [ Html.map Example3Msg (Example3.view model.example3)
                ]
            ]
        ]


main : Program () ( Model, Cmd Msg ) Msg
main =
    Browser.sandbox
        { view = view
        , init = init
        , update = update
        }

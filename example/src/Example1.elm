module Example1 exposing (..)

import Html exposing (Html, text, div)
import Html.Attributes exposing (class)
import Movies
import Select


{-|
Model to be passed to the select component. You model can be anything.
E.g. Records, tuples or just strings.
-}
type alias Movie =
    { id : String
    , label : String
    }


{-|
In your main application model you should store:

- The selected item e.g. selectedMovieId
- The state for the select component
-}
type alias Model =
    { movies : List Movie
    , selectedMovieId : Maybe String
    , selectState : Select.Model
    }


{-|
This just transforms a list of tuples into records
-}
movies : List Movie
movies =
    List.map (\( id, name ) -> Movie id name) Movies.movies


{-|
Your model should store the selected item and the state of the Select component(s)
-}
initialModel : Model
initialModel =
    { movies = movies
    , selectedMovieId = Nothing
    , selectState = Select.newState
    }


{-|
Your application messages need to include:
- OnSelect item : This will be called when an item is selected
- SelectMsg (Select.Msg item) : A message that wraps internal Select library messages. This is necessary to route messages back to the component.
-}
type Msg
    = NoOp
    | OnSelect Movie
    | SelectMsg (Select.Msg Movie)


{-|
Create the configuration for the Select component

`Select.newConfig` takes two args:

- The selection message e.g. `OnSelect`
- A function that extract a label from an item e.g. `.label`
-}
selectConfig : Select.Config Msg Movie
selectConfig =
    Select.newConfig OnSelect .label
        |> Select.withInputClass "col-12"
        |> Select.withMenuClass "bg-white border border-gray"
        |> Select.withItemClass "border-bottom border-silver p1"
        |> Select.withCutoff 6


{-|
Your update function should route messages back to the Select component, see `SelectMsg`.
-}
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        -- OnSelect is triggered when a selection is made on the Select component.
        OnSelect movie ->
            ( { model | selectedMovieId = Just movie.id }, Cmd.none )

        -- Route message to the Select component.
        -- The returned command is important.
        SelectMsg subMsg ->
            let
                ( updated, cmd ) =
                    Select.update selectConfig subMsg model.selectState
            in
                ( { model | selectState = updated }, cmd )

        NoOp ->
            ( model, Cmd.none )


{-|
Your view renders the select component passing the config, state, list of items and the currently selected item.
-}
view : Model -> Html Msg
view model =
    let
        selectedMovie =
            case model.selectedMovieId of
                Nothing ->
                    Nothing

                Just id ->
                    List.filter (\movie -> movie.id == id) movies
                        |> List.head
    in
        div [ class "bg-silver p1" ]
            [ text (toString model.selectedMovieId)
              -- Render the Select view. You must pass:
              -- - The configuration
              -- - The Select internal state
              -- - A list of items
              -- - The currently selected item as Maybe
            , Html.map SelectMsg (Select.view selectConfig model.selectState model.movies selectedMovie)
            ]

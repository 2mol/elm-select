module Select
    exposing
        ( Config
        , State
        , Msg
        , newConfig
        , newState
        , update
        , view
        , withClearClass
        , withClearStyles
        , withClearSvgClass
        , withCutoff
        , withFuzzySearchAddPenalty
        , withFuzzySearchMovePenalty
        , withFuzzySearchRemovePenalty
        , withFuzzySearchSeparators
        , withInputClass
        , withInputStyles
        , withInputWrapperClass
        , withInputWrapperStyles
        , withItemClass
        , withItemStyles
        , withMenuClass
        , withMenuStyles
        , withNotFound
        , withNotFoundClass
        , withNotFoundStyles
        , withOnQuery
        , withPrompt
        , withPromptClass
        , withPromptStyles
        , withScoreThreshold
        )

{-| Select input with auto-complete

# Types
@docs Config, State, Msg

# Configuration
@docs newConfig, withCutoff, withOnQuery

# Configure the clear button

@docs withClearClass, withClearStyles, withClearSvgClass

# Configure the input

@docs withInputClass, withInputStyles, withInputWrapperClass, withInputWrapperStyles

# Configure the items

@docs withItemClass, withItemStyles

# Configure the menu

@docs withMenuClass, withMenuStyles

# Configure the not found message

@docs withNotFound, withNotFoundClass, withNotFoundStyles

# Configure the prompt

@docs withPrompt, withPromptClass, withPromptStyles

# Configure the Fuzzy search

@docs withScoreThreshold, withFuzzySearchAddPenalty, withFuzzySearchMovePenalty, withFuzzySearchRemovePenalty, withFuzzySearchSeparators

# State
@docs newState

# view
@docs view

# Update
@docs update
-}

import Html exposing (..)
import Select.Select
import Select.Models as Models
import Select.Messages as Messages
import Select.Update


{-|
Opaque type that holds the configuration
-}
type Config
    = PrivateConfig Models.Config


type alias ViewArgs msg item =
    Models.ViewArgs msg item


{-|
Opaque type that holds the current state
-}
type State
    = PrivateState Models.State


{-|
Opaque type for internal library messages
-}
type Msg item
    = PrivateMsg (Messages.Msg item)


{-|
Create a new configuration.


    Select.newConfig
-}
newConfig : Config
newConfig =
    PrivateConfig Models.newConfig


{-|
Add classes to the clear button

    Select.withClearClass "clear" config
-}
withClearClass : String -> Config msg item -> Config msg item
withClearClass classes config =
    let
        fn c =
            { c | clearClass = classes }
    in
        fmapConfig fn config


{-|
Add styles to the clear button

    Select.withClearStyles [("width", "2rem")] config
-}
withClearStyles : List ( String, String ) -> Config msg item -> Config msg item
withClearStyles styles config =
    let
        fn c =
            { c | clearStyles = styles }
    in
        fmapConfig fn config


{-|
Add classes to the clear SVG icon

    Select.withClearSvgClass "clear" config
-}
withClearSvgClass : String -> Config msg item -> Config msg item
withClearSvgClass classes config =
    let
        fn c =
            { c | clearSvgClass = classes }
    in
        fmapConfig fn config


{-|
Set the maxium number of items to show

    Select.withCutoff 6 config
-}
withCutoff : Int -> Config msg item -> Config msg item
withCutoff n config =
    let
        fn c =
            { c | cutoff = Just n }
    in
        fmapConfig fn config


{-|
Add classes to the input

    Select.withInputClass "col-12" config
-}
withInputClass : String -> Config msg item -> Config msg item
withInputClass classes config =
    let
        fn c =
            { c | inputClass = classes }
    in
        fmapConfig fn config


{-|
Add styles to the input

    Select.withInputStyles [("color", "red")] config
-}
withInputStyles : List ( String, String ) -> Config msg item -> Config msg item
withInputStyles styles config =
    let
        fn c =
            { c | inputStyles = styles }
    in
        fmapConfig fn config


{-|
Add classes to the input wrapper (element that wraps the input and the clear button)

    Select.withInputWrapperClass "col-12" config
-}
withInputWrapperClass : String -> Config msg item -> Config msg item
withInputWrapperClass classes config =
    let
        fn c =
            { c | inputWrapperClass = classes }
    in
        fmapConfig fn config


{-|
Add styles to the input wrapper

    Select.withInputWrapperStyles [("color", "red")] config
-}
withInputWrapperStyles : List ( String, String ) -> Config msg item -> Config msg item
withInputWrapperStyles styles config =
    let
        fn c =
            { c | inputWrapperStyles = styles }
    in
        fmapConfig fn config


{-|
Add classes to the items

    Select.withItemClass "border-bottom" config
-}
withItemClass : String -> Config msg item -> Config msg item
withItemClass classes config =
    let
        fn c =
            { c | itemClass = classes }
    in
        fmapConfig fn config


{-|
Add styles to the items

    Select.withItemStyles [("color", "peru")] config
-}
withItemStyles : List ( String, String ) -> Config msg item -> Config msg item
withItemStyles styles config =
    let
        fn c =
            { c | itemStyles = styles }
    in
        fmapConfig fn config


{-|
Add classes to the menu

    Select.withMenuClass "bg-white" config
-}
withMenuClass : String -> Config msg item -> Config msg item
withMenuClass classes config =
    let
        fn c =
            { c | menuClass = classes }
    in
        fmapConfig fn config


{-|
Add styles to the menu

    Select.withMenuStyles [("padding", "1rem")] config
-}
withMenuStyles : List ( String, String ) -> Config msg item -> Config msg item
withMenuStyles styles config =
    let
        fn c =
            { c | menuStyles = styles }
    in
        fmapConfig fn config


{-|
Text that will appear when no matches are found

    Select.withNotFound "No matches" config
-}
withNotFound : String -> Config msg item -> Config msg item
withNotFound text config =
    let
        fn c =
            { c | notFound = text }
    in
        fmapConfig fn config


{-|
Class for the not found message

    Select.withNotFoundClass "red" config
-}
withNotFoundClass : String -> Config msg item -> Config msg item
withNotFoundClass class config =
    let
        fn c =
            { c | notFoundClass = class }
    in
        fmapConfig fn config


{-|
Styles for the not found message

    Select.withNotFoundStyles [("padding", "1rem")] config
-}
withNotFoundStyles : List ( String, String ) -> Config msg item -> Config msg item
withNotFoundStyles styles config =
    let
        fn c =
            { c | notFoundStyles = styles }
    in
        fmapConfig fn config


{-|
Add a callback for when the query changes

    Select.withOnQuery OnQuery
-}
withOnQuery : (String -> msg) -> Config msg item -> Config msg item
withOnQuery msg config =
    let
        fn c =
            { c | onQueryChange = Just msg }
    in
        fmapConfig fn config


{-|
Add classes to the prompt text (When no item is selected)
    Select.withPromptClass "prompt" config
-}
withPromptClass : String -> Config msg item -> Config msg item
withPromptClass classes config =
    let
        fn c =
            { c | promptClass = classes }
    in
        fmapConfig fn config


{-|
Add a prompt text to be displayed when no element is selected

    Select.withPrompt "Select a movie" config
-}
withPrompt : String -> Config msg item -> Config msg item
withPrompt prompt config =
    let
        fn c =
            { c | prompt = prompt }
    in
        fmapConfig fn config


{-|
Add styles to prompt text

    Select.withPromptStyles [("color", "red")] config
-}
withPromptStyles : List ( String, String ) -> Config msg item -> Config msg item
withPromptStyles styles config =
    let
        fn c =
            { c | promptStyles = styles }
    in
        fmapConfig fn config


{-|
Change the threshold used for filtering matches out.
A higher threshold will keep more matches.
Default is 500.

    Select.withScoreThreshold 1000 config
-}
withScoreThreshold : Int -> Config msg item -> Config msg item
withScoreThreshold score config =
    let
        fn c =
            { c | scoreThreshold = score }
    in
        fmapConfig fn config


{-|
Add fuzzy search add penalty

    Select.withFuzzySearchAddPenalty 1 config
-}
withFuzzySearchAddPenalty : Int -> Config msg item -> Config msg item
withFuzzySearchAddPenalty penalty config =
    let
        fn c =
            { c | fuzzySearchAddPenalty = Just penalty }
    in
        fmapConfig fn config


{-|
Add fuzzy search add penalty

    Select.withFuzzySearchRemovePenalty 100 config
-}
withFuzzySearchRemovePenalty : Int -> Config msg item -> Config msg item
withFuzzySearchRemovePenalty penalty config =
    let
        fn c =
            { c | fuzzySearchRemovePenalty = Just penalty }
    in
        fmapConfig fn config


{-|
Add fuzzy search move penalty

    Select.withFuzzySearchMovePenalty 1000 config
-}
withFuzzySearchMovePenalty : Int -> Config msg item -> Config msg item
withFuzzySearchMovePenalty penalty config =
    let
        fn c =
            { c | fuzzySearchMovePenalty = Just penalty }
    in
        fmapConfig fn config


{-|
Add fuzzy search separators

    Select.withFuzzySearchSeparators ["|", " "] config
-}
withFuzzySearchSeparators : List String -> Config msg item -> Config msg item
withFuzzySearchSeparators separators config =
    let
        fn c =
            { c | fuzzySearchSeparators = separators }
    in
        fmapConfig fn config


{-|
@priv
-}
fmapConfig : (Models.Config msg item -> Models.Config msg item) -> Config msg item -> Config msg item
fmapConfig fn config =
    let
        config_ =
            unwrapConfig config
    in
        PrivateConfig (fn config_)


{-|
Create a new state. You must pass a unique identifier for each select component.

    {
        ...
        selectState = Select.newState "select1"
    }
-}
newState : String -> State
newState id =
    PrivateState (Models.newState id)


{-|
Render the view

    Html.map SelectMsg (Select.view selectConfig model.selectState model.items selectedItem)
-}
view : Config -> ViewArgs msg item -> Html msg
view (PrivateConfig config) viewArgs =
    Select.Select.view config viewArgs


{-|
Update the component state

    SelectMsg subMsg ->
        let
            ( updated, cmd ) =
                Select.update selectConfig subMsg model.selectState
        in
            ( { model | selectState = updated }, cmd )
-}
update : Config msg item -> Msg item -> State -> ( State, Cmd msg )
update config msg model =
    let
        config_ =
            unwrapConfig config

        msg_ =
            unwrapMsg msg

        model_ =
            unwrapModel model
    in
        let
            ( mdl, cmd ) =
                Select.Update.update config_ msg_ model_
        in
            ( PrivateState mdl, cmd )


{-|
@priv
-}
unwrapConfig : Config msg item -> Models.Config msg item
unwrapConfig config =
    case config of
        PrivateConfig c ->
            c


{-|
@priv
-}
unwrapMsg : Msg item -> Messages.Msg item
unwrapMsg msg =
    case msg of
        PrivateMsg m ->
            m


{-|
@priv
-}
unwrapModel : State -> Models.State
unwrapModel model =
    case model of
        PrivateState m ->
            m

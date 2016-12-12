module Select.Models exposing (..)


type alias Config msg item =
    { inputClass : String
    , itemClass : String
    , onQueryChange : Maybe (String -> msg)
    , onSelect : item -> msg
    , toLabel : item -> String
    }


newConfig : (item -> msg) -> (item -> String) -> Config msg item
newConfig onSelect toLabel =
    { inputClass = ""
    , itemClass = ""
    , onQueryChange = Nothing
    , onSelect = onSelect
    , toLabel = toLabel
    }


type alias State =
    { query : Maybe String
    }


newState : State
newState =
    { query = Nothing
    }

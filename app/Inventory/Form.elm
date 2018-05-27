module Inventory.Form exposing (..)


type Msg
    = NameInput String
    | Submit


type alias FormModel =
    { name : String }


updateForm : Msg -> FormModel -> FormModel
updateForm msg model =
    case msg of
        NameInput string ->
            { model | name = string }

        Submit ->
            model

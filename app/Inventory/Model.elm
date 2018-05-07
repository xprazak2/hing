module Inventory.Model exposing (..)

import Date exposing (Date)
import RemoteData exposing (WebData)


type Msg
    = LoadInventories (WebData Inventories)


type alias Model =
    { inventories : WebData Inventories
    }


type alias Inventory =
    { id : String
    , name : String
    , createdAt : Date
    , updatedAt : Date
    }


type alias Inventories =
    List Inventory


initialState : Model
initialState =
    { inventories = RemoteData.NotAsked }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LoadInventories inventories ->
            ( { model | inventories = inventories }, Cmd.none )


dateFromString : String -> Date
dateFromString string =
    Date.fromString string |> Result.withDefault (Date.fromTime 0)

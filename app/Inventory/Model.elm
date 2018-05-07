module Inventory.Model exposing (..)

import Date exposing (Date)
import RemoteData exposing (WebData)
import Inventory.Msg exposing (Msg(..))


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


init : ( Model, Cmd Msg )
init =
    ( { inventories = RemoteData.Success [ Inventory "57a6s" "First Inventory" (dateFromString "2011/6/4") (dateFromString "2011/6/4") ] }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


dateFromString : String -> Date
dateFromString string =
    Date.fromString string |> Result.withDefault (Date.fromTime 0)

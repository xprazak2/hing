module Inventory.Model exposing (..)

import Date exposing (Date)
import Inventory.Msg exposing (Msg(..))


type alias Model =
    { inventories : Inventories
    }


type alias Inventory =
    { id : String
    , name : String
    , createdAt : Date
    , updatedAt : Date
    }


type alias Inventories =
    List Inventory


init : ( Model, Cmd Msg )
init =
    ( { inventories = [ Inventory "57a6s" "First Inventory" (dateFromString "2011/6/4") (dateFromString "2011/6/4") ] }, Cmd.none )


dateFromString : String -> Date
dateFromString string =
    Date.fromString string |> Result.withDefault (Date.fromTime 0)

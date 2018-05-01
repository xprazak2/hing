module Inventory.Model exposing (Inventory, Inventories, init, update, Msg(..))

import Task exposing (Task)
import Date exposing (Date)
import Inventory.Item.Model exposing (Item)
import Page exposing (PageLoadError)


type Msg
    = None


update : Msg -> Inventories -> ( Inventories, Cmd Msg )
update msg model =
    ( model, Cmd.none )


init : Task PageLoadError Inventories
init =
    Task.succeed
        [ Inventory 1 "first" (dateFromString "2011/6/4") (dateFromString "2011/6/4") [] ]


dateFromString : String -> Date
dateFromString string =
    Date.fromString string |> Result.withDefault (Date.fromTime 0)


type alias Inventories =
    List Inventory


type alias Inventory =
    { id : Int
    , name : String
    , createdAt : Date
    , updatedAt : Date
    , items : List Item
    }

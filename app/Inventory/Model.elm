module Inventory.Model exposing (Inventory, Inventories, load)

import PageError exposing (PageLoadError)
import Task exposing (Task)


load : Task PageLoadError Inventories
load =
    (Task.succeed [ { id = 1, name = "first" } ])


type alias Inventory =
    { id : Int
    , name : String
    }


type alias Inventories =
    List Inventory

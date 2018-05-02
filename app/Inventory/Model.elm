module Inventory.Model exposing (Inventory, Inventories)


type alias Inventory =
    { id : Int
    , name : String
    }


type alias Inventories =
    List Inventory

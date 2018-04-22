module Model exposing (Inventory, InventoryState, initInventory)

import Item.Model exposing (Item)


initInventory : List Inventory
initInventory =
    []


type alias InventoryState =
    { inventories : List Inventory }


type alias Inventory =
    { id : Int
    , name : String
    , createdAt : Date
    , updatedAt : Date
    , items : List Item
    }

module Inventory.Item.Model exposing (Item)

import Date exposing (Date)


type alias Item =
    { id : Int
    , name : String
    , amount : Int
    , location : String
    , expiry : Date
    , listId : Int
    , createdAt : Date
    , updatedAt : Date
    }

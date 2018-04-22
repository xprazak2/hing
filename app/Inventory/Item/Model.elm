module Model exposing (Item)


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

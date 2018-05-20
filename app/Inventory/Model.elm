module Inventory.Model exposing (..)

import Date exposing (Date)
import Navigation
import RemoteData exposing (WebData)
import Routing.Routes exposing (Route, reverseRoute)


type Msg
    = LoadInventories (WebData Inventories)
    | NavigateTo Route


type alias Model =
    { inventories : WebData Inventories
    , inventoryNew : InventoryBase
    }


type alias InventoryBase =
    { name : String }


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
    { inventories = RemoteData.NotAsked
    , inventoryNew = InventoryBase ""
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LoadInventories inventories ->
            ( { model | inventories = inventories }, Cmd.none )

        NavigateTo route ->
            ( model, Navigation.newUrl (reverseRoute route) )

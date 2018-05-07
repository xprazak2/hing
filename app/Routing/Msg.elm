module Routing.Msg exposing (..)

import Navigation exposing (Location)
import Routing.Model exposing (Route)
import Home.Model
import Inventory.Model


type Msg
    = LocationChanged Location
    | NavigateTo Route
    | HomeMsg Home.Model.Msg
    | InventoryMsg Inventory.Model.Msg

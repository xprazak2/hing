module Routing.Msg exposing (..)

import Navigation exposing (Location)
import Routing.Model exposing (Route)
import Home.Msg
import Inventory.Msg


type Msg
    = LocationChanged Location
    | NavigateTo Route
    | HomeMsg Home.Msg.Msg
    | InventoryMsg Inventory.Msg.Msg

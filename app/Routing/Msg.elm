module Routing.Msg exposing (..)

import Navigation exposing (Location)
import Routing.Routes exposing (Route)
import Home.Model
import Inventory.Msg


type Msg
    = LocationChanged Location
    | NavigateTo Route
    | HomeMsg Home.Model.Msg
    | InventoryMsg Inventory.Msg.Msg

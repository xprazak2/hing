module Routing.Model exposing (Model)

import Home.Model
import Inventory.Model
import Routing.Routes exposing (Route)


type alias Model =
    { homeModel : Home.Model.Model
    , inventoryModel : Inventory.Model.Model
    , route : Route
    }

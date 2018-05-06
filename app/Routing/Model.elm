module Routing.Model exposing (Model, Route(..), reverseRoute)

import Home.Model
import Inventory.Model


type alias Model =
    { homeModel : Home.Model.Model
    , inventoryModel : Inventory.Model.Model
    , route : Route
    }


type Route
    = HomeRoute
    | InventoriesRoute
    | NotFoundRoute


reverseRoute : Route -> String
reverseRoute route =
    case route of
        HomeRoute ->
            "/"

        InventoriesRoute ->
            "/inventories"

        NotFoundRoute ->
            "/notfound"

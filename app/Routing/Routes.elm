module Routing.Routes exposing (Route(..), reverseRoute)

import Inventory.Routes exposing (inventoryReverseRoute)


type Route
    = HomeRoute
    | InventoryRoute Inventory.Routes.Route
    | NotFoundRoute


reverseRoute : Route -> String
reverseRoute route =
    case route of
        HomeRoute ->
            "/"

        InventoryRoute inventoryRoute ->
            inventoryReverseRoute inventoryRoute

        NotFoundRoute ->
            "/notfound"

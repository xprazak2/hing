module Inventory.RouteHelpers exposing (..)

import Inventory.Routes exposing (Route(..))
import Routing.Routes


inventoriesRoute : Routing.Routes.Route
inventoriesRoute =
    Routing.Routes.InventoryRoute Inventory.Routes.InventoriesRoute


newInventoryRoute : Routing.Routes.Route
newInventoryRoute =
    Routing.Routes.InventoryRoute Inventory.Routes.InventoryNewRoute


inventoryRoute : String -> Routing.Routes.Route
inventoryRoute id =
    Routing.Routes.InventoryRoute (Inventory.Routes.InventoryShowRoute id)

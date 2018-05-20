module Inventory.Routes exposing (Route(..), inventoryReverseRoute, inventoryRouteMatcher)

import UrlParser exposing (s, (</>), map, Parser)


type Route
    = InventoriesRoute
    | InventoryNewRoute


inventoryReverseRoute : Route -> String
inventoryReverseRoute route =
    case route of
        InventoriesRoute ->
            "/inventories"

        InventoryNewRoute ->
            "/inventories/new"


inventoryRouteMatcher : List (Parser (Route -> a) a)
inventoryRouteMatcher =
    [ map InventoryNewRoute ((s "inventories") </> (s "new"))
    , map InventoriesRoute (s "inventories")
    ]

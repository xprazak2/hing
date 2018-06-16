module Inventory.Routes exposing (Route(..), inventoryReverseRoute, inventoryRouteMatcher)

import UrlParser exposing (s, (</>), map, Parser, string)


type Route
    = InventoriesRoute
    | InventoryNewRoute
    | InventoryShowRoute String
    | InventoryDeleteRoute String


inventoryReverseRoute : Route -> String
inventoryReverseRoute route =
    case route of
        InventoriesRoute ->
            "/inventories"

        InventoryNewRoute ->
            "/inventories/new"

        InventoryShowRoute id ->
            "/inventories/" ++ id

        InventoryDeleteRoute id ->
            "/inventories/" ++ id


inventoryRouteMatcher : List (Parser (Route -> a) a)
inventoryRouteMatcher =
    [ map InventoryNewRoute ((s "inventories") </> (s "new"))
    , map InventoriesRoute (s "inventories")
    , map InventoryShowRoute ((s "inventories") </> string)
    , map InventoryDeleteRoute ((s "inventories") </> string)
    ]

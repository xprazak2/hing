module Inventory.Init exposing (..)

import Inventory.Model exposing (Model, Msg, Inventory, InventoryBase)
import RemoteData
import Inventory.Request exposing (fetchInventories)
import Inventory.Routes exposing (Route(..))


init : Route -> Model -> ( Model, Cmd Msg )
init route model =
    case route of
        InventoriesRoute ->
            ( { model | inventories = RemoteData.Loading }, fetchInventories )

        InventoryNewRoute ->
            ( { model | inventoryNew = InventoryBase "" }, Cmd.none )

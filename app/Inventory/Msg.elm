module Inventory.Msg exposing (..)

import RemoteData exposing (WebData)
import Routing.Routes exposing (Route)
import Inventory.Model exposing (Inventory, Inventories)
import Inventory.Form.Msg
import Modal.Msg


type Msg
    = LoadInventories (WebData Inventories)
    | LoadInventory (WebData Inventory)
    | DeleteInventory Inventory
    | FormMsg Inventory.Form.Msg.Msg
    | ModalMsg Modal.Msg.Msg
    | NavigateTo Route

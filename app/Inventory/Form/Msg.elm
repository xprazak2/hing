module Inventory.Form.Msg exposing (..)

import RemoteData exposing (WebData)
import Inventory.Model exposing (Inventory)


type Msg
    = NameInput String
    | Submit
    | CreateInventory (WebData Inventory)

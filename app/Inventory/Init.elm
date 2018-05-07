module Inventory.Init exposing (..)

import Inventory.Model exposing (Model, Msg)
import RemoteData
import Inventory.Request exposing (fetchInventories)


init : ( Model, Cmd Msg )
init =
    ( { inventories = RemoteData.Loading }, fetchInventories )

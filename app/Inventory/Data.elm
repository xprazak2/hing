module Inventory.Data exposing (..)

import Date exposing (Date)
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Extra
import Json.Decode.Pipeline exposing (decode, required)


type alias InventoryData =
    { id : String
    , name : String
    , createdAt : Date
    , updatedAt : Date
    }


type alias InventoriesData =
    List InventoryData


inventoryDecoder : Decoder InventoryData
inventoryDecoder =
    decode InventoryData
        |> required "id" Decode.string
        |> required "name" Decode.string
        |> required "createdAt" Json.Decode.Extra.date
        |> required "updatedAt" Json.Decode.Extra.date


inventoriesDecoder : Decoder InventoriesData
inventoriesDecoder =
    Decode.field "result" (Decode.list inventoryDecoder)

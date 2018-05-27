module Inventory.Request exposing (..)

import Http
import RemoteData
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Extra
import Json.Decode.Pipeline exposing (decode, required)
import Api exposing (api)
import Inventory.Model exposing (Inventory, Inventories, Msg(..))


fetchInventories : Cmd Msg
fetchInventories =
    Http.get (api "/lists") inventoriesDecoder
        |> RemoteData.sendRequest
        |> Cmd.map LoadInventories


fetchInventory : String -> Cmd Msg
fetchInventory id =
    Http.get (api ("/lists/" ++ id)) (Decode.field "result" inventoryDecoder)
        |> RemoteData.sendRequest
        |> Cmd.map LoadInventory


inventoryDecoder : Decoder Inventory
inventoryDecoder =
    decode Inventory
        |> required "id" Decode.string
        |> required "name" Decode.string
        |> required "createdAt" Json.Decode.Extra.date
        |> required "updatedAt" Json.Decode.Extra.date


inventoriesDecoder : Decoder Inventories
inventoriesDecoder =
    Decode.field "result" (Decode.list inventoryDecoder)

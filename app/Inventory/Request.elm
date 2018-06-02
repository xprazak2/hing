module Inventory.Request exposing (..)

import Http
import RemoteData
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Extra
import Json.Decode.Pipeline exposing (decode, required)
import Json.Encode as Encode
import Api exposing (api)
import Inventory.Model exposing (Inventory, Inventories)
import Inventory.Msg exposing (Msg(..))
import Inventory.Form.Model exposing (FormInputField, FormModel, formFieldValue)
import Inventory.Form.Msg


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


saveInventory : FormModel -> Cmd Inventory.Form.Msg.Msg
saveInventory formModel =
    Http.post
        (api "/lists")
        (inventoryEncoder formModel |> Http.jsonBody)
        (Decode.field "result" inventoryDecoder)
        |> RemoteData.sendRequest
        |> Cmd.map Inventory.Form.Msg.CreateInventory


inventoryEncoder : FormModel -> Encode.Value
inventoryEncoder formModel =
    let
        -- TODO find a way how not to encode fields manually
        attrs =
            Encode.object [ ( "name", Encode.string (formFieldValue "name" formModel) ) ]
    in
        Encode.object [ ( "list", attrs ) ]


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

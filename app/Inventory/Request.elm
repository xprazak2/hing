module Inventory.Request exposing (getInventories)

import Http
import HttpBuilder
import Request.Api exposing (apiUrl)
import Inventory.Data exposing (inventoriesDecoder, InventoryData, InventoriesData)
import PageError exposing (PageLoadError)


getInventories : Http.Request InventoriesData
getInventories =
    apiUrl ("/api/lists")
        |> HttpBuilder.get
        |> HttpBuilder.withExpect (Http.expectJson (inventoriesDecoder))
        |> HttpBuilder.toRequest

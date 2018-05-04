module Inventory.Model exposing (Inventory, Inventories, load)

import Date exposing (Date)
import Http
import PageError exposing (PageLoadError)
import Task exposing (Task)
import Inventory.Data exposing (InventoryData)
import Inventory.Request
import Debug


type alias Inventory =
    InventoryData


type alias Inventories =
    List Inventory


load : Task PageLoadError Inventories
load =
    Inventory.Request.getInventories
        |> Http.toTask
        |> Task.mapError transformError


transformError : Http.Error -> PageLoadError
transformError err =
    PageError.newPageLoadError ("Failed to load Inventories, cause: " ++ (errorCause err))


errorCause : Http.Error -> String
errorCause httpError =
    case httpError of
        Http.BadUrl string ->
            "Bad URL - " ++ string

        Http.Timeout ->
            "Request execution timed out"

        Http.NetworkError ->
            "Network Error"

        Http.BadStatus response ->
            "Bad Status - " ++ (errorRespDetail response)

        Http.BadPayload string response ->
            "Bad Payload - " ++ string ++ (errorRespDetail response)


errorRespDetail : Http.Response String -> String
errorRespDetail response =
    (toString response.status.code) ++ ": " ++ response.status.message

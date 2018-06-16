module Inventory.Init exposing (..)

import Inventory.Model exposing (Model, Inventory, Inventories)
import Inventory.Msg exposing (Msg)
import Inventory.Form.Model exposing (FormModel)
import RemoteData
import List.Extra
import Inventory.Request exposing (fetchInventories, fetchInventory)
import Inventory.Routes exposing (Route(..))


init : Route -> Model -> ( Model, Cmd Msg )
init route model =
    case route of
        InventoriesRoute ->
            ( { model | inventories = RemoteData.Loading }, fetchInventories )

        InventoryNewRoute ->
            ( { model | formModel = Inventory.Form.Model.initFormModel }, Cmd.none )

        InventoryShowRoute id ->
            initShow id model

        InventoryDeleteRoute id ->
            ( model, Cmd.none )


initShow : String -> Model -> ( Model, Cmd Msg )
initShow id model =
    case model.inventories of
        RemoteData.Success inventories ->
            findInventory model inventories id

        _ ->
            ( { model | inventory = RemoteData.Loading }, fetchInventory id )


findInventory : Model -> Inventories -> String -> ( Model, Cmd Msg )
findInventory model inventories id =
    let
        foundInventory =
            List.Extra.find (\inventory -> inventory.id == id) inventories
    in
        case foundInventory of
            Just inventory ->
                ( { model | inventory = RemoteData.Success inventory }, Cmd.none )

            Nothing ->
                ( { model | inventory = RemoteData.Loading }, fetchInventory id )

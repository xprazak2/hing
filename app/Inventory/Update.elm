module Inventory.Update exposing (update)

import Navigation
import RemoteData exposing (WebData)
import Routing.Routes exposing (reverseRoute)
import Inventory.Model exposing (Model, Inventory)
import Inventory.Msg exposing (Msg(..))
import Inventory.Form.Model
import Inventory.Form.Update
import Inventory.Form.Msg
import Modal.Msg
import Modal.Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LoadInventories inventories ->
            ( { model | inventories = inventories }, Cmd.none )

        LoadInventory inventory ->
            ( { model | inventory = inventory }, Cmd.none )

        DeleteInventory inventory ->
            deleteInventory inventory model

        FormMsg formMsg ->
            updateForm formMsg model

        ModalMsg modalMsg ->
            updateModal modalMsg model

        NavigateTo route ->
            ( model, Navigation.newUrl (reverseRoute route) )


deleteInventory : Inventory -> Model -> ( Model, Cmd Msg )
deleteInventory inventory model =
    ( model, Cmd.none )


updateModal : Modal.Msg.Msg -> Model -> ( Model, Cmd Msg )
updateModal modalMsg model =
    let
        ( newModalModel, modalCmd ) =
            Modal.Update.update modalMsg model.modalModel
    in
        ( { model | modalModel = newModalModel }, Cmd.map ModalMsg modalCmd )


updateForm : Inventory.Form.Msg.Msg -> Model -> ( Model, Cmd Msg )
updateForm msg model =
    let
        ( newFormModel, formCmd ) =
            Inventory.Form.Update.update msg model.formModel
    in
        ( { model | formModel = newFormModel }, Cmd.map FormMsg formCmd )

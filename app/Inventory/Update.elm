module Inventory.Update exposing (update)

import Navigation
import RemoteData exposing (WebData)
import Routing.Routes exposing (reverseRoute)
import Inventory.Model exposing (Model, Inventory)
import Inventory.Msg exposing (Msg(..))
import Inventory.Form.Model
import Inventory.Form.Update
import Inventory.Form.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LoadInventories inventories ->
            ( { model | inventories = inventories }, Cmd.none )

        LoadInventory inventory ->
            ( { model | inventory = inventory }, Cmd.none )

        FormMsg formMsg ->
            updateForm formMsg model

        NavigateTo route ->
            ( model, Navigation.newUrl (reverseRoute route) )


updateForm : Inventory.Form.Msg.Msg -> Model -> ( Model, Cmd Msg )
updateForm msg model =
    let
        ( newFormModel, formCmd ) =
            Inventory.Form.Update.update msg model.formModel
    in
        ( { model | formModel = newFormModel }, Cmd.map FormMsg formCmd )

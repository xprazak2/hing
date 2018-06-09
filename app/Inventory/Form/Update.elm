module Inventory.Form.Update exposing (update)

import Http
import Navigation
import RemoteData exposing (WebData)
import Routing.RequestHelpers exposing (errorToString)
import Routing.Routes exposing (reverseRoute)
import Inventory.Model exposing (Inventory)
import Inventory.Form.Model exposing (FormModel, FormInputField)
import Inventory.Form.Msg exposing (Msg(..))
import Inventory.RouteHelpers exposing (inventoryRoute)
import Inventory.Request


update : Msg -> FormModel -> ( FormModel, Cmd Msg )
update msg formModel =
    case msg of
        NameInput string ->
            ( updateFormField "name" string formModel, Cmd.none )

        Submit ->
            ( { formModel | submitting = True }, Inventory.Request.saveInventory formModel )

        CreateInventory inventory ->
            createInventory inventory formModel


createInventory : WebData Inventory -> FormModel -> ( FormModel, Cmd Msg )
createInventory inventoryData formModel =
    case inventoryData of
        RemoteData.Success inventory ->
            ( { formModel | submitting = False }
            , reverseRoute (inventoryRoute inventory.id) |> Navigation.newUrl
            )

        RemoteData.Failure err ->
            ( addFormErrors err formModel, Cmd.none )

        _ ->
            ( formModel, Cmd.none )


addFormErrors : Http.Error -> FormModel -> FormModel
addFormErrors errors formModel =
    { formModel | serverError = errorToString errors, submitting = False }


updateFormField : String -> String -> FormModel -> FormModel
updateFormField fieldName newValue formModel =
    let
        updatedFields =
            List.map (mapField fieldName newValue) formModel.fields
    in
        { formModel | fields = updatedFields }


mapField : String -> String -> FormInputField -> FormInputField
mapField name newValue field =
    if field.fieldName == name then
        { field | value = newValue }
    else
        field

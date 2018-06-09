module Inventory.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Events.Extra exposing (onClickPreventDefault)
import Date exposing (Date)
import Date.Format exposing (format)
import RemoteData exposing (WebData)
import Inventory.Routes exposing (Route(..))
import Inventory.RouteHelpers exposing (..)
import Inventory.Model exposing (Inventory, Inventories, Model)
import Inventory.Msg exposing (Msg(..))
import Inventory.Form.Msg
import Inventory.Form.Model exposing (FormModel)
import Routing.Helpers exposing (..)
import Routing.Routes
import Modal.View
import Modal.Msg


navigateBtn : String -> Routing.Routes.Route -> String -> Html Msg
navigateBtn label route classes =
    button ([ class ("ink-button " ++ classes) ] ++ (Routing.Helpers.linkAttrs route NavigateTo)) [ text label ]


link : String -> Routing.Routes.Route -> Html Msg
link label route =
    a (Routing.Helpers.linkAttrs route NavigateTo)
        [ text label ]


view : Route -> Model -> Html Msg
view route model =
    case route of
        InventoriesRoute ->
            viewInventories model

        InventoryNewRoute ->
            viewNew model.formModel

        InventoryShowRoute id ->
            viewShow model.inventory


viewShow : WebData Inventory -> Html Msg
viewShow inventoryData =
    case inventoryData of
        RemoteData.NotAsked ->
            div [] [ text "" ]

        RemoteData.Loading ->
            div [] [ text "Loading..." ]

        RemoteData.Success inventory ->
            viewShowInventory inventory

        RemoteData.Failure error ->
            div [] [ text (toString error) ]


viewShowInventory : Inventory -> Html Msg
viewShowInventory inventory =
    div [ class "top-space" ]
        [ div [ class "column-group" ]
            [ div [ class "all-50" ]
                [ h2 [] [ text inventory.name ]
                , Html.form [ class "ink-form" ]
                    [ div [ class "control-group column-group gutters" ]
                        [ label [ for "name", class "all-20 align-right" ] [ text "Name" ]
                        , div [ class "control all-80" ]
                            [ div [] [ text inventory.name ] ]
                        ]
                    , div [ class "control-group column-group gutters" ]
                        [ label [ for "id", class "all-20 align-right" ] [ text "ID" ]
                        , div [ class "control all-80" ]
                            [ div [] [ text inventory.id ] ]
                        ]
                    , div [ class "control-group column-group gutters" ]
                        [ label [ for "id", class "all-20 align-right" ] [ text "Created At" ]
                        , div [ class "control all-80" ]
                            [ div [] [ text (formatDate inventory.createdAt) ] ]
                        ]
                    , div [ class "control-group column-group gutters" ]
                        [ label [ for "id", class "all-20 align-right" ] [ text "Updated At" ]
                        , div [ class "control all-80" ]
                            [ div [] [ text (formatDate inventory.updatedAt) ] ]
                        ]
                    ]
                ]
            ]
        ]


nestedOnInput : (String -> Inventory.Form.Msg.Msg) -> Attribute Msg
nestedOnInput msg =
    Html.Attributes.map FormMsg (onInput msg)


formDisabled : FormModel -> Bool
formDisabled formModel =
    formModel.submitting || formModel.errored


viewNew : FormModel -> Html Msg
viewNew formModel =
    div [ class "top-space" ]
        [ div [ class "column-group" ]
            [ div [ class "all-50" ]
                [ h2 [] [ text "New Inventory" ]
                , Html.form [ class "ink-form", onSubmit (FormMsg Inventory.Form.Msg.Submit) ]
                    [ div [ class "control-group required" ]
                        [ label [ for "name" ] [ text "Name" ]
                        , div [ class "control" ]
                            [ input
                                [ id "name"
                                , name "name"
                                , type_ "text"
                                , value (Inventory.Form.Model.formFieldValue "name" formModel)
                                , nestedOnInput Inventory.Form.Msg.NameInput
                                ]
                                []
                            ]
                        ]
                    , div [ class "control-group button-toolbar" ]
                        [ div [ class "button-group" ]
                            [ button
                                [ type_ "submit"
                                , class "ink-button blue"
                                , disabled (formDisabled formModel)
                                ]
                                [ text "Submit" ]
                            ]
                        , div [ class "button-group" ]
                            [ navigateBtn "Cancel" inventoriesRoute "" ]
                        ]
                    ]
                ]
            ]
        ]


viewInventories : Model -> Html Msg
viewInventories model =
    div [ class "top-space" ]
        [ div [ class "column-group" ]
            [ div []
                [ h2 [] [ text "Inventories" ]
                , navigateBtn "New Inventory" newInventoryRoute "push-right"
                ]
            ]
        , Modal.View.view model.modalModel |> Html.map ModalMsg
        , div [ class "column-group red" ]
            [ table [ class "ink-table alternating" ]
                [ thead []
                    [ tr []
                        [ th [ class "align-left" ] [ text "Name" ]
                        , th [ class "align-left" ] [ text "Id" ]
                        , th [ class "align-left" ] [ text "Created At" ]
                        , th [ class "align-left" ] [ text "Updated At" ]
                        , th [ class "align-left" ] [ text "Action" ]
                        ]
                    ]
                , tbody [] (showRows model.inventories)
                ]
            ]
        ]


showRows : WebData Inventories -> List (Html Msg)
showRows inventoriesData =
    case inventoriesData of
        RemoteData.NotAsked ->
            [ text "" ]

        RemoteData.Loading ->
            [ text "Loading..." ]

        RemoteData.Success inventories ->
            List.map inventoryRow inventories

        RemoteData.Failure error ->
            [ text (toString error) ]


inventoryRow : Inventory -> Html Msg
inventoryRow inventory =
    tr []
        [ td []
            [ link inventory.name (inventoryRoute inventory.id) ]
        , td []
            [ text inventory.id ]
        , td []
            [ text (formatDate inventory.createdAt) ]
        , td []
            [ text (formatDate inventory.updatedAt) ]
        , td []
            [ deleteLink ]
        ]


deleteLink : Html Msg
deleteLink =
    a [ onClickPreventDefault (ModalMsg Modal.Msg.Open) ]
        [ text "Delete" ]


formatDate : Date -> String
formatDate date =
    format "%d/%m/%Y at %H:%M:%S" date

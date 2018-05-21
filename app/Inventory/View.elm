module Inventory.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Date exposing (Date)
import Date.Format exposing (format)
import RemoteData exposing (WebData)
import Inventory.Routes exposing (Route(..))
import Inventory.Model exposing (Inventory, Inventories, Msg(..), Model, InventoryBase)
import Routing.Helpers
import Routing.Routes


navigateBtn : String -> Routing.Routes.Route -> String -> Html Msg
navigateBtn label route classes =
    button ([ class ("ink-button " ++ classes) ] ++ (Routing.Helpers.linkAttrs route NavigateTo)) [ text label ]


view : Route -> Model -> Html Msg
view route model =
    case route of
        InventoriesRoute ->
            viewInventories model.inventories

        InventoryNewRoute ->
            viewNew model.inventoryNew


viewNew : InventoryBase -> Html Msg
viewNew inventory =
    div []
        [ div [ class "column-group" ]
            [ div [ class "top-space all-50" ]
                [ h2 [] [ text "New Inventory" ]
                , Html.form [ class "ink-form" ]
                    [ div [ class "control-group required" ]
                        [ label [ for "name" ] [ text "Name" ]
                        , div [ class "control" ]
                            [ input [ id "name", name "name", type_ "text" ] [] ]
                        ]
                    , div [ class "control-group button-toolbar" ]
                        [ div [ class "button-group" ]
                            [ button [ type_ "submit", class "ink-button blue" ] [ text "Submit" ] ]
                        , div [ class "button-group" ]
                            [ navigateBtn "Cancel" inventoriesRoute "" ]
                        ]
                    ]
                ]
            ]
        ]


inventoriesRoute : Routing.Routes.Route
inventoriesRoute =
    Routing.Routes.InventoryRoute Inventory.Routes.InventoriesRoute


newInventoryRoute : Routing.Routes.Route
newInventoryRoute =
    Routing.Routes.InventoryRoute Inventory.Routes.InventoryNewRoute


viewInventories : WebData Inventories -> Html Msg
viewInventories inventories =
    div []
        [ div [ class "column-group" ]
            [ div [ class "top-space" ]
                [ h2 [] [ text "Inventories" ]
                , navigateBtn "New Inventory" newInventoryRoute "push-right"
                ]
            ]
        , div [ class "column-group" ]
            [ table [ class "ink-table alternating" ]
                [ thead []
                    [ tr []
                        [ th [ class "align-left" ] [ text "Name" ]
                        , th [ class "align-left" ] [ text "Id" ]
                        , th [ class "align-left" ] [ text "Created At" ]
                        , th [ class "align-left" ] [ text "Updated At" ]
                        ]
                    ]
                , tbody [] (showRows inventories)
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
            [ text inventory.name ]
        , td []
            [ text inventory.id ]
        , td []
            [ text (formatDate inventory.createdAt) ]
        , td []
            [ text (formatDate inventory.updatedAt) ]
        ]


formatDate : Date -> String
formatDate date =
    format "%d/%m/%Y at %H:%M:%S" date

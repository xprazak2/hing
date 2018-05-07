module Inventory.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Date exposing (Date)
import Date.Format exposing (format)
import RemoteData exposing (WebData)
import Inventory.Msg exposing (Msg(..))
import Inventory.Model exposing (Inventory, Inventories)


view : WebData Inventories -> Html Msg
view inventories =
    div []
        [ div [ class "column-group" ]
            [ div [ class "top-space" ]
                [ button [ class "ink-button push-right" ] [ text "New Inventory" ]
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

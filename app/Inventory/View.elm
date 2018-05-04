module Inventory.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Inventory.Model exposing (Inventories, Inventory)
import Date exposing (Date)
import Date.Format exposing (format)


type Msg
    = None


view : Inventories -> Html Msg
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
                , tbody [] (List.map inventoryRow inventories)
                ]
            ]
        ]


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

module Inventory.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Inventory.Model exposing (Msg(..))


view : Html Msg
view =
    div []
        [ div [ class "column-group" ]
            [ div [ class "top-space" ]
                [ button [ class "ink-button push-right" ]
                    [ a [ href "#" ] [ text "New List" ]
                    ]
                ]
            ]
        , div [ class "column-group" ]
            [ table [ class "ink-table alternating" ]
                [ thead []
                    [ tr []
                        [ th [ class "align-left" ] [ text "Name" ]
                        , th [ class "align-left" ] [ text "Created At" ]
                        , th [ class "align-left" ] [ text "Actions" ]
                        ]
                    ]
                , tbody []
                    [ rows ]
                ]
            ]
        ]


rows : Html Msg
rows =
    div [] []

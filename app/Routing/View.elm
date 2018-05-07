module Routing.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Events.Extra exposing (onClickPreventDefault)
import Routing.Model exposing (Model, Route(..), reverseRoute)
import Routing.Msg exposing (Msg(..))
import Home.View
import Inventory.View


view : Model -> Html Msg
view model =
    div []
        [ navbar
        , div [ class "ink-grid" ] [ showPage model ]
        ]


showPage : Model -> Html Msg
showPage model =
    case model.route of
        HomeRoute ->
            Html.map HomeMsg Home.View.view

        InventoriesRoute ->
            Html.map InventoryMsg (Inventory.View.view model.inventoryModel.inventories)

        NotFoundRoute ->
            div [] [ text "NotFound!" ]


navbar : Html Msg
navbar =
    nav [ class "ink-navigation" ]
        [ ul [ class "menu horizontal blue" ]
            [ li []
                [ viewLink HomeRoute "Home" ]
            , li []
                [ viewLink InventoriesRoute "Inventories" ]
            ]
        ]


viewLink : Route -> String -> Html Msg
viewLink route name =
    a [ href (reverseRoute route), onClickPreventDefault (NavigateTo route) ]
        [ text name ]

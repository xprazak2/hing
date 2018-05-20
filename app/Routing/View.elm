module Routing.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Events.Extra exposing (onClickPreventDefault)
import Routing.Model exposing (Model)
import Routing.Routes exposing (Route(..), reverseRoute)
import Routing.Msg exposing (Msg(..))
import Home.View
import Inventory.View
import Inventory.Routes


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

        InventoryRoute route ->
            Html.map InventoryMsg (Inventory.View.view route model.inventoryModel)

        NotFoundRoute ->
            div [] [ text "NotFound!" ]


navbar : Html Msg
navbar =
    nav [ class "ink-navigation" ]
        [ ul [ class "menu horizontal blue" ]
            [ li []
                [ viewLink HomeRoute "Home" ]
            , li []
                [ viewLink (InventoryRoute Inventory.Routes.InventoriesRoute) "Inventories" ]
            ]
        ]


viewLink : Route -> String -> Html Msg
viewLink route name =
    a [ href (reverseRoute route), onClickPreventDefault (NavigateTo route) ]
        [ text name ]

module Routing exposing (..)

import Navigation exposing (Location)
import UrlParser exposing (oneOf, s, (</>), map, top, parsePath, Parser, parseHash)
import Home.Model
import Home.Msg


--import Home.View

import Inventory.Model


--import Inventory.View

import Inventory.Msg


type alias Model =
    { homeModel : Home.Model.Model
    , inventoryModel : Inventory.Model.Model
    }


init : Location -> ( Model, Cmd Msg )
init location =
    let
        ( homeModel, homeCmd ) =
            Home.Model.init

        ( inventoryModel, inventoryCmd ) =
            Inventory.Model.init
    in
        ( { homeModel = homeModel
          , inventoryModel = inventoryModel
          }
        , Cmd.none
        )


type Msg
    = LocationChanged Location
    | NavigateTo Route
    | HomeMsg Home.Msg.Msg
    | InventoryMsg Inventory.Msg.Msg


parseLocation : Location -> Route
parseLocation location =
    case (parsePath matchRoute location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute


matchRoute : Parser (Route -> a) a
matchRoute =
    oneOf
        [ map HomeRoute top
        , map InventoriesRoute (s "inventories")
        ]


type Route
    = HomeRoute
    | InventoriesRoute
    | NotFoundRoute

module Routing exposing (..)

import Navigation exposing (Location)
import UrlParser exposing (oneOf, s, (</>), map, top, parsePath, Parser, parseHash)


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


reverseRoute : Route -> String
reverseRoute route =
    case route of
        HomeRoute ->
            "/"

        InventoriesRoute ->
            "/inventories"

        NotFoundRoute ->
            "/notfound"


type Route
    = HomeRoute
    | InventoriesRoute
    | NotFoundRoute

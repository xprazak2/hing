module Routing exposing (..)

import Navigation exposing (Location)
import UrlParser exposing (oneOf, s, (</>), map, top, parsePath, Parser, parseHash)


parseLocation : Location -> Route
parseLocation location =
    case (parsePath matchRoute location) of
        Just route ->
            route

        Nothing ->
            NotFound


matchRoute : Parser (Route -> a) a
matchRoute =
    oneOf
        [ map Home top
        , map Inventories (s "inventories")
        ]


reverseRoute : Route -> String
reverseRoute route =
    case route of
        Home ->
            "/"

        Inventories ->
            "/inventories"

        NotFound ->
            "/notfound"


type Route
    = Home
    | Inventories
    | NotFound


modifyUrl : Route -> Cmd msg
modifyUrl =
    reverseRoute >> Navigation.modifyUrl


setUrl : Route -> Cmd msg
setUrl route =
    Navigation.newUrl (reverseRoute route)

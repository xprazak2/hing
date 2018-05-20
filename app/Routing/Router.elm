module Routing.Router exposing (..)

import Navigation exposing (Location)
import UrlParser exposing (oneOf, s, (</>), map, top, parsePath, Parser)
import Routing.Model exposing (Model)
import Routing.Routes exposing (Route(..), reverseRoute)
import Routing.Msg exposing (Msg(..))
import Home.Model
import Inventory.Model
import Inventory.Init
import Inventory.Routes exposing (inventoryRouteMatcher)


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            parseLocation location

        initModel =
            { homeModel = Home.Model.initialState
            , inventoryModel = Inventory.Model.initialState
            , route = currentRoute
            }
    in
        initSubmodules currentRoute initModel


initSubmodules : Route -> Model -> ( Model, Cmd Msg )
initSubmodules route model =
    case route of
        HomeRoute ->
            initHome model

        InventoryRoute inventoryRoute ->
            initInventory model inventoryRoute

        NotFoundRoute ->
            ( model, Cmd.none )


initHome : Model -> ( Model, Cmd Msg )
initHome model =
    let
        ( newHomeModel, homeCmd ) =
            Home.Model.init
    in
        ( { model | homeModel = newHomeModel }, Cmd.map HomeMsg homeCmd )


initInventory : Model -> Inventory.Routes.Route -> ( Model, Cmd Msg )
initInventory model inventoryRoute =
    let
        ( newInventoryModel, inventoryCmd ) =
            Inventory.Init.init inventoryRoute model.inventoryModel
    in
        ( { model | inventoryModel = newInventoryModel }, Cmd.map InventoryMsg inventoryCmd )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LocationChanged location ->
            let
                updatedRoute =
                    parseLocation location

                ( updatedModel, updatedCmd ) =
                    initSubmodules updatedRoute model
            in
                ( { updatedModel | route = updatedRoute }, updatedCmd )

        NavigateTo route ->
            ( model, Navigation.newUrl (reverseRoute route) )

        HomeMsg homeMsg ->
            updateHome model homeMsg

        InventoryMsg inventoryMsg ->
            updateInventory model inventoryMsg


updateHome : Model -> Home.Model.Msg -> ( Model, Cmd Msg )
updateHome model homeMsg =
    let
        ( newHomeModel, homeCmd ) =
            Home.Model.update homeMsg model.homeModel
    in
        ( { model | homeModel = newHomeModel }, Cmd.map HomeMsg homeCmd )


updateInventory : Model -> Inventory.Model.Msg -> ( Model, Cmd Msg )
updateInventory model inventoryMsg =
    let
        ( newInventoryModel, inventoryCmd ) =
            Inventory.Model.update inventoryMsg model.inventoryModel
    in
        ( { model | inventoryModel = newInventoryModel }, Cmd.map InventoryMsg inventoryCmd )


parseLocation : Location -> Route
parseLocation location =
    case (parsePath matchRoute location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute



--matchRoute : Parser (Route -> a) a
--matchRoute =
--    oneOf
--        [ map HomeRoute top
--        , map InventoriesRoute (UrlParser.s "inventories")
--        ]


matchRoute : Parser (Route -> a) a
matchRoute =
    oneOf
        (routeMatcher
            ++ (List.map (\parser -> map InventoryRoute parser) inventoryRouteMatcher)
        )


routeMatcher : List (Parser (Route -> a) a)
routeMatcher =
    [ map HomeRoute top ]

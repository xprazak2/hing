module Routing.Router exposing (..)

import Navigation exposing (Location)
import UrlParser exposing (oneOf, s, (</>), map, top, parsePath, Parser, parseHash)
import Routing.Model exposing (Model, Route(..), reverseRoute)
import Routing.Msg exposing (Msg(..))
import Home.Model
import Home.Msg
import Inventory.Model
import Inventory.Msg


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

        InventoriesRoute ->
            initInventory model

        NotFoundRoute ->
            ( model, Cmd.none )


initHome : Model -> ( Model, Cmd Msg )
initHome model =
    let
        ( newHomeModel, homeCmd ) =
            Home.Model.init
    in
        ( { model | homeModel = newHomeModel }, Cmd.map HomeMsg homeCmd )


initInventory : Model -> ( Model, Cmd Msg )
initInventory model =
    let
        ( newInventoryModel, inventoryCmd ) =
            Inventory.Model.init
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


updateHome : Model -> Home.Msg.Msg -> ( Model, Cmd Msg )
updateHome model homeMsg =
    let
        ( newHomeModel, homeCmd ) =
            Home.Model.update homeMsg model.homeModel
    in
        ( { model | homeModel = newHomeModel }, Cmd.map HomeMsg homeCmd )


updateInventory : Model -> Inventory.Msg.Msg -> ( Model, Cmd Msg )
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


matchRoute : Parser (Route -> a) a
matchRoute =
    oneOf
        [ map HomeRoute top
        , map InventoriesRoute (UrlParser.s "inventories")
        ]

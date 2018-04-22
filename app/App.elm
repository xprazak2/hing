module App exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Events.Extra exposing (onClickPreventDefault)
import Navigation exposing (Location)
import Routing exposing (Route)
import Home.View as HomeView
import Inventory.View as InventoryView
import Inventory.Model exposing (Inventory, InventoryState, initInventory)


type Page
    = Home
    | NotFound
    | ErrorPage PageLoadError
    | Inventories Inventory.Model


type ActivePage
    = Other
    | Inventories


type PageState
    = Loaded Page
    | TransitioningFrom Page


type PageLoadError
    = PageLoadError PageLoadErrorPayload


pageLoadError : ActivePage -> String -> PageLoadError
pageLoadError activePage string =
    PageLoadError { activePage = activePage, errorMessage = string }


type alias PageLoadErrorPayload =
    { activePage : ActivePage
    , errorMessage : String
    }


type alias Model =
    { pageState : PageState
    }


initialPage : Page
initialPage =
    Home


init : Location -> ( Model, Cmd Msg )
init location =
    setRoute (Routing.parseLocation location) { pageState = Loaded initialPage }


getCurrentPage : PageState -> Page
getCurrentPage pageState =
    case pageState of
        Loaded page ->
            page

        TransitioningFrom page ->
            page


pageErrored : Model -> ActivePage -> String -> ( Model, Cmd Msg )
pageErrored model activePage errorMsg =
    let
        error =
            pageLoadError activePage errorMsg
    in
        ( { model | pageState = Loaded (ErrorPage error) }, Cmd.none )


setRoute : Route -> Model -> ( Model, Cmd Msg )
setRoute route model =
    let
        transition toMsg task =
            ( { model | pageState = TransitioningFrom (getCurrentPage model.pageState) }, Task.attempt toMsg task )

        errored =
            pageErrored model
    in
        case route of
            Route.NotFound ->
                ( { model | pageState = Loaded NotFound }, Cmd.none )

            Route.Home ->
                ( model, Routing.modifyUrl Route.Home )


type Msg
    = LocationChanged Location
    | NavigateTo Route
    | HomeMsg HomeView.Msg
    | InventoryMsg InventoryView.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        LocationChanged location ->
            ( { model | currentRoute = Routing.parseLocation location }, Cmd.none )

        NavigateTo route ->
            ( model, Navigation.newUrl (Routing.reverseRoute route) )

        HomeMsg _ ->
            ( model, Cmd.none )

        InventoryMsg _ ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ navbar
        , showPage model
        ]


showPage : Model -> Html Msg
showPage model =
    case model.currentRoute of
        HomeRoute ->
            Html.map HomeMsg HomeView.view

        ListsRoute ->
            Html.map InventoryMsg InventoryView.view

        NotFoundRoute ->
            div [] [ text "NotFound!" ]


navbar : Html Msg
navbar =
    nav [ class "ink-navigation" ]
        [ ul [ class "menu horizontal blue" ]
            [ li []
                [ viewLink HomeRoute "Home" ]
            , li []
                [ viewLink ListsRoute "Inventories" ]
            ]
        ]


viewLink : Route -> String -> Html Msg
viewLink route name =
    a [ href (Routing.reverseRoute route), onClickPreventDefault (NavigateTo route) ]
        [ text name ]

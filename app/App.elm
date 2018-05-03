module App exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Events.Extra exposing (onClickPreventDefault)
import Navigation exposing (Location)
import Routing exposing (Route(..))
import Home.View as HomeView
import Home.Model
import Inventory.View as InventoryView
import Inventory.Model exposing (Inventory, Inventories)
import Task exposing (Task)
import Debug
import PageError exposing (PageLoadError(..))


type PageState
    = Loaded Page
    | TransitioningFrom Page


type Page
    = NotFoundPage
    | ErrorPage PageLoadError
    | HomePage
    | InventoriesPage


type alias Model =
    { pageState : PageState
    }


initialModel : Route -> Model
initialModel route =
    { pageState = Loaded HomePage
    }


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location
    in
        routeChanged currentRoute (initialModel currentRoute)


type Msg
    = RouteChanged Route
    | NavigateTo Route
    | HomeMsg HomeView.Msg
    | InventoryMsg InventoryView.Msg
    | InventoriesPageLoaded (Result PageLoadError Inventories)


routeChanged : Route -> Model -> ( Model, Cmd Msg )
routeChanged route model =
    case route of
        HomeRoute ->
            ( { model | pageState = Loaded HomePage }, Cmd.none )

        InventoriesRoute ->
            ( { model | pageState = TransitioningFrom (getCurrentPage model.pageState) }
            , Task.attempt InventoriesPageLoaded Inventory.Model.load
            )

        NotFoundRoute ->
            ( { model | pageState = Loaded NotFoundPage }, Cmd.none )


getCurrentPage : PageState -> Page
getCurrentPage pageState =
    case pageState of
        Loaded page ->
            page

        TransitioningFrom page ->
            page


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        RouteChanged route ->
            routeChanged route model

        NavigateTo route ->
            ( model, Navigation.newUrl (Routing.reverseRoute route) )

        HomeMsg _ ->
            ( model, Cmd.none )

        InventoryMsg _ ->
            ( model, Cmd.none )

        InventoriesPageLoaded (Ok inventories) ->
            ( { model | pageState = Loaded (InventoriesPage) }, Cmd.none )

        InventoriesPageLoaded (Err error) ->
            ( { model | pageState = Loaded (ErrorPage error) }, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ navbar
        , viewPage model
        ]


viewPage : Model -> Html Msg
viewPage model =
    case model.pageState of
        Loaded page ->
            showPage page

        TransitioningFrom page ->
            showSpinner


showSpinner : Html Msg
showSpinner =
    div [] [ text "Loading..." ]


showPage : Page -> Html Msg
showPage page =
    case page of
        NotFoundPage ->
            div [] [ text "NotFound!" ]

        HomePage ->
            Html.map HomeMsg HomeView.view

        InventoriesPage ->
            Html.map InventoryMsg InventoryView.view

        ErrorPage loadError ->
            div [] [ text (PageError.pageLoadErrorToString loadError) ]


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
    a [ href (Routing.reverseRoute route), onClickPreventDefault (NavigateTo route) ]
        [ text name ]

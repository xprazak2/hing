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


type PageState
    = Loaded Page
    | TransitioningFrom Page


type Page
    = HomePage
    | InventoriesPage



--type alias PageAttrs pageModel =
--    { route : Route
--    , model : PageModel pageModel
--    , urlCreator : Page -> String
--    }
--HomePage { route = HomeRoute, model = "", urlCreator = \_ -> "/" }


type alias Model =
    { currentRoute : Route
    , pageState : PageState
    }


initialModel : Route -> Model
initialModel route =
    { currentRoute = route
    , pageState = Loaded HomePage
    }


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location
    in
        ( initialModel currentRoute, Cmd.none )


type Msg
    = RouteChanged Route
    | NavigateTo Route
    | HomeMsg HomeView.Msg
    | InventoryMsg InventoryView.Msg


setRoute : Route -> Model -> ( Model, Cmd Msg )
setRoute route model =
    ( model, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        RouteChanged route ->
            ( { model | currentRoute = route }, Cmd.none )

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

        InventoriesRoute ->
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
                [ viewLink InventoriesRoute "Inventories" ]
            ]
        ]


viewLink : Route -> String -> Html Msg
viewLink route name =
    a [ href (Routing.reverseRoute route), onClickPreventDefault (NavigateTo route) ]
        [ text name ]

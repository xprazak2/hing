module App exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Events.Extra exposing (onClickPreventDefault)
import Navigation exposing (Location)
import Routing exposing (Route(..))
import Home.View as HomeView
import Inventory.View as InventoryView


type alias Model =
    { currentRoute : Route
    }


initialModel : Route -> Model
initialModel route =
    { currentRoute = route }


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location
    in
        ( initialModel currentRoute, Cmd.none )


type Msg
    = None
    | LocationChanged Location
    | NavigateTo Route
    | HomeMsg HomeView.Msg
    | InventoryMsg InventoryView.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        None ->
            ( model, Cmd.none )

        LocationChanged location ->
            ( { model | currentRoute = Routing.parseLocation location }, Cmd.none )

        NavigateTo route ->
            ( model, Navigation.newUrl (reverseRoute route) )

        HomeMsg _ ->
            ( model, Cmd.none )

        InventoryMsg _ ->
            ( model, Cmd.none )


reverseRoute : Route -> String
reverseRoute route =
    case route of
        HomeRoute ->
            "/"

        InventoriesRoute ->
            "/inventories"

        NotFoundRoute ->
            "/notfound"


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
    a [ href (reverseRoute route), onClickPreventDefault (NavigateTo route) ]
        [ text name ]

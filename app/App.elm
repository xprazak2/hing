module App exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Events.Extra exposing (onClickPreventDefault)
import Navigation exposing (Location)
import Routing exposing (Route(..))
import Home.View as HomeView
import List.View as ListView


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
    | ListMsg ListView.Msg


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

        ListMsg _ ->
            ( model, Cmd.none )


reverseRoute : Route -> String
reverseRoute route =
    case route of
        HomeRoute ->
            "/"

        ListsRoute ->
            "/lists"

        NotFoundRoute ->
            "/notfound"


view : Model -> Html Msg
view model =
    div []
        [ navbar
        , showPage model

        --, h1 []
        --    [ text "Elm Webpack Starter, featuring hot-loading" ]
        --, p [] [ text "Click on the button below to increment the state." ]
        --, p [] [ text "Then make a change to the source code and see how the state is retained after you recompile." ]
        --, p []
        --    [ text "And now don't forget to add a star to the Github repo "
        --    , a [ href "https://github.com/simonh1000/elm-webpack-starter" ] [ text "elm-webpack-starter" ]
        --    ]
        ]


showPage : Model -> Html Msg
showPage model =
    case model.currentRoute of
        HomeRoute ->
            Html.map HomeMsg HomeView.view

        ListsRoute ->
            Html.map ListMsg ListView.view

        NotFoundRoute ->
            div [] [ text "NotFound!" ]


navbar : Html Msg
navbar =
    nav [ class "ink-navigation" ]
        [ ul [ class "menu horizontal blue" ]
            [ li []
                [ viewLink HomeRoute "Home" ]
            , li []
                [ viewLink ListsRoute "Lists" ]
            ]
        ]


viewLink : Route -> String -> Html Msg
viewLink route name =
    a [ href (reverseRoute route), onClickPreventDefault (NavigateTo route) ]
        [ text name ]

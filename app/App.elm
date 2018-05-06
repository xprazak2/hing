module App exposing (..)

import Html exposing (Html)


--import Html.Attributes exposing (..)
--import Html.Events exposing (..)
--import Html.Events.Extra exposing (onClickPreventDefault)

import Navigation exposing (Location)
import Routing.Router as Router exposing (..)
import Routing.Model exposing (Route(..))
import Routing.Msg
import Routing.View


--import Home.View as HomeView
--import Inventory.View as InventoryView
--import Home.Msg
--import Inventory.Msg


type alias Model =
    { currentRoute : Route
    , location : Location
    , state : State
    }


type State
    = NotReady
    | Ready Routing.Model.Model


init : Location -> ( Model, Cmd Msg )
init location =
    ( { state = NotReady
      , location = location
      , currentRoute = Router.parseLocation location
      }
    , Cmd.none
    )


type Msg
    = LocationChanged Location
    | NavigateTo Route
    | RoutingMsg Routing.Msg.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        LocationChanged location ->
            ( { model | currentRoute = Router.parseLocation location }, Cmd.none )

        NavigateTo route ->
            ( model, Navigation.newUrl (Routing.Model.reverseRoute route) )

        RoutingMsg _ ->
            ( model, Cmd.none )


routerUpdate : Model -> Routing.Msg.Msg -> ( Model, Cmd Msg )
routerUpdate model routingMsg =
    case model.state of
        Ready routingModel ->
            let
                ( newRoutingModel, routingCmd ) =
                    Router.update routingMsg routingModel
            in
                ( { model | state = Ready newRoutingModel }, Cmd.map RoutingMsg routingCmd )

        NotReady ->
            Debug.crash "Ooops. We got a sub-component message even though it wasn't supposed to be initialized?!?!?"


view : Model -> Html Msg
view model =
    case model.state of
        Ready routerModel ->
            Routing.View.view routerModel
                |> Html.map RoutingMsg

        NotReady ->
            Html.text "Loading"

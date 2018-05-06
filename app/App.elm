module App exposing (..)

import Html exposing (Html)
import Task exposing (Task)
import Navigation exposing (Location)
import Routing.Router as Router exposing (..)
import Routing.Model exposing (Route(..))
import Routing.Msg exposing (Msg(LocationChanged))
import Routing.View


type alias Model =
    { location : Location
    , state : State
    }


type State
    = NotReady
    | Ready Routing.Model.Model


init : Location -> ( Model, Cmd Msg )
init location =
    ( { state = NotReady
      , location = location
      }
    , Task.perform ApplicationLoad (Task.succeed location)
    )


type Msg
    = LocationChanged Location
    | ApplicationLoad Location
    | RoutingMsg Routing.Msg.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        LocationChanged location ->
            routerUpdate { model | location = location } (Routing.Msg.LocationChanged location)

        ApplicationLoad location ->
            let
                ( newState, cmd ) =
                    Router.init location
            in
                ( { model | state = Ready newState }, Cmd.map RoutingMsg cmd )

        RoutingMsg routingMsg ->
            routerUpdate model routingMsg


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

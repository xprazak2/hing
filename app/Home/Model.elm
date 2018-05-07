module Home.Model exposing (..)

import Home.Msg exposing (Msg(..))


type alias Model =
    String


initialState : Model
initialState =
    "Empty value"


init : ( Model, Cmd Msg )
init =
    ( "Initialized value", Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )

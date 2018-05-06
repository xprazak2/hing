module Home.Model exposing (..)

import Home.Msg exposing (Msg(..))


type alias Model =
    String


init : ( Model, Cmd Msg )
init =
    ( "Initial value", Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )

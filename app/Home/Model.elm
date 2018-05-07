module Home.Model exposing (..)


type alias Model =
    String


type Msg
    = None


initialState : Model
initialState =
    "Empty value"


init : ( Model, Cmd Msg )
init =
    ( "Initialized value", Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )

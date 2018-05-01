module Home.Model exposing (..)


type Msg
    = NoneMsg


type alias HomeModel =
    String


update : Msg -> HomeModel -> ( HomeModel, Cmd Msg )
update msg model =
    ( model, Cmd.none )

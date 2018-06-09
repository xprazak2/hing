module Modal.Update exposing (update)

import Modal.Model exposing (Model)
import Modal.Msg exposing (Msg(..))


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        Open ->
            ( { model | opened = True }, Cmd.none )

        Close ->
            ( { model | opened = False }, Cmd.none )

        Working ->
            ( model, Cmd.none )

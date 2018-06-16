module Modal.Update exposing (update)

import Modal.Model exposing (Model, SubmitPayload(..))
import Modal.Msg exposing (Msg(..))


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        Open payload ->
            ( { model | opened = True, submitPayload = payload }, Cmd.none )

        Close ->
            ( { model | opened = False, submitPayload = Modal.Model.Nothing }, Cmd.none )

        Submit confirmMsg ->
            ( model, Cmd.none )

        IsWorking value ->
            ( { model | working = value }, Cmd.none )

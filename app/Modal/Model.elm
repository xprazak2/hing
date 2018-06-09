module Modal.Model exposing (Model, initialState)


type alias Model =
    { opened : Bool }


initialState : Model
initialState =
    { opened = False }

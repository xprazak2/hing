module Modal.Model exposing (..)


type SubmitPayload
    = Payload String
    | Nothing


type alias Model =
    { opened : Bool
    , working : Bool
    , submitPayload : SubmitPayload
    }


initialState : Model
initialState =
    { opened = False
    , working = False
    , submitPayload = Nothing
    }

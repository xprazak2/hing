module Modal.Msg exposing (..)

import Modal.Model exposing (SubmitPayload(..))


type Msg
    = Open SubmitPayload
    | Close
    | Submit SubmitPayload
    | IsWorking Bool

module Inventory.Form.Model exposing (..)

import Debug
import List.Extra


type alias FormModel =
    { fields : List FormInputField
    , submitting : Bool
    , errored : Bool
    , serverError : String
    }


type alias FormInputField =
    { fieldName : String
    , value : String
    , errors : List String
    }


initFormInputField : String -> FormInputField
initFormInputField fieldName =
    FormInputField fieldName "" []


initFormModel : FormModel
initFormModel =
    { fields = [ initFormInputField "name" ]
    , submitting = False
    , errored = False
    , serverError = ""
    }


formFieldByName : String -> FormModel -> FormInputField
formFieldByName name formModel =
    let
        foundField =
            List.Extra.find (\field -> field.fieldName == name) formModel.fields
    in
        case foundField of
            Just field ->
                field

            Nothing ->
                Debug.crash "BadProgrammingError: You are trying to find nonexisting field in form"


formFieldValue : String -> FormModel -> String
formFieldValue name formModel =
    (formFieldByName name formModel).value

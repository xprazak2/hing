module Inventory.Form exposing (..)

import Debug
import List.Extra


type Msg
    = NameInput String
    | Submit


type alias FormModel =
    { fields : List FormInputField
    , submitting : Bool
    , errored : Bool
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
    { fields = [ initFormInputField "name" ], submitting = False, errored = False }


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


update : Msg -> FormModel -> ( FormModel, Cmd Msg )
update msg model =
    case msg of
        NameInput string ->
            ( updateFormField "name" string model, Cmd.none )

        --( { model | name = string }, Cmd.none )
        Submit ->
            ( model, Cmd.none )


updateFormField : String -> String -> FormModel -> FormModel
updateFormField fieldName newValue formModel =
    let
        updatedFields =
            List.map (mapField fieldName newValue) formModel.fields
    in
        { formModel | fields = updatedFields }


mapField : String -> String -> FormInputField -> FormInputField
mapField name newValue field =
    if field.fieldName == name then
        { field | value = newValue }
    else
        field

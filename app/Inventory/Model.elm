module Inventory.Model exposing (..)

import Date exposing (Date)
import Navigation
import RemoteData exposing (WebData)
import Routing.Routes exposing (Route, reverseRoute)
import Inventory.Form exposing (..)


type Msg
    = LoadInventories (WebData Inventories)
    | LoadInventory (WebData Inventory)
    | FormMsg Inventory.Form.Msg
    | NavigateTo Route


type alias Model =
    { inventories : WebData Inventories
    , formModel : FormModel
    , inventory : WebData Inventory
    }


type alias Inventory =
    { id : String
    , name : String
    , createdAt : Date
    , updatedAt : Date
    }


type alias Inventories =
    List Inventory


initialState : Model
initialState =
    { inventories = RemoteData.NotAsked
    , formModel = initFormModel
    , inventory = RemoteData.NotAsked
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LoadInventories inventories ->
            ( { model | inventories = inventories }, Cmd.none )

        LoadInventory inventory ->
            ( { model | inventory = inventory }, Cmd.none )

        FormMsg formMsg ->
            updateForm formMsg model

        NavigateTo route ->
            ( model, Navigation.newUrl (reverseRoute route) )


updateForm : Inventory.Form.Msg -> Model -> ( Model, Cmd Msg )
updateForm msg model =
    let
        ( newFormModel, formCmd ) =
            Inventory.Form.update msg model.formModel
    in
        ( { model | formModel = newFormModel }, Cmd.map FormMsg formCmd )

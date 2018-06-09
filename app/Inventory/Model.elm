module Inventory.Model exposing (..)

import Date exposing (Date)
import RemoteData exposing (WebData)
import Inventory.RouteHelpers exposing (..)
import Inventory.Form.Model exposing (..)
import Modal.Model


type alias Model =
    { inventories : WebData Inventories
    , formModel : FormModel
    , inventory : WebData Inventory
    , modalModel : Modal.Model.Model
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
    , modalModel = Modal.Model.initialState
    }

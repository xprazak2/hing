module Routing.Helpers exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events.Extra exposing (onClickPreventDefault)
import Routing.Routes exposing (Route(..), reverseRoute)


--viewLink : Route -> String -> Html msg
--viewLink route name =
--    a [ href (reverseRoute route), onClickPreventDefault (NavigateTo route) ]
--        [ text name ]


linkAttrs : Route -> (Route -> msg) -> List (Attribute msg)
linkAttrs route navigateMsg =
    [ href (reverseRoute route), onClickPreventDefault (navigateMsg route) ]

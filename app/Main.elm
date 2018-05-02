module Main exposing (main)

import Html
import Navigation
import App exposing (init, update, view, Msg(RouteChanged), Model)
import Routing


main : Program Never Model Msg
main =
    Navigation.program (Routing.parseLocation >> RouteChanged)
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }

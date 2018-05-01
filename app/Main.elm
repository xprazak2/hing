module Main exposing (main)

import Html
import Navigation
import Routing
import App exposing (init, update, view, Msg(SetRoute), Model)


main : Program Never Model Msg
main =
    Navigation.program (Routing.parseLocation >> SetRoute)
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }

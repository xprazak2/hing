module Main exposing (main)

import Html
import Navigation
import App exposing (init, update, view, Msg(LocationChanged), Model)


main : Program Never Model Msg
main =
    Navigation.program LocationChanged
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }

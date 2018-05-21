module Home.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Home.Model exposing (Msg(..))


view : Html Msg
view =
    div []
        [ div [ class "column-group" ]
            [ div [ class "top-space" ]
                [ h2 [] [ text "Home" ]
                , p [] [ text "This is home" ]
                ]
            ]
        ]

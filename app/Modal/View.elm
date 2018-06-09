module Modal.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Modal.Model exposing (Model)
import Modal.Msg exposing (Msg(..))


view : Model -> Html Msg
view model =
    div [ modalState model |> class ]
        [ div
            [ class "ink-modal fade"
            , attribute "data-width" "80%"
            , attribute "data-height" "80%"
            , attribute "aria-hiden" "true"
            , attribute "aria-labelled-by" "modal-title"
            ]
            [ div [ class "modal-header" ]
                [ button [ class "modal-close ink-dismiss" ]
                    [ h3 [] [ text "Modal header" ] ]
                ]
            , div [ class "modal-body", id "modalContent" ]
                [ h4 [] [ text "Modal text" ] ]
            , div [ class "modal-footer" ]
                [ div [ class "push-right" ]
                    [ button [ class "ink-button caution ink-dismiss" ] [ text "Close" ] ]
                ]
            ]
        ]


modalState : Model -> String
modalState model =
    let
        classes =
            "ink-shade fade "
    in
        if model.opened then
            classes ++ " visible modal-visible"
        else
            classes ++ " modal-invisible"

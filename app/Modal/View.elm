module Modal.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Html.Events.Extra exposing (onClickPreventDefault)
import Modal.Model exposing (Model, SubmitPayload(..))
import Modal.Msg exposing (Msg(..))
import Routing.Msg


view : Model -> Routing.Msg.Msg -> Html Msg
view model confirmMsg =
    div [ modalState model |> class ]
        [ div
            [ class "ink-modal fade"
            , attribute "data-width" "80%"
            , attribute "data-height" "80%"
            , attribute "aria-hiden" "true"
            , attribute "aria-labelled-by" "modal-title"
            ]
            [ div [ class "modal-header" ]
                [ button [ class "modal-close ink-dismiss", onClick Close ] []
                , h3 [] [ text "Modal header" ]
                ]
            , div [ class "modal-body", id "modalContent" ]
                [ h4 [] [ text "Modal text" ] ]
            , div [ class "footer-container" ]
                []
            , div [ class "modal-footer" ]
                [ div [ class "push-right" ]
                    [ button [ class "ink-button caution ink-dismiss", onClick (Submit confirmMsg) ] [ text "Close" ] ]
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

module Routing.RequestHelpers exposing (..)

import Http


errorToString : Http.Error -> String
errorToString err =
    case err of
        Http.BadUrl string ->
            "BadUrl: " ++ string

        Http.Timeout ->
            "Network timeout"

        Http.NetworkError ->
            "Network Error"

        Http.BadStatus response ->
            responseMsg response

        Http.BadPayload string response ->
            (responseMsg response) ++ "\n Details: " ++ string


responseMsg : Http.Response body -> String
responseMsg response =
    (toString response.status.code)
        ++ " "
        ++ response.status.message
        ++ " "
        ++ (toString response.body)

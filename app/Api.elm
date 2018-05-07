module Api exposing (api)


api : String -> String
api resourcePath =
    "http://localhost:3000/api" ++ resourcePath

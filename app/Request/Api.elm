module Request.Api exposing (apiUrl)


apiUrl : String -> String
apiUrl path =
    "http://localhost:3000" ++ path

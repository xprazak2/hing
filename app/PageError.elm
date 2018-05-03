module PageError exposing (..)


type PageLoadError
    = PageLoadError Model


type alias Model =
    { errorMessage : String
    }


newPageLoadError : String -> PageLoadError
newPageLoadError errorMessage =
    PageLoadError { errorMessage = errorMessage }


pageLoadErrorToString : PageLoadError -> String
pageLoadErrorToString pageLoadError =
    case pageLoadError of
        PageLoadError payload ->
            payload.errorMessage

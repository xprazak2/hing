module Page exposing (PageLoadError(..), pageLoadError, ActivePage(..))


type ActivePage
    = OtherPageActive
    | InventoriesPageActive


type PageLoadError
    = PageLoadError PageLoadErrorPayload


type alias PageLoadErrorPayload =
    { activePage : ActivePage
    , errorMessage : String
    }


pageLoadError : ActivePage -> String -> PageLoadError
pageLoadError activePage string =
    PageLoadError { activePage = activePage, errorMessage = string }

module App exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Events.Extra exposing (onClickPreventDefault)
import Navigation exposing (Location)
import Task
import Routing exposing (Route(..))
import Page exposing (PageLoadError(..), pageLoadError, ActivePage(..))
import Home.View as HomeView
import Home.Model
import Inventory.View as InventoryView
import Inventory.Model exposing (Inventory, Inventories)


type Page
    = HomePage Home.Model.HomeModel
    | NotFoundPage
    | ErrorPage PageLoadError
    | InventoriesPage Inventory.Model.Inventories


pageFrame : ActivePage -> Html Msg -> Html Msg
pageFrame activePage content =
    div []
        [ navbar
        , content
        ]


type PageState
    = Loaded Page
    | TransitioningFrom Page


type alias Model =
    { pageState : PageState
    }


initialPage : Page
initialPage =
    HomePage "Welcome home"


init : Location -> ( Model, Cmd Msg )
init location =
    setRoute (Routing.parseLocation location) { pageState = Loaded initialPage }


getCurrentPage : PageState -> Page
getCurrentPage pageState =
    case pageState of
        Loaded page ->
            page

        TransitioningFrom page ->
            page


pageErrored : Model -> ActivePage -> String -> ( Model, Cmd Msg )
pageErrored model activePage errorMsg =
    let
        error =
            pageLoadError activePage errorMsg
    in
        ( { model | pageState = Loaded (ErrorPage error) }, Cmd.none )


setRoute : Route -> Model -> ( Model, Cmd Msg )
setRoute route model =
    let
        transition toMsg task =
            ( { model | pageState = TransitioningFrom (getCurrentPage model.pageState) }
            , Cmd.batch
                [ Task.attempt toMsg task ]
            )

        errored =
            pageErrored model
    in
        case route of
            Routing.NotFound ->
                ( { model | pageState = Loaded NotFoundPage }, Cmd.none )

            Routing.Home ->
                ( { model | pageState = Loaded (HomePage "Placeholder") }, Cmd.none )

            Routing.Inventories ->
                transition InventoriesLoaded Inventory.Model.init


type Msg
    = SetRoute Route
    | HomeMsg Home.Model.Msg
    | InventoryMsg Inventory.Model.Msg
    | InventoriesLoaded (Result PageLoadError Inventories)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    updatePage (getCurrentPage model.pageState) msg model


updatePage : Page -> Msg -> Model -> ( Model, Cmd Msg )
updatePage page msg model =
    let
        toPage toModel toMsg subUpdate subMsg subModel =
            let
                ( newModel, newCmd ) =
                    subUpdate subMsg subModel
            in
                ( { model | pageState = Loaded (toModel newModel) }, Cmd.map toMsg newCmd )
    in
        case ( msg, page ) of
            ( SetRoute route, _ ) ->
                setRoute route model

            ( InventoriesLoaded (Ok subModel), _ ) ->
                ( { model | pageState = Loaded (InventoriesPage subModel) }, Cmd.none )

            ( InventoriesLoaded (Err error), _ ) ->
                ( { model | pageState = Loaded (ErrorPage error) }, Cmd.none )

            ( HomeMsg subMsg, HomePage subModel ) ->
                toPage HomePage HomeMsg Home.Model.update subMsg subModel

            ( InventoryMsg subMsg, InventoriesPage subModel ) ->
                toPage InventoriesPage InventoryMsg Inventory.Model.update subMsg subModel

            ( _, NotFoundPage ) ->
                ( model, Cmd.none )

            ( _, _ ) ->
                ( model, Cmd.none )


view : Model -> Html Msg
view model =
    case model.pageState of
        Loaded page ->
            viewPage False page

        TransitioningFrom page ->
            viewPage True page


viewPage : Bool -> Page -> Html Msg
viewPage loading page =
    if loading then
        viewLoadingPage page
    else
        viewLoadedPage page


viewLoadingPage : Page -> Html Msg
viewLoadingPage page =
    div []
        [ text "Loading" ]


viewLoadedPage : Page -> Html Msg
viewLoadedPage page =
    case page of
        NotFoundPage ->
            pageFrame Page.OtherPageActive notFoundView

        ErrorPage loadError ->
            pageFrame Page.OtherPageActive (loadErrorView loadError)

        HomePage _ ->
            HomeView.view |> Html.map HomeMsg |> pageFrame Page.OtherPageActive

        InventoriesPage _ ->
            InventoryView.view |> Html.map InventoryMsg |> pageFrame Page.InventoriesPageActive


notFoundView : Html Msg
notFoundView =
    div []
        [ text "Not Found" ]


loadErrorView : PageLoadError -> Html Msg
loadErrorView loadError =
    case loadError of
        PageLoadError payload ->
            div [] [ text payload.errorMessage ]


navbar : Html Msg
navbar =
    nav [ class "ink-navigation" ]
        [ ul [ class "menu horizontal blue" ]
            [ li []
                [ viewLink Routing.Home "Home" ]
            , li []
                [ viewLink Routing.Inventories "Inventories" ]
            ]
        ]


viewLink : Route -> String -> Html Msg
viewLink route name =
    a [ href (Routing.reverseRoute route), onClickPreventDefault (SetRoute route) ]
        [ text name ]

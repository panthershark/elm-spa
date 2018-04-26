module Main exposing (main)

import Api.Cmds as Api
import Api.Models exposing (AppDrawer(AppDrawerNone), Page, PageModel, User(Authenticating))
import Html exposing (Html, div, text)
import Html.Attributes exposing (class, id)
import Http
import Navigation exposing (Location)
import Pages.Home as HomePage
import Pages.NotFound as NotFoundPage
import Routing
import Util exposing (getErrorMsg)
import Views.Util exposing (viewSpinner)


-- APP


type PageData
    = HomeData (PageModel HomePage.Model)
    | BootStrappingData (PageModel Page)
    | NotFoundData (PageModel NotFoundPage.Model)
    | AuthErrorData String


type alias Model =
    { page : PageData
    , location : Location
    }


type Msg
    = OnLocationChange Location
    | Authenticate (Result Http.Error User)
    | HomeMessage HomePage.Msg
    | NotFoundMessage NotFoundPage.Msg


getPageData : PageData -> Page
getPageData data =
    case data of
        HomeData cached ->
            { user = cached.user
            , drawer = cached.drawer
            }

        NotFoundData cached ->
            { user = cached.user
            , drawer = cached.drawer
            }

        AuthErrorData err ->
            { user = Authenticating
            , drawer = AppDrawerNone
            }

        BootStrappingData cached ->
            { user = cached.user
            , drawer = cached.drawer
            }


locationChange : Location -> Model -> ( Model, Cmd Msg )
locationChange location model =
    let
        route =
            Routing.parseLocation location
    in
    case route of
        Routing.HomeRoute ->
            let
                ( mod, cmd ) =
                    HomePage.init <|
                        getPageData model.page
            in
            { model
                | page = HomeData mod
                , location = location
            }
                ! [ Cmd.map HomeMessage cmd ]

        Routing.NotFoundRoute ->
            let
                ( mod, cmd ) =
                    NotFoundPage.init location.href <|
                        getPageData model.page
            in
            { model
                | page = NotFoundData mod
                , location = location
            }
                ! [ Cmd.map NotFoundMessage cmd ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnLocationChange location ->
            locationChange location model

        Authenticate result ->
            case result of
                Ok user ->
                    locationChange model.location { model | page = BootStrappingData (Page user AppDrawerNone) }

                Err reason ->
                    { model | page = AuthErrorData (Maybe.withDefault "Auth Failed" <| getErrorMsg reason) } ! []

        NotFoundMessage submsg ->
            case model.page of
                NotFoundData data ->
                    let
                        ( page, cmd ) =
                            NotFoundPage.update submsg data
                    in
                    { model | page = NotFoundData page }
                        ! [ Cmd.map NotFoundMessage cmd ]

                _ ->
                    model ! []

        HomeMessage submsg ->
            case model.page of
                HomeData data ->
                    let
                        ( page, cmd ) =
                            HomePage.update submsg data
                    in
                    { model | page = HomeData page }
                        ! [ Cmd.map HomeMessage cmd ]

                _ ->
                    model ! []


init : Location -> ( Model, Cmd Msg )
init location =
    { page = BootStrappingData (Page Authenticating AppDrawerNone)
    , location = location
    }
        ! [ Api.authenticate Authenticate ]



-- subscriptions


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- view rendering


viewPage : Model -> Html Msg
viewPage model =
    case model.page of
        BootStrappingData _ ->
            viewBootstrap

        AuthErrorData err ->
            viewAuthError err

        HomeData mod ->
            Html.map HomeMessage (HomePage.view mod)

        NotFoundData mod ->
            Html.map NotFoundMessage (NotFoundPage.view mod)


view : Model -> Html Msg
view model =
    viewPage model


viewAuthError : String -> Html Msg
viewAuthError err =
    text err


viewBootstrap : Html Msg
viewBootstrap =
    div [ class "container bootstrap_loader" ]
        [ viewSpinner
        ]



-- start the program


main : Program Never Model Msg
main =
    Navigation.program OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

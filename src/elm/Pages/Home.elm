module Pages.Home exposing (Model, Msg, init, update, view)

import Api.Models exposing (AppDrawer(AppDrawerNone), Page, PageModel, User(Authenticated, Guest))
import Date
import Html exposing (Html, a, div, p, text)
import Html.Attributes exposing (class, href, id, style)
import Html.Events exposing (onClick)
import Nav.Menus as Menus
import Nav.NavBar as NavBar
import Nav.SideNav as SideNav
import Navigation
import Task
import Time exposing (Time)
import Util exposing (attributeList)
import Views.TimeStamp as TimeStamp


type Msg
    = UpdateTime Time
    | SetDrawer AppDrawer
    | NavigateTo String


type alias Model =
    { hello : String
    , current_time : Time
    }


init : Page -> ( PageModel Model, Cmd Msg )
init cached =
    { user = cached.user
    , drawer = cached.drawer
    , current_time = 0
    , hello = "Hola"
    }
        ! [ Task.perform UpdateTime Time.now ]


update : Msg -> PageModel Model -> ( PageModel Model, Cmd Msg )
update action model =
    case action of
        NavigateTo url ->
            model ! [ Navigation.newUrl url ]

        SetDrawer d ->
            { model | drawer = d } ! []

        UpdateTime t ->
            { model | current_time = t } ! []


view : PageModel Model -> Html Msg
view { user, current_time, drawer, hello } =
    let
        strHello =
            case user of
                Authenticated person ->
                    hello ++ " " ++ person.full_name ++ "!"

                _ ->
                    hello ++ " world"
    in
    div
        (attributeList
            [ ( id "main", True )
            , ( onClick (SetDrawer AppDrawerNone), SideNav.isMobileExpanded drawer )
            ]
        )
        [ NavBar.view SetDrawer user drawer
        , div [ class "row" ]
            [ div [ class "col s2 main_nav show-on-medium-and-up" ] [ Menus.view ]
            , div [ class "col s12 m10 main_content" ]
                [ div [ class "section white main_card" ]
                    [ p [] [ text strHello ]
                    , p [] [ text <| TimeStamp.toDateString (Date.fromTime current_time) ]
                    ]
                ]
            ]
        , SideNav.mobileWrapper user drawer Menus.view
        ]

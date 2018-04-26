module Pages.NotFound exposing (Model, Msg, init, update, view)

import Api.Models exposing (AppDrawer, Page, PageModel)
import DomEvents exposing (onAnchorClick)
import Html exposing (Html, a, div, h1, text)
import Html.Attributes exposing (class, href)
import Nav.Menus as Menus
import Nav.NavBar as NavBar
import Nav.SideNav as SideNav
import Navigation


type Msg
    = NavigateTo String
    | SetDrawer AppDrawer


type alias Model =
    { url : String
    }


init : String -> Page -> ( PageModel Model, Cmd Msg )
init url cached =
    { user = cached.user
    , drawer = cached.drawer
    , url = url
    }
        ! []


update : Msg -> PageModel Model -> ( PageModel Model, Cmd msg )
update action model =
    case action of
        NavigateTo url ->
            model ! [ Navigation.newUrl url ]

        SetDrawer d ->
            { model | drawer = d } ! []


view : PageModel Model -> Html Msg
view { url, user, drawer } =
    div []
        [ NavBar.view SetDrawer user drawer
        , div [ class "container" ]
            [ div [ class "row" ]
                [ h1 [] [ text <| "NOT FOUND: " ++ url ]
                , a
                    [ href "/elm_starter/home"
                    , onAnchorClick <| NavigateTo "/elm_starter/home"
                    , class "btn-flat"
                    ]
                    [ text "Take me home" ]
                ]
            , SideNav.mobileWrapper user drawer Menus.view
            ]
        ]

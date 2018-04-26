module Nav.NavBar exposing (view)

import Api.Models exposing (AppDrawer(AppDrawerDefault, AppDrawerNone), User(Authenticated))
import DomEvents exposing (onClickPreventDefault)
import Html exposing (Html, a, div, i, img, li, nav, text, ul)
import Html.Attributes exposing (class, href, src)


viewUser : User -> Html msg
viewUser user =
    case user of
        Authenticated person ->
            a [ href "#", class "avatar valign-wrapper dropdown-button" ]
                [ img [ src person.avatar, class "circle" ] []
                ]

        _ ->
            a [ href "#" ] [ text "Sign In" ]


navWrapper : Html msg -> Html msg -> Html msg
navWrapper hamburguesa avatar =
    nav []
        [ div [ class "nav-wrapper" ]
            [ ul [ class "left" ]
                [ li [ class "hide-on-med-and-up" ] [ hamburguesa ]
                , li [] [ text "ELM SINGLE PAGE APP" ]
                ]
            , ul [ class "right" ]
                [ li []
                    [ avatar
                    ]
                ]
            ]
        ]


view : (AppDrawer -> msg) -> User -> AppDrawer -> Html msg
view msgHamburguesa user drawer =
    let
        menu_msg =
            case drawer of
                AppDrawerNone ->
                    msgHamburguesa AppDrawerDefault

                _ ->
                    msgHamburguesa AppDrawerNone
    in
    navWrapper
        (a [ href "#", onClickPreventDefault menu_msg ] [ i [ class "material-icons" ] [ text "menu" ] ])
        (viewUser user)

module Nav.SideNav exposing (isMobileExpanded, mobileWrapper)

import Api.Models exposing (AppDrawer(AppDrawerDefault, AppDrawerNone), User(Authenticated))
import Html exposing (Html, div, text)
import Html.Attributes exposing (class, classList)


isMobileExpanded : AppDrawer -> Bool
isMobileExpanded d =
    d /= AppDrawerNone


mobileWrapper : User -> AppDrawer -> Html msg -> Html msg
mobileWrapper user drawer menu_content =
    let
        str_title =
            case user of
                Authenticated person ->
                    person.full_name

                _ ->
                    "Elm Demo"
    in
    div []
        [ div [ classList [ ( "side-nav z-depth-3", True ), ( "expanded", isMobileExpanded drawer ) ] ]
            [ div [ class "side_nav" ]
                [ div [ class "row side_nav_header" ]
                    [ div [ class "title" ] [ text str_title ]
                    ]
                , menu_content
                ]
            ]
        ]

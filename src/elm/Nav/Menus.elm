module Nav.Menus exposing (view)

import Html exposing (Html, li, text, ul)
import Html.Attributes exposing (class)


view : Html msg
view =
    ul [ class "collection side_nav_items" ]
        [ li [ class "collection-item" ] [ text "Item 1" ]
        , li [ class "collection-item" ] [ text "Item 2" ]
        , li [ class "collection-item" ] [ text "Item 3" ]
        ]

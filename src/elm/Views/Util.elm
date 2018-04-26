module Views.Util exposing (cardWrapper, flipWrapper, modalWrapper, viewSpinner)

import Html exposing (Html, div, text)
import Html.Attributes exposing (class, classList)


modalWrapper : List (Html msg) -> List (Html msg) -> Html msg
modalWrapper content actions =
    div [ class "modal" ]
        [ div [ class "modal_wrap" ]
            [ div [ class "row" ] [ div [ class "col s12" ] content ]
            , div [ class "row" ] actions
            ]
        ]


cardWrapper : List (Html msg) -> List (Html msg) -> Html msg
cardWrapper content actions =
    let
        actionbar =
            case List.length actions == 0 of
                True ->
                    text ""

                False ->
                    div [ class "card-action" ] [ div [ class "row" ] actions ]
    in
    div [ class "card z-depth-1" ]
        [ div [ class "card-content" ] content
        , actionbar
        ]


viewSpinner : Html msg
viewSpinner =
    div [ class "row" ]
        [ div [ class "col s12 center" ]
            [ div [ class "preloader-wrapper big active" ]
                [ div [ class "spinner-layer spinner-blue" ]
                    [ div [ class "circle-clipper left" ]
                        [ div [ class "circle" ]
                            []
                        ]
                    , div [ class "gap-patch" ]
                        [ div [ class "circle" ]
                            []
                        ]
                    , div [ class "circle-clipper right" ]
                        [ div [ class "circle" ]
                            []
                        ]
                    ]
                , div [ class "spinner-layer spinner-red" ]
                    [ div [ class "circle-clipper left" ]
                        [ div [ class "circle" ]
                            []
                        ]
                    , div [ class "gap-patch" ]
                        [ div [ class "circle" ]
                            []
                        ]
                    , div [ class "circle-clipper right" ]
                        [ div [ class "circle" ]
                            []
                        ]
                    ]
                , div [ class "spinner-layer spinner-yellow" ]
                    [ div [ class "circle-clipper left" ]
                        [ div [ class "circle" ]
                            []
                        ]
                    , div [ class "gap-patch" ]
                        [ div [ class "circle" ]
                            []
                        ]
                    , div [ class "circle-clipper right" ]
                        [ div [ class "circle" ]
                            []
                        ]
                    ]
                , div [ class "spinner-layer spinner-green" ]
                    [ div [ class "circle-clipper left" ]
                        [ div [ class "circle" ]
                            []
                        ]
                    , div [ class "gap-patch" ]
                        [ div [ class "circle" ]
                            []
                        ]
                    , div [ class "circle-clipper right" ]
                        [ div [ class "circle" ]
                            []
                        ]
                    ]
                ]
            ]
        ]


flipWrapper : String -> Html msg -> Html msg -> Bool -> Html msg
flipWrapper css_selector front back flipped =
    div [ class css_selector ]
        [ div [ classList [ ( "flip", True ), ( "flipped", flipped ) ] ]
            [ div [ class "front" ] [ front ]
            , div [ class "back" ] [ back ]
            ]
        ]

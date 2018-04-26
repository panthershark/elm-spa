module DomEvents exposing (onAnchorClick, onClickPreventDefault)

import Html exposing (Attribute)
import Html.Events exposing (Options, onWithOptions)
import Json.Decode as Json exposing (Decoder)


onAnchorClick : a -> Attribute a
onAnchorClick message =
    onWithOptions "click"
        (Options False True)
        (preventDefault2
            |> Json.andThen (maybePreventDefault message)
        )


preventDefault2 : Decoder Bool
preventDefault2 =
    Json.map2
        invertedOr
        (Json.field "ctrlKey" Json.bool)
        (Json.field "metaKey" Json.bool)


maybePreventDefault : msg -> Bool -> Decoder msg
maybePreventDefault msg preventDefault =
    case preventDefault of
        True ->
            Json.succeed msg

        False ->
            Json.fail "Normal link"


invertedOr : Bool -> Bool -> Bool
invertedOr x y =
    not (x || y)


onClickPreventDefault : a -> Attribute a
onClickPreventDefault msg =
    onWithOptions "click"
        { stopPropagation = True
        , preventDefault = True
        }
        (Json.succeed msg)

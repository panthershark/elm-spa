module Util exposing (attributeList, getErrorMsg, publicPath)

import Html exposing (Attribute)
import Http exposing (Error(BadPayload, BadStatus, BadUrl, NetworkError, Timeout))


publicPath : String
publicPath =
    "elm-spa"


getErrorMsg : Http.Error -> Maybe String
getErrorMsg err =
    case err of
        Timeout ->
            Just "The application didn't respond."

        NetworkError ->
            Just "Unable to connect to the application."

        BadUrl _ ->
            Just "Uh oh. Looks like a developer messed up. :("

        BadPayload msg _ ->
            Just <| "Parsing error. " ++ msg

        BadStatus res ->
            Just res.body


attributeList : List ( Attribute msg, Bool ) -> List (Attribute msg)
attributeList alist =
    List.filterMap
        (\( attr, bool ) ->
            case bool of
                True ->
                    Just attr

                False ->
                    Nothing
        )
        alist

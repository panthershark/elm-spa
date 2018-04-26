module Api.Coders exposing (decodePerson, decodeUser)

import Api.Models exposing (Person, User(Authenticated, Guest))
import Json.Decode exposing (Decoder, andThen, at, map, null, oneOf, string, succeed)
import Json.Decode.Pipeline exposing (decode, hardcoded, required)
import Util exposing (publicPath)


decodePerson : Decoder Person
decodePerson =
    (decode Person
        |> required "id" string
        |> required "first_name" string
        |> required "last_name" string
        |> hardcoded ""
        |> hardcoded ""
        |> hardcoded ""
    )
        |> andThen
            (\p ->
                succeed
                    { p
                        | full_name = p.first_name ++ " " ++ p.last_name
                        , href = "/" ++ publicPath ++ "/person/profile/" ++ p.id
                        , avatar = "/" ++ publicPath ++ "/person/avatar/" ++ p.id
                    }
            )


decodeUser : Decoder User
decodeUser =
    oneOf [ map Just decodePerson, null Nothing ]
        |> at [ "person" ]
        |> andThen
            (\p ->
                case p of
                    Just person ->
                        succeed <| Authenticated person

                    Nothing ->
                        succeed Guest
            )

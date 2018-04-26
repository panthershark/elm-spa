module Api.Cmds exposing (authenticate)

import Api.Coders exposing (decodeUser)
import Api.Models exposing (User)
import Http
import Util exposing (publicPath)


-- API CALLS


authenticate : (Result Http.Error User -> msg) -> Cmd msg
authenticate msg =
    Http.send msg <|
        Http.get ("/" ++ publicPath ++ "/api/user/current") decodeUser

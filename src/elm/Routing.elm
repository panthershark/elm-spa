module Routing exposing (Route(HomeRoute, NotFoundRoute), parseLocation)

import Navigation exposing (Location)
import UrlParser exposing ((</>), Parser, map, oneOf, parsePath, s)
import Util exposing (publicPath)


type Route
    = HomeRoute
    | NotFoundRoute


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map HomeRoute (s publicPath </> s "home")
        ]


parseLocation : Location -> Route
parseLocation location =
    case parsePath matchers location of
        Just route ->
            route

        Nothing ->
            NotFoundRoute

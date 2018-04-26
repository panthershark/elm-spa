module Api.Models
    exposing
        ( AppDrawer(AppDrawerDefault, AppDrawerNone)
        , Page
        , PageModel
        , Person
        , User
            ( Authenticated
            , Authenticating
            , Guest
            )
        )


type alias Person =
    { id : String
    , first_name : String
    , last_name : String
    , full_name : String
    , href : String
    , avatar : String
    }


type User
    = Authenticating
    | Authenticated Person
    | Guest


type AppDrawer
    = AppDrawerDefault
    | AppDrawerNone



{-
   Put things that are common for all pages in Page.
-}


type alias Page =
    { user : User
    , drawer : AppDrawer
    }


type alias PageModel p =
    { p
        | user : User
        , drawer : AppDrawer
    }

module UI exposing (layout)

import Gen.Route as Route exposing (Route)
import Html exposing (Html, a, header, main_, text)
import Html.Attributes exposing (class, href)


layout : List (Html msg) -> List (Html msg)
layout children =
    let
        viewLink : String -> Route -> Html msg
        viewLink label route =
            a [ href <| Route.toHref route ] [ text label ]
    in
    [ header [ class "navbar" ]
        [ viewLink "Home" Route.Home_
        , viewLink "Projects" Route.Projects
        ]
    , main_ [] children
    ]

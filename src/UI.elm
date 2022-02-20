module UI exposing (layout)

import Gen.Route as Route exposing (Route)
import Html exposing (Html, a, button, div, header, main_, nav, text)
import Html.Attributes exposing (attribute, class, classList, href, id)


isRoute : Route -> Route -> Bool
isRoute route compare =
    case ( route, compare ) of
        ( Route.Home_, Route.Home_ ) ->
            True

        ( Route.Projects, Route.Projects ) ->
            True

        ( Route.Playground, Route.Playground ) ->
            True

        _ ->
            False


layout : Route -> Maybe Int -> List (Html msg) -> List (Html msg)
layout route clr children =
    let
        viewLink : String -> Route -> Bool -> Html msg
        viewLink label routes marginLeft =
            a
                [ href <| Route.toHref routes
                , class "main-header__links"
                , classList
                    [ ( "main-header__links--current-page"
                      , isRoute route routes
                      )
                    , ( "main-header__links--margin-left", marginLeft )
                    ]
                ]
                [ text label ]
    in
    [ div [ id "root", attribute "style" <| "--clr-brand: " ++ String.fromInt (Maybe.withDefault 9 clr) ]
        [ header [ class "main-header" ]
            [ nav [ class "main-header__nav" ]
                [ viewLink "Home" Route.Home_ False
                , viewLink "Projects" Route.Projects True
                , viewLink "Playground" Route.Playground False
                ]
            ]
        , main_ [] children
        ]
    ]

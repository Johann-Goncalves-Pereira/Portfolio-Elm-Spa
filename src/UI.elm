module UI exposing (layout)

import Gen.Route as Route exposing (Route)
import Html exposing (Html, a, button, div, header, main_, nav, text)
import Html.Attributes exposing (attribute, class, classList, href, id, style)


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


viewLink : Route -> String -> Route -> Bool -> Html msg
viewLink route linkText routes hasMarginLeft =
    a
        [ href <| Route.toHref routes
        , class "main-header__links"
        , classList
            [ ( "main-header__links--current-page"
              , isRoute route routes
              )
            , ( "main-header__links--margin-left", hasMarginLeft )
            ]
        ]
        [ text linkText ]


layout :
    { route : Route
    , pageMainColor : Maybe Int
    , pageName : String
    , mousePos : Maybe { posX : Float, posY : Float }
    , mainTagContent : List (Html msg)
    }
    -> List (Html msg)
layout model =
    [ div
        [ id "root"
        , classList [ ( "scroll", True ), ( "root--" ++ model.pageName, True ) ]
        , "--clr-brand: "
            ++ String.fromInt (Maybe.withDefault 90 model.pageMainColor)
            |> attribute "style"
        ]
        [ --
          case model.mousePos of
            Just mousePos ->
                div
                    [ "--screenMousePosX:"
                        ++ String.fromFloat mousePos.posX
                        ++ "--screenMousePosY:"
                        ++ String.fromFloat mousePos.posY
                        |> attribute "style"
                    ]
                    []

            Nothing ->
                text ""
        , header [ class "main-header" ]
            [ nav [ class "main-header__nav" ]
                [ viewLink model.route "Home" Route.Home_ False
                , viewLink model.route "Projects" Route.Projects True
                , viewLink model.route "Playground" Route.Playground False
                ]
            ]
        , main_ [ class <| "main main--" ++ model.pageName ] model.mainTagContent
        ]
    ]

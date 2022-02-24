module UI exposing (UIConfig, defaultConfig, layout)

import Gen.Route as Route exposing (Route)
import Html exposing (Attribute, Html, a, button, div, header, main_, nav, text)
import Html.Attributes exposing (attribute, class, classList, href, id, style)



-- Model


type alias UIConfig msg =
    { route : Route
    , pageName : String
    , pageMainColor : Maybe Int
    , mousePos : Maybe { posX : Float, posY : Float }
    , mainTagContent : List (Html msg)
    , mainTagAttrs : List (Attribute msg)
    }


type alias Link msg =
    { routeStatic : Route
    , routeReceived : UIConfig msg
    , routeName : String
    , hasMarginLeft : Bool
    }


defaultLink : Link msg
defaultLink =
    { routeStatic = Route.Home_
    , routeReceived = defaultConfig
    , routeName = ""
    , hasMarginLeft = False
    }


defaultConfig : UIConfig msg
defaultConfig =
    { route = Route.Home_
    , pageName = ""
    , pageMainColor = Nothing
    , mousePos = Nothing
    , mainTagContent = []
    , mainTagAttrs = []
    }



-- Structure


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



-- View


viewLink : Link msg -> Html msg
viewLink model =
    a
        [ href <| Route.toHref model.routeStatic
        , class "main-header__links"
        , classList
            [ ( "main-header__links--current-page"
              , isRoute model.routeReceived.route model.routeStatic
              )
            , ( "main-header__links--margin-left", model.hasMarginLeft )
            ]
        ]
        [ text model.routeName ]


layout : UIConfig msg -> List (Html msg)
layout model =
    let
        mainClass : Attribute msg
        mainClass =
            class <| "main--" ++ model.pageName
    in
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
                [ viewLink
                    { defaultLink
                        | routeName = "Home"
                        , routeReceived = model
                        , routeStatic = Route.Home_
                    }
                , viewLink
                    { routeName = "Projects"
                    , routeReceived = model
                    , routeStatic = Route.Projects
                    , hasMarginLeft = True
                    }
                , viewLink
                    { defaultLink
                        | routeName = "Playground"
                        , routeReceived = model
                        , routeStatic = Route.Playground
                    }
                ]
            ]
        , main_ (mainClass :: model.mainTagAttrs) model.mainTagContent
        ]
    ]

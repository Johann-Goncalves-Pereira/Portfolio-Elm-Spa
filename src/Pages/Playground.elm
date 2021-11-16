module Pages.Playground exposing (Model, Msg, page)

import Gen.Params.Playground exposing (Params)
import Gen.Route as Route exposing (Route)
import Html exposing (Html, a, article, br, button, div, h1, input, label, li, main_, option, p, pre, section, select, span, text, ul)
import Html.Attributes exposing (attribute, checked, class, href, id, type_)
import Html.Events exposing (onClick)
import Page
import Request
import Shared
import UI
import View exposing (View)


page : Shared.Model -> Request.With Params -> Page.With Model Msg
page shared req =
    Page.sandbox
        { init = init
        , update = update
        , view = view
        }



-- INIT


type alias Model =
    { route : Route
    , isSpinning : Bool
    }


init : Model
init =
    { route = Route.Playground
    , isSpinning = False
    }



-- UPDATE


type Msg
    = Spin


update : Msg -> Model -> Model
update msg model =
    case msg of
        Spin ->
            { model | isSpinning = not model.isSpinning }



-- VIEW


view : Model -> View Msg
view model =
    { title = "Johann - Playground"
    , body =
        UI.layout model.route
            [ viewMainContent
            , viewContainerOne model
            ]
    }


viewMainContent : Html Msg
viewMainContent =
    article [ class "main-playground" ]
        [ h1 [ class "main-playground__title" ]
            [ text "This is my playground"
            ]
        , p []
            [ "Always when I want to do test, prototype, construct, build or "
                ++ "just have some fun, I will came here to test my skills."
                |> text
            ]
        ]


viewContainerOne : Model -> Html Msg
viewContainerOne model =
    let
        addAnimation =
            if model.isSpinning then
                "animate"

            else
                ""
    in
    div [ class "playground play-one" ]
        [ section [ class "light-container play-one__container" ]
            [ div [ class "play-one__container--flex" ]
                [ viewOneLightToggler
                , viewOneLightSelect
                ]
            , div [ class "play-one__container--flex" ]
                [ viewOneCircularButton
                ]
            , div [ class "play-one__container--flex" ]
                [ viewOneLinksButton
                ]
            ]
        , section [ class <| "dark-container play-one__container " ++ addAnimation ]
            [ viewOneClipPath
            ]
        ]


viewOneLightToggler : Html Msg
viewOneLightToggler =
    div [ class "light-container__toggle-container" ] <|
        [ label
            [ class "toggle" ]
            [ input
                [ type_ "checkbox"
                , class "toggle__checkbox"
                ]
                []
            , div [ class "toggle__appearance white-shadow" ]
                [ span [] []
                ]
            ]
        , label
            [ class "toggle" ]
            [ input
                [ type_ "checkbox"
                , class "toggle__checkbox"
                , attribute "checked" ""
                ]
                []
            , div [ class "toggle__appearance white-shadow" ]
                [ span [] []
                ]
            ]
        ]


viewOneLightSelect : Html Msg
viewOneLightSelect =
    div [ class "select-cover white-shadow" ]
        [ div [ class "select-cover__false-select" ]
            [ text "Dropdown"

            -- , Svg.oneLightSelectArrow
            ]
        , select [ class "select-cover__select" ]
            [ option [] [ text "Dropdown" ]
            ]
        ]
        |> List.repeat 2
        |> div [ class "light-container__select-container" ]


viewOneCircularButton : Html Msg
viewOneCircularButton =
    button [ class "white-shadow btm" ]
        [-- Svg.play
        ]
        |> List.repeat 4
        |> div [ class "light-container__circular-button-container" ]


viewOneLinksButton : Html Msg
viewOneLinksButton =
    a [ class "white-shadow link", href "" ]
        [ text "YouTube"
        ]
        |> List.repeat 2
        |> div [ class "light-container__link-button" ]


viewOneClipPath : Html Msg
viewOneClipPath =
    div [ class "clip-path" ]
        [ h1 [] [ text "Super Clip-Path width animation" ]
        , p []
            [ text
                """
                Press the button for a animate the background,
                this isn't something good form rendering and performance,
                bud was fun to build.
                """
            , br [] []
            , br [] []
            , text """
                The thing is, the text color change with background what I think is pretty cool.
                """
            ]
        , div [ class "clip-path__ctnr-btm" ]
            [ button
                [ class "clip-path__btm"
                , onClick Spin
                ]
                [ text "Click To Spin" ]
            ]
        ]

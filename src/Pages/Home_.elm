module Pages.Home_ exposing (Model, Msg, page)

import Gen.Params.Home_ exposing (Params)
import Gen.Route as Route exposing (Route)
import Html exposing (Html, a, article, br, div, h1, h2, h3, main_, p, section, span, strong, text)
import Html.Attributes exposing (attribute, class, id, style)
import Html.Events exposing (onClick)
import Page exposing (Page)
import Preview.Kelpie.Kelpie as Kelpie exposing (view)
import Request exposing (Request)
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
    , scrollSample : Bool
    }


init : Model
init =
    { route = Route.Home_
    , scrollSample = False
    }



-- UPDATE


type Msg
    = ShowSample


update : Msg -> Model -> Model
update msg model =
    case msg of
        ShowSample ->
            { model | scrollSample = not model.scrollSample }



-- VIEW


view : Model -> View Msg
view model =
    { title = "Johann - Home"
    , body =
        UI.layout model.route
            [ viewMainContent
            , viewOtherProjects model
            ]
    }



-- Main Content


viewMainContent : Html Msg
viewMainContent =
    article [ class "main-home" ]
        [ div [ class "main-home__container", attribute "transitionOne" "" ]
            [ h1 [ class "main-home__medium-title" ]
                [ text "Johann Gonçalves Pereira"
                ]
            , h2
                [ class "main-home__big-title" ]
                [ span [ class "main-home__big-title--no-break" ] [ text "Front-End " ]
                , text "Developer"
                ]
            , h2 [ class "main-home__big-title" ]
                [ text "UI Developer"
                ]
            ]
        ]



-- Projects Content


viewOtherProjects : Model -> Html Msg
viewOtherProjects model =
    div [ class "cards" ]
        [ h3
            [ class "cards__title" ]
            [ span [] [ text "Other" ]
            , span [] [ text "Projects" ]
            ]
        , div [ class "cards__container" ] <|
            viewProjects model
        ]


viewProjects : Model -> List (Html Msg)
viewProjects model =
    let
        container funcContent =
            div [ class <| "project" ] funcContent
    in
    [ container <| kelpie model
    ]


boldText : String -> Html Msg
boldText word =
    strong [] [ text <| " " ++ word ]


kelpie : Model -> List (Html Msg)
kelpie model =
    let
        isOverflowHidden =
            if model.scrollSample == True then
                style "overflow" "auto"

            else
                style "overflow" "hidden"

        isSpanDisplayed =
            if model.scrollSample == True then
                style "transform" "scale(0)"

            else
                style "transform" "scale(1)"
    in
    [ section [ class "project__information" ]
        [ p []
            [ boldText "Kelpie"
            , text <|
                " was a personal project I did in my spare time. "
                    ++ "It helped me to understand the basics of"
            , boldText "Elm"
            , text <|
                ", but what this project gave me the most was "
                    ++ "the absurd advance I had learning"
            , boldText "Css/Scss."
            ]
        , br [] []
        , p []
            [ text <|
                "This was my first attempt to make a website by myself"
                    ++ ", not copying from a course or a teacher."
            ]
        , br [] []
        , p []
            [ text "The site is obviously based on "
            , a [] [ text "Unsplash" ]
            , text ". It's just a personal site not a comercial one."
            ]
        ]
    , section [ class "project__content" ]
        [ List.concat
            [ [ span
                    [ class "project-sample-block"
                    , onClick ShowSample
                    , isSpanDisplayed
                    ]
                    [ span []
                        [ text "click to see the sample"
                        ]
                    ]
              ]
            , Kelpie.view
            ]
            |> div
                [ id "kelpie-container"
                , isOverflowHidden
                ]
        ]
    ]

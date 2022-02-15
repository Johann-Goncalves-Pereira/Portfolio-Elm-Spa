module Pages.Home_ exposing (Model, Msg, page)

import Browser.Dom exposing (Viewport, getViewport)
import Browser.Events as BrowserE
import DOM exposing (offsetWidth, target)
import Effect
import Gen.Params.Home_ exposing (Params)
import Gen.Route as Route exposing (Route)
import Html exposing (Attribute, Html, a, article, b, br, div, h1, h2, h3, img, main_, p, section, span, strong, text)
import Html.Attributes exposing (attribute, class, id, src, style)
import Html.Events exposing (on, onClick)
import Html.Events.Extra.Mouse as EMouse
import Json.Decode as Decode exposing (Decoder)
import Page exposing (Page)
import Preview.Kelpie.Kelpie as Kelpie exposing (view)
import Request exposing (Request)
import Round
import Shared exposing (subscriptions)
import Svg.Base as MSvg
import Task
import UI
import View exposing (View)


type alias EventWithMovement =
    { mouseEvent : EMouse.Event
    , movement : ( Float, Float )
    }


page : Shared.Model -> Request.With Params -> Page.With Model Msg
page shared req =
    Page.element
        { init = init
        , subscriptions = subWidthSize
        , update = update
        , view = view
        }



-- INIT


type alias Model =
    { route : Route
    , scrollSample : Bool
    , windowWidth : Int
    , mousePosition : ( Float, Float )
    }


init : ( Model, Cmd Msg )
init =
    ( { route = Route.Home_
      , scrollSample = False
      , windowWidth = 0
      , mousePosition = ( 0, 0 )
      }
    , Task.perform GotViewPort getViewport
    )



-- UPDATE


type Msg
    = ShowSample
    | GotViewPort Viewport
    | GotNewWidth Int
    | MouseMovement ( Float, Float )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ShowSample ->
            ( { model | scrollSample = not model.scrollSample }, Cmd.none )

        GotNewWidth screenSize ->
            ( { model
                | windowWidth =
                    screenSize
              }
            , Cmd.none
            )

        GotViewPort viewport ->
            ( { model
                | windowWidth =
                    truncate
                        viewport.viewport.width
              }
            , Cmd.none
            )

        MouseMovement ( x, y ) ->
            ( { model | mousePosition = ( x, y ) }, Cmd.none )


decodeWithMovement : Decoder EventWithMovement
decodeWithMovement =
    Decode.map2 EventWithMovement
        EMouse.eventDecoder
        movementDecoder


movementDecoder : Decoder ( Float, Float )
movementDecoder =
    Decode.map2 (\a b -> ( a, b ))
        (Decode.field "offsetX" Decode.float)
        (Decode.field "offsetY" Decode.float)


onMove : (EventWithMovement -> msg) -> Html.Attribute msg
onMove tag =
    let
        decoder =
            decodeWithMovement
                |> Decode.map tag
                |> Decode.map options

        options message =
            { message = message
            , stopPropagation = False
            , preventDefault = True
            }
    in
    Html.Events.custom "mousemove" decoder



-- Subscription


subWidthSize : model -> Sub Msg
subWidthSize _ =
    BrowserE.onResize (\w _ -> GotNewWidth w)



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
        , div
            [ class "cards__container"
            ]
          <|
            viewProjects model
        ]


coordinatesVariables : Model -> Html.Attribute Msg
coordinatesVariables model =
    let
        roundAxes : Float -> String
        roundAxes axes =
            Round.round 2 axes

        mX : Float
        mX =
            Tuple.first model.mousePosition

        -- mY : Float
        -- mY =
        --     Tuple.second model.mousePosition
        sizeContainer : Float -> Float
        sizeContainer axes =
            axes * 100 / 500

        degCalc : Float -> Float
        degCalc axes =
            sizeContainer axes * axes / 360

        -- 500 - 100
        -- 0 - 0
        --
        -- 100 - -10
        -- 0 -
        --? X = 500 -> 10deg
        --? X = 250 -> 0deg
        --? X = 0 -> -10deg
        --
        --? Y = 500 -> -10deg
        --? Y = 250 -> 0deg
        --? Y = 0 -> 10deg
        invertX : Float
        invertX =
            degCalc mX

        -- if mX > 250 then
        -- sizeContainer mX
        -- else
        -- invertY : Float
        -- invertY =
        --     if mY <= 330 then
        --         sizeContainer mY
        --     else
        --         sizeContainer mY * -1
    in
    "--x:"
        ++ roundAxes mX
        ++ ";--y:"
        -- ++ roundAxes mY
        ++ ";--ctnr-x:"
        ++ roundAxes invertX
        ++ "deg;--ctnr-y:"
        -- ++ roundAxes invertY
        ++ "deg;"
        |> attribute "style"


getWidthElement : Html.Attribute Float
getWidthElement =
    on "click" (target offsetWidth)


viewProjects : Model -> List (Html Msg)
viewProjects model =
    let
        container funcContent =
            div [ class <| "project" ] funcContent
    in
    [ container <| kelpie model
    , div [] <| blobsInfo model
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
    , section
        [ class "project__content"
        , onMove (.movement >> MouseMovement)
        , coordinatesVariables model
        ]
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


blobsInfo : Model -> List (Html Msg)
blobsInfo model =
    [ section [ class "blobs-info" ]
        -- List.repeat 4 <|
        [ div [ class "blobs-info__content" ]
            [ MSvg.rocket <| Just "icon"
            , div [ class "txt" ]
                [ strong [ class "txt__title" ] [ text "Get the design" ]
                , p [ class "txt__text" ]
                    [ text
                        """
                        The first thing that I usually do when starting a new project,
                        It's talk with the design about what I need to do, if I need to 
                        made the page based on a figma or framer pre build. 
                        """
                    , br [] []
                    , br [] []
                    , text "Maybe I need to need to make the design by myself."
                    ]
                ]
            , div [ class "number" ] [ b [] [ text "01" ] ]
            ]
        , div [ class "blobs-info__content" ]
            [ MSvg.code <| Just "icon"
            , div [ class "txt" ]
                [ strong [ class "txt__title" ] [ text "Start to Code" ]
                , p [ class "txt__text" ]
                    [ text
                        """
                        Then before making the design I start to code, if possible I
                        like to use the tools that I'm used to.
                        """
                    , br [] []
                    , br [] []
                    , text "Elm, Scss, Html, ReactNative"
                    ]
                ]
            , div [ class "number" ] [ b [] [ text "02" ] ]
            ]
        , div [ class "blobs-info__content" ]
            [ MSvg.lineS <| Just "icon"
            , div [ class "txt" ]
                [ strong [ class "txt__title" ] [ text "Bugs and updates" ]
                , p [ class "txt__text" ]
                    [ text
                        """
                        You always need to improve something on the code,
                        and fix some bugs.
                        """
                    , br [] []
                    , br [] []
                    , text "And I can make this with a team or just by myself."
                    ]
                ]
            , div [ class "number" ] [ b [] [ text "03" ] ]
            ]
        , div [ class "blobs-info__content" ]
            [ MSvg.infinite <| Just "icon"
            , div [ class "txt" ]
                [ strong [ class "txt__title" ] [ text "Never stops" ]
                , p [ class "txt__text" ]
                    [ text
                        """
                        Software never stops, just keeps growing and getting more better.
                        
                        """
                    ]
                ]
            , div [ class "number" ] [ b [] [ text "04" ] ]
            ]
        ]
    ]

module Pages.Home_ exposing (Model, Msg, page)

import Browser.Dom exposing (Viewport, getViewport)
import Browser.Events as BrowserE
import Gen.Params.Home_ exposing (Params)
import Gen.Route as Route exposing (Route)
import Html
    exposing
        ( Attribute
        , Html
        , a
        , b
        , br
        , div
        , h1
        , h2
        , h3
        , p
        , section
        , span
        , strong
        , text
        )
import Html.Attributes exposing (attribute, class, id, style)
import Html.Events exposing (onClick)
import Json.Decode as Decode exposing (Decoder)
import Page
import Pages.Components.Mouse as Mouse
import Preview.Kelpie.Kelpie as Kelpie exposing (view)
import Random
import Request
import Round
import Shared
import Svg.Base as MSvg
import Task
import UI exposing (defaultConfig)
import View exposing (View)


page : Shared.Model -> Request.With Params -> Page.With Model Msg
page shared req =
    Page.element
        { init = init
        , subscriptions = subscriptionSize
        , update = update
        , view = view
        }



-- INIT


type alias Model =
    { route : Route
    , showProjectContent : Bool
    , pageColor : Int
    , sectionSize : ( Int, Int )
    , componentMouse : Mouse.Mouse

    -- , uiModel : UI.Model Msg
    }


init : ( Model, Cmd Msg )
init =
    ( { route = Route.Home_
      , showProjectContent = False
      , pageColor = 0
      , sectionSize = ( 0, 0 )
      , componentMouse = Mouse.init

      --   , uiModel = UI.defaultSettings
      }
    , Cmd.batch
        [ Task.perform GotViewPort getViewport
        , Random.int 1 360
            |> Random.generate PeekColor
        ]
    )



-- UPDATE


type Msg
    = ShowSample
    | PeekRandomColor
    | PeekColor Int
    | GotViewPort Viewport
    | GotNewSize ( Int, Int )
    | ComponentMouseMsg Mouse.MsgMouse


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ShowSample ->
            ( { model | showProjectContent = not model.showProjectContent }, Cmd.none )

        PeekRandomColor ->
            ( model, Random.generate PeekColor (Random.int 1 360) )

        PeekColor clr ->
            ( { model | pageColor = clr }, Cmd.none )

        GotNewSize sSize ->
            ( { model
                | sectionSize =
                    sSize
              }
            , Cmd.none
            )

        GotViewPort viewport ->
            let
                sizeWidth =
                    truncate viewport.viewport.width

                sizeHeight =
                    truncate viewport.viewport.height
            in
            ( { model
                | sectionSize = ( sizeWidth, sizeHeight )
              }
            , Cmd.none
            )

        ComponentMouseMsg mouseMsg ->
            ( { model | componentMouse = Mouse.update mouseMsg model.componentMouse }, Cmd.none )



-- Subscription


subscriptionSize : Model -> Sub Msg
subscriptionSize _ =
    BrowserE.onResize (\w h -> GotNewSize ( w, h ))



-- VIEW


view : Model -> View Msg
view model =
    { title = "Johann - Home"
    , body =
        UI.layout
            { defaultConfig
                | route = Route.Home_
                , pageMainColor = Just model.pageColor
                , pageName = "home"
                , mainTagContent =
                    [ viewMainContent model
                    , viewOtherProjects model
                    ]
            }
    }



-- Main Content


viewMainContent : Model -> Html Msg
viewMainContent model =
    section [ class "home" ]
        [ div [ class "home__container" ]
            [ h1 [ class "home__medium-title" ]
                [ text "Johann Gonçalves Pereira"
                ]
            , h2
                [ class "home__big-title" ]
                [ span [ class "home__big-title--no-break" ] [ text "Front-End " ]
                , text "Developer"
                ]
            , h2 [ class "home__big-title" ]
                [ text "UI Developer"
                ]
            ]
        , viewPageChosenColor model
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


calcDeg : Model -> ( Float, Float )
calcDeg model =
    let
        windowSize : Float
        windowSize =
            toFloat <| Tuple.first model.sectionSize

        size : Float
        size =
            875 * windowSize / 1250

        -- 852 = 1925
        -- x = 730
        width : Float
        width =
            size / 2

        height : Float
        height =
            45 * 16 / 2

        mouseX =
            Mouse.xOffsetPos model.componentMouse

        mouseY =
            Mouse.yOffsetPos model.componentMouse

        correctMousePositionX : Float
        correctMousePositionX =
            if mouseX < 0 then
                0

            else if mouseX > size then
                size

            else
                mouseX

        correctMousePositionY : Float
        correctMousePositionY =
            if mouseY < 0 then
                0

            else if mouseY > size then
                size

            else
                mouseY

        posX : Float
        posX =
            (correctMousePositionX - width) * -1

        posY : Float
        posY =
            correctMousePositionY - height

        maxDepth : Float -> Float
        maxDepth pos =
            if pos * 10 / 250 < -10 then
                -10

            else if pos * 10 / 250 > 10 then
                10

            else
                pos * 10 / 250

        depthX : Float
        depthX =
            maxDepth posX

        depthY : Float
        depthY =
            maxDepth posY

        --! How to debug in elm
        -- _ =
        --     Debug.log "Depth" ( depthX, depthY )
    in
    if posX * posY < 0 then
        ( depthX * -1, depthY * -1 )

    else
        ( depthX, depthY )


coordinatesVariables : Model -> Html.Attribute Msg
coordinatesVariables model =
    let
        ( x, y ) =
            calcDeg model
    in
    if model.showProjectContent then
        attribute "style" "--rotate-ctnr: 6deg;"

    else
        "--mouse-pos-x:"
            ++ Round.round 2 x
            ++ "deg;--mouse-pos-y:"
            ++ Round.round 2 y
            ++ "deg;"
            |> attribute "style"



--


viewProjects : Model -> List (Html Msg)
viewProjects model =
    let
        container funcContent =
            div [ class <| "project" ] funcContent
    in
    [ container <| kelpie model
    , div [] <| blobsInfo model
    ]


viewPageChosenColor : Model -> Html Msg
viewPageChosenColor model =
    div [ class "chosen-color", onClick <| PeekRandomColor ]
        [ MSvg.circleColors <| model.pageColor ]


boldText : String -> Html Msg
boldText word =
    strong [] [ text <| " " ++ word ]


kelpie : Model -> List (Html Msg)
kelpie model =
    let
        isOverflowHidden =
            if model.showProjectContent == True then
                style "overflow" "auto"

            else
                style "overflow" "hidden"

        isSpanDisplayed =
            if model.showProjectContent == True then
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
        , Mouse.onChangeOffsetPosition ComponentMouseMsg
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

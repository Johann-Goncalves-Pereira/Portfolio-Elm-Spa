module Svg.Base exposing (..)

import Html exposing (Html)
import Svg
    exposing
        ( defs
        , g
        , metadata
        , svg
        )
import Svg.Attributes exposing (..)


rocket : Maybe String -> Html msg
rocket addClass =
    svg
        [ width "80", height "80", viewBox "0 0 80 80", fill "none", class <| Maybe.withDefault "" addClass ]
        [ Svg.path
            [ fillRule "evenodd"
            , clipRule "evenodd"
            , d "M40.0738 10.6969C40.219 10.5724 40.4333 10.5724 40.5785 10.6969L44.1462 13.7549C50.6075 19.2932 54.3262 27.3783 54.3262 35.8883C54.3262 38.9311 53.8498 41.955 52.9144 44.8504L46.1106 65.9096C46.0007 66.25 45.6838 66.4806 45.3262 66.4806H35.3262C34.9685 66.4806 34.6517 66.25 34.5417 65.9096L27.738 44.8504C26.8025 41.955 26.3262 38.9311 26.3262 35.8883C26.3262 27.3783 30.0448 19.2932 36.5061 13.7549L40.0738 10.6969ZM42.9242 25.9808C41.3166 25.0526 39.3358 25.0526 37.7281 25.9808C36.1204 26.909 35.13 28.6244 35.13 30.4808C35.13 32.3372 36.1204 34.0526 37.7281 34.9808C39.3358 35.909 41.3166 35.909 42.9242 34.9808C44.5319 34.0526 45.5223 32.3372 45.5223 30.4808C45.5223 28.6244 44.5319 26.909 42.9242 25.9808Z"
            , fill "var(--clr-text)"
            ]
            []
        , Svg.path
            [ d "M24.7659 45.4014L19.88 50.2869C17.7074 52.4593 16.9714 55.6843 17.9863 58.5842L21.5086 68.6478C21.8253 69.5526 22.9787 69.8156 23.6562 69.1375L30.2892 62.505L24.8836 45.7735C24.8436 45.6497 24.8043 45.5256 24.7659 45.4014Z"
            , fill "var(--clr-text)"
            ]
            []
        , Svg.path
            [ d "M50.2043 62.999L56.3425 69.1372C57.021 69.8158 58.1755 69.5523 58.4925 68.6466L62.0135 58.5865C63.0288 55.6858 62.2926 52.4599 60.1195 50.2868L55.7296 45.8969L50.2043 62.999Z"
            , fill "var(--clr-text)"
            ]
            []
        ]


code : Maybe String -> Html msg
code addClass =
    svg
        [ width "24"
        , height "24"
        , viewBox "0 0 24 24"
        , fill "none"
        , class <| Maybe.withDefault "" addClass
        ]
        [ Svg.path [ d "M13.3252 3.05011L8.66765 20.4323L10.5995 20.9499L15.257 3.56775L13.3252 3.05011Z", fill "var(--clr-text)" ] []
        , Svg.path [ d "M7.61222 18.3608L8.97161 16.9124L8.9711 16.8933L3.87681 12.1121L8.66724 7.00798L7.20892 5.63928L1.0498 12.2017L7.61222 18.3608Z", fill "var(--clr-text)" ] []
        , Svg.path [ d "M16.3883 18.3608L15.0289 16.9124L15.0294 16.8933L20.1237 12.1121L15.3333 7.00798L16.7916 5.63928L22.9507 12.2017L16.3883 18.3608Z", fill "var(--clr-text)" ] []
        ]


lineS : Maybe String -> Html msg
lineS addClass =
    svg
        [ width "24"
        , height "24"
        , viewBox "0 0 24 24"
        , fill "none"
        , class <| Maybe.withDefault "" addClass
        ]
        [ Svg.path
            [ d
                "M6 8C6.74028 8 7.38663 7.5978 7.73244 7H14C15.1046 7 16 7.89543 16 9C16 10.1046 15.1046 11 14 11H10C7.79086 11 6 12.7909 6 15C6 17.2091 7.79086 19 10 19H16.2676C16.6134 19.5978 17.2597 20 18 20C19.1046 20 20 19.1046 20 18C20 16.8954 19.1046 16 18 16C17.2597 16 16.6134 16.4022 16.2676 17H10C8.89543 17 8 16.1046 8 15C8 13.8954 8.89543 13 10 13H14C16.2091 13 18 11.2091 18 9C18 6.79086 16.2091 5 14 5H7.73244C7.38663 4.4022 6.74028 4 6 4C4.89543 4 4 4.89543 4 6C4 7.10457 4.89543 8 6 8Z"
            , fill "var(--clr-text)"
            ]
            []
        ]


infinite : Maybe String -> Html msg
infinite addClass =
    svg
        [ width "24"
        , height "24"
        , viewBox "0 0 24 24"
        , fill "none"
        , class <| Maybe.withDefault "" addClass
        ]
        [ Svg.path
            [ d "M8.12132 9.87868L10.2044 11.9617L10.2106 11.9555L11.6631 13.408L11.6693 13.4142L13.7907 15.5355C15.7433 17.4882 18.9091 17.4882 20.8617 15.5355C22.8144 13.5829 22.8144 10.4171 20.8617 8.46447C18.9091 6.51184 15.7433 6.51184 13.7907 8.46447L13.0773 9.17786L14.4915 10.5921L15.2049 9.87868C16.3764 8.70711 18.2759 8.70711 19.4475 9.87868C20.6191 11.0503 20.6191 12.9497 19.4475 14.1213C18.2759 15.2929 16.3764 15.2929 15.2049 14.1213L13.1326 12.0491L13.1263 12.0554L9.53553 8.46447C7.58291 6.51184 4.41709 6.51184 2.46447 8.46447C0.511845 10.4171 0.511845 13.5829 2.46447 15.5355C4.41709 17.4882 7.58291 17.4882 9.53553 15.5355L10.2488 14.8222L8.83463 13.408L8.12132 14.1213C6.94975 15.2929 5.05025 15.2929 3.87868 14.1213C2.70711 12.9497 2.70711 11.0503 3.87868 9.87868C5.05025 8.70711 6.94975 8.70711 8.12132 9.87868Z"
            , fill "var(--clr-text)"
            ]
            []
        ]


circleColors : Int -> Html msg
circleColors deg =
    svg [ version "1.1", width "100%", height "100%", viewBox "-10 -10 220 220", style <| "--rotation:" ++ String.fromInt -deg ++ "deg;" ]
        [ defs []
            [ Svg.linearGradient [ id "redyel", gradientUnits "objectBoundingBox", x1 "0", y1 "0", x2 "1", y2 "1" ] [ Svg.stop [ offset "0%", stopColor "#ff0000" ] [], Svg.stop [ offset "100%", stopColor "#ffff00" ] [] ]
            , Svg.linearGradient [ id "yelgre", gradientUnits "objectBoundingBox", x1 "0", y1 "0", x2 "0", y2 "1" ] [ Svg.stop [ offset "0%", stopColor "#ffff00" ] [], Svg.stop [ offset "100%", stopColor "#00ff00" ] [] ]
            , Svg.linearGradient [ id "grecya", gradientUnits "objectBoundingBox", x1 "1", y1 "0", x2 "0", y2 "1" ] [ Svg.stop [ offset "0%", stopColor "#00ff00" ] [], Svg.stop [ offset "100%", stopColor "#00ffff" ] [] ]
            , Svg.linearGradient [ id "cyablu", gradientUnits "objectBoundingBox", x1 "1", y1 "1", x2 "0", y2 "0" ] [ Svg.stop [ offset "0%", stopColor "#00ffff" ] [], Svg.stop [ offset "100%", stopColor "#0000ff" ] [] ]
            , Svg.linearGradient [ id "blumag", gradientUnits "objectBoundingBox", x1 "0", y1 "1", x2 "0", y2 "0" ] [ Svg.stop [ offset "0%", stopColor "#0000ff" ] [], Svg.stop [ offset "100%", stopColor "#ff00ff" ] [] ]
            , Svg.linearGradient [ id "magred", gradientUnits "objectBoundingBox", x1 "0", y1 "1", x2 "1", y2 "0" ] [ Svg.stop [ offset "0%", stopColor "#ff00ff" ] [], Svg.stop [ offset "100%", stopColor "#ff0000" ] [] ]
            ]
        , g [ fill "none", strokeWidth "15", transform "translate(100,100)" ]
            [ Svg.path [ d "M 0,-100 A 100,100 0 0,1 86.6,-50", stroke "url(#redyel)" ] []
            , Svg.path [ d "M 86.6,-50 A 100,100 0 0,1 86.6,50", stroke "url(#yelgre)" ] []
            , Svg.path [ d "M 86.6,50 A 100,100 0 0,1 0,100", stroke "url(#grecya)" ] []
            , Svg.path [ d "M 0,100 A 100,100 0 0,1 -86.6,50", stroke "url(#cyablu)" ] []
            , Svg.path [ d "M -86.6,50 A 100,100 0 0,1 -86.6,-50", stroke "url(#blumag)" ] []
            , Svg.path [ d "M -86.6,-50 A 100,100 0 0,1 0,-100", stroke "url(#magred)" ] []
            ]
        ]
